// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { Config, Rounds, RoundsData, Teams, TeamsData, Bets, BetsData } from "../codegen/index.sol";
contract ViewSystem is System {
  function getConfigId() public view returns (bytes32) {
    return bytes32(uint256(Config.get()));
  }

  function getRound(bytes32 _roundId) public view returns (RoundsData memory) {
    return Rounds.get(_roundId);
  }

  function getTeams(bytes32 _roundId, uint8 _teamId) public view returns (TeamsData memory) {
    return Teams.get(_roundId, _teamId);
  }

  function getBets(bytes32 _roundId, uint8 _teamId, address _betterAddress) public view returns (BetsData memory) {
    return Bets.get(_roundId, _teamId, _betterAddress);
  }
}
