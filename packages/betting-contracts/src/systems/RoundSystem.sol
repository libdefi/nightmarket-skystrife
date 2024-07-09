// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { Config, Rounds, RoundsData, Teams, TeamsData, Bets, BetsData } from "../codegen/index.sol";

import { MatchConfig, MatchRanking, MatchFinished, CreatedByAddress } from "contracts/src/codegen/index.sol";
import { entityToAddress } from "contracts/src/libraries/LibUtils.sol";

contract RoundSystem is System {
  uint256 public constant COMMISSION_RATE = 5; // 0.5% (5 / 1000)

  function createRound(
    uint256 _betPeriod,
    address[] memory _playerAddresses,
    string[] memory _names,
    uint8[] memory _teamIds,
    string memory _title
  ) public {
    require(_betPeriod >= block.timestamp, "The betting due is past.");
    require(_playerAddresses.length == _names.length, "Incorrect registered players.");
    require(_names.length == _teamIds.length, "Names and Team IDs arrays must have the same length.");

    bytes32 _roundId = _incrementRoundId();
    bool hasTeam1 = false;
    bool hasTeam2 = false;

    uint8[] memory uniqueTeamIds = new uint8[](_teamIds.length);
    string[] memory uniqueTeamNames = new string[](_names.length);
    uint uniqueCount = 0;

    for (uint i = 0; i < _names.length; i++) {
      if (_teamIds[i] == 1) hasTeam1 = true;
      if (_teamIds[i] == 2) hasTeam2 = true;

      bool exists = false;
      for (uint j = 0; j < uniqueCount; j++) {
        if (uniqueTeamIds[j] == _teamIds[i]) {
          exists = true;
          break;
        }
      }

      if (!exists) {
        uniqueTeamIds[uniqueCount] = _teamIds[i];
        uniqueTeamNames[uniqueCount] = _names[i];
        uniqueCount++;
      }
    }

    require(hasTeam1, "Team ID 1 is missing in _teamIds array.");
    require(hasTeam2, "Team ID 2 is missing in _teamIds array.");

    Rounds.set(_roundId, RoundsData(_msgSender(), _betPeriod, false, 0, _playerAddresses, _teamIds, _title));

    for (uint i = 0; i < uniqueCount; i++) {
      Teams.set(_roundId, uniqueTeamIds[i], 0, false, new address[](0), uniqueTeamNames[i]);
    }
  }

  function _incrementRoundId() internal returns (bytes32 newRoundId_) {
    newRoundId_ = bytes32(uint256(Config.get()) + 1);
    Config.set(newRoundId_);
  }

  function resolution(bytes32 _roundId, bytes32 matchEntity) public {
    RoundsData memory _RoundsData = Rounds.get(_roundId);

    require(!_RoundsData.matchFinished, "The match has already finished");

    address[] memory addresses = _RoundsData.playerAddresses;
    uint256 betPeriod = _RoundsData.betPeriod;

    // START KOOSHABA STUFF

    address bettingMarketWorld = _world();
    StoreSwitch.setStoreAddress(address(0x9d05Cc196C87104A7196FCcA41280729B505DBbf));

    validateMatchData(matchEntity, addresses, betPeriod);

    address winnerAddress = findWinnerAddress(matchEntity, addresses);
    require(winnerAddress != address(0), "Invalid winner address");

    StoreSwitch.setStoreAddress(bettingMarketWorld);

    // END KOOSHABA STUFF

    uint8 winnerTeamId = findWinnerTeamId(_roundId, winnerAddress);
    require(winnerTeamId != 0, "Invalid teamId");

    Teams.setWinner(_roundId, winnerTeamId, true);
    TeamsData memory _TeamsData = Teams.get(_roundId, winnerTeamId);

    uint256 odds = _calculateOdds(_RoundsData.betAmount, _TeamsData.betAmount);
    _distributeWinnerAmounts(_roundId, winnerTeamId, odds, _TeamsData.betAddresses);

    // Fee remittance to Round Creator
    uint256 totalCommission = (_RoundsData.betAmount * COMMISSION_RATE) / 1000;
    payable(_RoundsData.roundCreator).transfer(totalCommission);

    Rounds.setMatchFinished(_roundId, true);
  }

  function validateMatchData(bytes32 matchEntity, address[] memory addresses, uint256 betPeriod) internal view {
    uint256 startTime = MatchConfig.getStartTime(matchEntity);
    require(startTime >= betPeriod, "Invalid match time");

    bool matchFinished = MatchFinished.get(matchEntity);
    require(matchFinished, "The match has not finished yet");

    bytes32[] memory playerEntityRanking = MatchRanking.get(matchEntity);
    require(playerEntityRanking.length == addresses.length, "Incorrect number of players in match");
  }

  function findWinnerAddress(bytes32 matchEntity, address[] memory addresses) internal view returns (address) {
    bytes32[] memory playerEntityRanking = MatchRanking.get(matchEntity);
    address[] memory playerAddresses = new address[](playerEntityRanking.length);
    for (uint256 i = 0; i < playerEntityRanking.length; i++) {
      playerAddresses[i] = entityToAddress(CreatedByAddress.get(matchEntity, playerEntityRanking[i]));
    }

    for (uint256 i = 0; i < addresses.length; i++) {
      bool found = false;
      for (uint256 j = 0; j < playerAddresses.length; j++) {
        if (addresses[i] == playerAddresses[j]) {
          found = true;
          break;
        }
      }
      require(found, "Player address not found");
    }

    return playerAddresses[0];
  }

  function findWinnerTeamId(bytes32 _roundId, address winnerAddress) internal view returns (uint8) {
    address[] memory playersAddresses = Rounds.getPlayerAddresses(_roundId);
    uint8[] memory playersTeamIds = Rounds.getTeamIds(_roundId);

    for (uint256 i = 0; i < playersAddresses.length; i++) {
      if (playersAddresses[i] == winnerAddress) {
        return playersTeamIds[i];
      }
    }

    return 0;
  }

  // Calculate Odds
  function _calculateOdds(uint256 totalBetAmount, uint256 teamBetAmount) internal pure returns (uint256) {
    return (totalBetAmount * 1000) / teamBetAmount;
  }

  // Distribute winners' dividends
  function _distributeWinnerAmounts(
    bytes32 _roundId,
    uint8 winnerTeamId,
    uint256 odds,
    address[] memory betAddresses
  ) internal {
    for (uint256 i = 0; i < betAddresses.length; i++) {
      address betAddress = betAddresses[i];
      BetsData memory _BetData = Bets.get(_roundId, winnerTeamId, betAddress);
      uint256 winnings = (_BetData.amount * odds * (1000 - COMMISSION_RATE)) / 1000000; // commission deducted.
      Bets.setWinnerAmount(_roundId, winnerTeamId, betAddress, winnings);
    }
  }
}
