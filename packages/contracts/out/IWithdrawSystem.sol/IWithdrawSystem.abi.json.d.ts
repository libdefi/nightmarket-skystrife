declare const abi: [
  {
    type: "function";
    name: "withdrawEth";
    inputs: [
      {
        name: "to";
        type: "address";
        internalType: "address";
      },
      {
        name: "amount";
        type: "uint256";
        internalType: "uint256";
      },
    ];
    outputs: [];
    stateMutability: "nonpayable";
  },
];
export default abi;
