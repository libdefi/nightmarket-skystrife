// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

import "forge-std/Script.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { IWorld } from "../src/codegen/world/IWorld.sol";

// table imports
import { MatchConfig, MatchRanking, MatchFinished, CreatedByAddress } from "../src/codegen/index.sol";
import { entityToAddress } from "../src/libraries/LibUtils.sol";

import "forge-std/console.sol";

contract ReadMatchDataForBets is Script {
  function run(address worldAddress) external {
    IWorld world = IWorld(worldAddress);
    StoreSwitch.setStoreAddress(worldAddress);

    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
    vm.startBroadcast(deployerPrivateKey);

    bytes32 matchEntity = bytes32(0x336f1c1400000000000000000000000000000000000000000000000000000000);
    uint256 startTime = MatchConfig.getStartTime(matchEntity);
    // startTime is the time at which players can start playing the match. this is the time
    // when the initial match countdown is finished
    // you can use startTime to check against the betting period
    // i.e. require(startTime >= bettingPeriod)

    bool matchFinished = MatchFinished.get(matchEntity);
    // matchFinished is true if the match has finished
    // if matchFinished is true, you can get the match results from MatchRanking

    bytes32[] memory playerEntityRanking = MatchRanking.get(matchEntity);
    // MatchRanking contains the player entities in the order of their rank in the match
    // index 0 is first, index 1 is second, etc.

    address[] memory playerAddresses = new address[](playerEntityRanking.length);
    for (uint256 i = 0; i < playerEntityRanking.length; i++) {
      playerAddresses[i] = entityToAddress(CreatedByAddress.get(matchEntity, playerEntityRanking[i]));
    }

    address[] memory addressesFromBetting = new address[](playerEntityRanking.length);

    // attempt to find the player address for each betting address
    // to confirm the correct players were in the match
    for (uint256 i = 0; i < addressesFromBetting.length; i++) {
      bool found = false;
      for (uint256 j = 0; j < playerAddresses.length; j++) {
        if (addressesFromBetting[i] == playerAddresses[j]) {
          found = true;
          break;
        }
      }
      // require(found, "Player address not found");
    }

    address winnerAddress = playerAddresses[0];

    console.log("Start Time:");
    console.log(startTime);

    console.log("Winner Address:");
    console.log(winnerAddress);

    vm.stopBroadcast();
  }
}
