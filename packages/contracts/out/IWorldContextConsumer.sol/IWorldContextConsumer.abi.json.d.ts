declare const abi: [
  {
    type: "function";
    name: "_msgSender";
    inputs: [];
    outputs: [
      {
        name: "";
        type: "address";
        internalType: "address";
      },
    ];
    stateMutability: "view";
  },
  {
    type: "function";
    name: "_msgValue";
    inputs: [];
    outputs: [
      {
        name: "";
        type: "uint256";
        internalType: "uint256";
      },
    ];
    stateMutability: "view";
  },
  {
    type: "function";
    name: "_world";
    inputs: [];
    outputs: [
      {
        name: "";
        type: "address";
        internalType: "address";
      },
    ];
    stateMutability: "view";
  },
  {
    type: "function";
    name: "supportsInterface";
    inputs: [
      {
        name: "interfaceID";
        type: "bytes4";
        internalType: "bytes4";
      },
    ];
    outputs: [
      {
        name: "";
        type: "bool";
        internalType: "bool";
      },
    ];
    stateMutability: "view";
  },
];
export default abi;
