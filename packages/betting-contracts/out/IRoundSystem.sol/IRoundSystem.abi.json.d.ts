declare const abi: [
  {
    type: "function";
    name: "createRound";
    inputs: [
      {
        name: "_betPeriod";
        type: "uint256";
        internalType: "uint256";
      },
      {
        name: "_playerAddresses";
        type: "address[]";
        internalType: "address[]";
      },
      {
        name: "_names";
        type: "string[]";
        internalType: "string[]";
      },
      {
        name: "_teamIds";
        type: "uint8[]";
        internalType: "uint8[]";
      },
      {
        name: "_title";
        type: "string";
        internalType: "string";
      },
    ];
    outputs: [];
    stateMutability: "nonpayable";
  },
  {
    type: "function";
    name: "resolution";
    inputs: [
      {
        name: "_roundId";
        type: "bytes32";
        internalType: "bytes32";
      },
      {
        name: "matchEntity";
        type: "bytes32";
        internalType: "bytes32";
      },
    ];
    outputs: [];
    stateMutability: "nonpayable";
  },
];
export default abi;
