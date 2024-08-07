declare const abi: [
  {
    type: "function";
    name: "transferBalanceToAddress";
    inputs: [
      {
        name: "fromNamespaceId";
        type: "bytes32";
        internalType: "ResourceId";
      },
      {
        name: "toAddress";
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
  {
    type: "function";
    name: "transferBalanceToNamespace";
    inputs: [
      {
        name: "fromNamespaceId";
        type: "bytes32";
        internalType: "ResourceId";
      },
      {
        name: "toNamespaceId";
        type: "bytes32";
        internalType: "ResourceId";
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
