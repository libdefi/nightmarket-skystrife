declare const abi: [
  {
    type: "function";
    name: "getBets";
    inputs: [
      {
        name: "_roundId";
        type: "bytes32";
        internalType: "bytes32";
      },
      {
        name: "_teamId";
        type: "uint8";
        internalType: "uint8";
      },
      {
        name: "_betterAddress";
        type: "address";
        internalType: "address";
      },
    ];
    outputs: [
      {
        name: "";
        type: "tuple";
        internalType: "struct BetsData";
        components: [
          {
            name: "amount";
            type: "uint256";
            internalType: "uint256";
          },
          {
            name: "winnerAmount";
            type: "uint256";
            internalType: "uint256";
          },
          {
            name: "roundTitle";
            type: "string";
            internalType: "string";
          },
          {
            name: "teamName";
            type: "string";
            internalType: "string";
          },
        ];
      },
    ];
    stateMutability: "view";
  },
  {
    type: "function";
    name: "getConfigId";
    inputs: [];
    outputs: [
      {
        name: "";
        type: "bytes32";
        internalType: "bytes32";
      },
    ];
    stateMutability: "view";
  },
  {
    type: "function";
    name: "getRound";
    inputs: [
      {
        name: "_roundId";
        type: "bytes32";
        internalType: "bytes32";
      },
    ];
    outputs: [
      {
        name: "";
        type: "tuple";
        internalType: "struct RoundsData";
        components: [
          {
            name: "roundCreator";
            type: "address";
            internalType: "address";
          },
          {
            name: "betPeriod";
            type: "uint256";
            internalType: "uint256";
          },
          {
            name: "matchFinished";
            type: "bool";
            internalType: "bool";
          },
          {
            name: "betAmount";
            type: "uint256";
            internalType: "uint256";
          },
          {
            name: "playerAddresses";
            type: "address[]";
            internalType: "address[]";
          },
          {
            name: "teamIds";
            type: "uint8[]";
            internalType: "uint8[]";
          },
          {
            name: "title";
            type: "string";
            internalType: "string";
          },
        ];
      },
    ];
    stateMutability: "view";
  },
  {
    type: "function";
    name: "getTeams";
    inputs: [
      {
        name: "_roundId";
        type: "bytes32";
        internalType: "bytes32";
      },
      {
        name: "_teamId";
        type: "uint8";
        internalType: "uint8";
      },
    ];
    outputs: [
      {
        name: "";
        type: "tuple";
        internalType: "struct TeamsData";
        components: [
          {
            name: "betAmount";
            type: "uint256";
            internalType: "uint256";
          },
          {
            name: "winner";
            type: "bool";
            internalType: "bool";
          },
          {
            name: "betAddresses";
            type: "address[]";
            internalType: "address[]";
          },
          {
            name: "name";
            type: "string";
            internalType: "string";
          },
        ];
      },
    ];
    stateMutability: "view";
  },
];
export default abi;
