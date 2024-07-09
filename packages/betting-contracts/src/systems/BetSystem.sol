// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { Config, Rounds, RoundsData, Teams, TeamsData, Bets, BetsData } from "../codegen/index.sol";

contract BetSystem is System {
  function placeBet(bytes32 _roundId, uint8 _teamId, uint256 _amount) public payable {
    require(msg.value == _amount, "ETH amount is not equal to the amount specified.");
    require(_amount > 0, "Bet amount must be greater than zero.");

    uint256 roundBetAmount = Rounds.getBetAmount(_roundId);
    Rounds.setBetAmount(_roundId, roundBetAmount + _amount);

    uint256 teamBetAmount = Teams.getBetAmount(_roundId, _teamId);
    Teams.setBetAmount(_roundId, _teamId, teamBetAmount + _amount);

    uint256 userBetAmount = Bets.getAmount(_roundId, _teamId, msg.sender);

    if (userBetAmount == 0) {
      string memory roundTitle = Rounds.getTitle(_roundId);
      string memory teamName = Teams.getName(_roundId, _teamId);
      Bets.set(_roundId, _teamId, msg.sender, _amount, 0, roundTitle, teamName);
      Teams.pushBetAddresses(_roundId, _teamId, msg.sender);
    } else {
      Bets.setAmount(_roundId, _teamId, msg.sender, userBetAmount + _amount);
    }
  }

  function winnerWithdraw(bytes32 _roundId, uint8 _teamId) public {
    bool matchFinished = Rounds.getMatchFinished(_roundId);
    require(matchFinished, "The match is not finished yet.");

    uint256 betPeriodEnd = Rounds.getBetPeriod(_roundId);
    require(block.timestamp > betPeriodEnd, "The betting period is not over yet.");

    uint256 winnerAmount = Bets.getWinnerAmount(_roundId, _teamId, msg.sender);
    require(winnerAmount > 0, "No winnings to withdraw.");

    payable(msg.sender).transfer(winnerAmount);

    Bets.setWinnerAmount(_roundId, _teamId, msg.sender, 0);
  }

  // User can Withdraw if more than 30 days has passed since bettingPeriod and status remains NotStarted
  function refundWithdraw(bytes32 _roundId, uint8 _teamId) public {
    bool matchFinished = Rounds.getMatchFinished(_roundId);
    require(!matchFinished, "The match has already finished.");

    uint256 betPeriodEnd = Rounds.getBetPeriod(_roundId);
    require(block.timestamp > betPeriodEnd + 30 days, "The betting period is not over 30 days yet.");

    uint256 betAmount = Bets.getAmount(_roundId, _teamId, msg.sender);
    require(betAmount > 0, "No bets to refund.");
    Bets.setAmount(_roundId, _teamId, msg.sender, 0);

    uint256 roundBetAmount = Rounds.getBetAmount(_roundId);
    Rounds.setBetAmount(_roundId, roundBetAmount - betAmount);

    uint256 teamBetAmount = Teams.getBetAmount(_roundId, _teamId);
    Teams.setBetAmount(_roundId, _teamId, teamBetAmount - betAmount);

    payable(msg.sender).transfer(betAmount);
  }
}
