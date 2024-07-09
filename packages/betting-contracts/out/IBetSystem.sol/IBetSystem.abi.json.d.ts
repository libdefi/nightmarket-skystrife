declare const abi: [
  {
    type: "function";
    name: "placeBet";
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
        name: "_amount";
        type: "uint256";
        internalType: "uint256";
      },
    ];
    outputs: [];
    stateMutability: "payable";
  },
  {
    type: "function";
    name: "refundWithdraw";
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
    outputs: [];
    stateMutability: "nonpayable";
  },
  {
    type: "function";
    name: "winnerWithdraw";
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
    outputs: [];
    stateMutability: "nonpayable";
  },
];
export default abi;
