import { defineWorld } from "@latticexyz/world";

export default defineWorld({
  deploy: {
    upgradeableWorldImplementation: true,
  },
  codegen: {
    outputDirectory: "codegen",
  },
  enums: {},

  tables: {
    Config: {
      key: [],
      schema: {
        maxRoundId: "bytes32",
      },
    },
    Rounds: {
      key: ["roundId"],
      schema: {
        roundId: "bytes32",
        roundCreator: "address",
        betPeriod: "uint256",
        matchFinished: "bool",
        betAmount: "uint256",
        playerAddresses: "address[]",
        teamIds: "uint8[]",
        title: "string",
      },
    },
    Teams: {
      key: ["roundId", "teamId"],
      schema: {
        roundId: "bytes32",
        teamId: "uint8",
        betAmount: "uint256",
        winner: "bool",
        betAddresses: "address[]",
        name: "string",
      },
    },
    Bets: {
      key: ["roundId", "teamId", "betterAddress"],
      schema: {
        roundId: "bytes32",
        teamId: "uint8",
        betterAddress: "address",
        amount: "uint256",
        winnerAmount: "uint256",
        roundTitle: "string",
        teamName: "string",
      },
    },
  },
});
