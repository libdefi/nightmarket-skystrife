declare const abi: [
  {
    type: "function";
    name: "_msgSender";
    inputs: [];
    outputs: [
      {
        name: "sender";
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
        name: "value";
        type: "uint256";
        internalType: "uint256";
      },
    ];
    stateMutability: "pure";
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
    name: "supportsInterface";
    inputs: [
      {
        name: "interfaceId";
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
    stateMutability: "pure";
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
  {
    type: "event";
    name: "Store_SetRecord";
    inputs: [
      {
        name: "tableId";
        type: "bytes32";
        indexed: true;
        internalType: "ResourceId";
      },
      {
        name: "keyTuple";
        type: "bytes32[]";
        indexed: false;
        internalType: "bytes32[]";
      },
      {
        name: "staticData";
        type: "bytes";
        indexed: false;
        internalType: "bytes";
      },
      {
        name: "encodedLengths";
        type: "bytes32";
        indexed: false;
        internalType: "EncodedLengths";
      },
      {
        name: "dynamicData";
        type: "bytes";
        indexed: false;
        internalType: "bytes";
      },
    ];
    anonymous: false;
  },
  {
    type: "event";
    name: "Store_SpliceDynamicData";
    inputs: [
      {
        name: "tableId";
        type: "bytes32";
        indexed: true;
        internalType: "ResourceId";
      },
      {
        name: "keyTuple";
        type: "bytes32[]";
        indexed: false;
        internalType: "bytes32[]";
      },
      {
        name: "dynamicFieldIndex";
        type: "uint8";
        indexed: false;
        internalType: "uint8";
      },
      {
        name: "start";
        type: "uint48";
        indexed: false;
        internalType: "uint48";
      },
      {
        name: "deleteCount";
        type: "uint40";
        indexed: false;
        internalType: "uint40";
      },
      {
        name: "encodedLengths";
        type: "bytes32";
        indexed: false;
        internalType: "EncodedLengths";
      },
      {
        name: "data";
        type: "bytes";
        indexed: false;
        internalType: "bytes";
      },
    ];
    anonymous: false;
  },
  {
    type: "event";
    name: "Store_SpliceStaticData";
    inputs: [
      {
        name: "tableId";
        type: "bytes32";
        indexed: true;
        internalType: "ResourceId";
      },
      {
        name: "keyTuple";
        type: "bytes32[]";
        indexed: false;
        internalType: "bytes32[]";
      },
      {
        name: "start";
        type: "uint48";
        indexed: false;
        internalType: "uint48";
      },
      {
        name: "data";
        type: "bytes";
        indexed: false;
        internalType: "bytes";
      },
    ];
    anonymous: false;
  },
  {
    type: "error";
    name: "EncodedLengths_InvalidLength";
    inputs: [
      {
        name: "length";
        type: "uint256";
        internalType: "uint256";
      },
    ];
  },
  {
    type: "error";
    name: "Slice_OutOfBounds";
    inputs: [
      {
        name: "data";
        type: "bytes";
        internalType: "bytes";
      },
      {
        name: "start";
        type: "uint256";
        internalType: "uint256";
      },
      {
        name: "end";
        type: "uint256";
        internalType: "uint256";
      },
    ];
  },
  {
    type: "error";
    name: "Store_IndexOutOfBounds";
    inputs: [
      {
        name: "length";
        type: "uint256";
        internalType: "uint256";
      },
      {
        name: "accessedIndex";
        type: "uint256";
        internalType: "uint256";
      },
    ];
  },
  {
    type: "error";
    name: "Store_InvalidResourceType";
    inputs: [
      {
        name: "expected";
        type: "bytes2";
        internalType: "bytes2";
      },
      {
        name: "resourceId";
        type: "bytes32";
        internalType: "ResourceId";
      },
      {
        name: "resourceIdString";
        type: "string";
        internalType: "string";
      },
    ];
  },
  {
    type: "error";
    name: "Store_InvalidSplice";
    inputs: [
      {
        name: "startWithinField";
        type: "uint40";
        internalType: "uint40";
      },
      {
        name: "deleteCount";
        type: "uint40";
        internalType: "uint40";
      },
      {
        name: "fieldLength";
        type: "uint40";
        internalType: "uint40";
      },
    ];
  },
];
export default abi;
