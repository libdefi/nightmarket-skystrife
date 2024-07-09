declare const abi: [
  {
    type: "event";
    name: "HelloWorld";
    inputs: [
      {
        name: "worldVersion";
        type: "bytes32";
        indexed: true;
        internalType: "bytes32";
      },
    ];
    anonymous: false;
  },
];
export default abi;
