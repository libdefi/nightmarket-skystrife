declare const abi: [
  {
    type: "function";
    name: "installModule";
    inputs: [
      {
        name: "module";
        type: "address";
        internalType: "contract IModule";
      },
      {
        name: "encodedArgs";
        type: "bytes";
        internalType: "bytes";
      },
    ];
    outputs: [];
    stateMutability: "nonpayable";
  },
];
export default abi;
