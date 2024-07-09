declare const abi: [
  {
    type: "function";
    name: "deregister";
    inputs: [
      {
        name: "matchEntity";
        type: "bytes32";
        internalType: "bytes32";
      },
      {
        name: "spawnIndex";
        type: "uint256";
        internalType: "uint256";
      },
      {
        name: "heroEntity";
        type: "bytes32";
        internalType: "bytes32";
      },
    ];
    outputs: [
      {
        name: "";
        type: "bytes32";
        internalType: "bytes32";
      },
    ];
    stateMutability: "nonpayable";
  },
];
export default abi;