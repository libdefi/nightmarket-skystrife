// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

// Import store internals
import { IStore } from "@latticexyz/store/src/IStore.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { StoreCore } from "@latticexyz/store/src/StoreCore.sol";
import { Bytes } from "@latticexyz/store/src/Bytes.sol";
import { Memory } from "@latticexyz/store/src/Memory.sol";
import { SliceLib } from "@latticexyz/store/src/Slice.sol";
import { EncodeArray } from "@latticexyz/store/src/tightcoder/EncodeArray.sol";
import { FieldLayout } from "@latticexyz/store/src/FieldLayout.sol";
import { Schema } from "@latticexyz/store/src/Schema.sol";
import { EncodedLengths, EncodedLengthsLib } from "@latticexyz/store/src/EncodedLengths.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";

struct TeamsData {
  uint256 betAmount;
  bool winner;
  address[] betAddresses;
  string name;
}

library Teams {
  // Hex below is the result of `WorldResourceIdLib.encode({ namespace: "", name: "Teams", typeId: RESOURCE_TABLE });`
  ResourceId constant _tableId = ResourceId.wrap(0x746200000000000000000000000000005465616d730000000000000000000000);

  FieldLayout constant _fieldLayout =
    FieldLayout.wrap(0x0021020220010000000000000000000000000000000000000000000000000000);

  // Hex-encoded key schema of (bytes32, uint8)
  Schema constant _keySchema = Schema.wrap(0x002102005f000000000000000000000000000000000000000000000000000000);
  // Hex-encoded value schema of (uint256, bool, address[], string)
  Schema constant _valueSchema = Schema.wrap(0x002102021f60c3c5000000000000000000000000000000000000000000000000);

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](2);
    keyNames[0] = "roundId";
    keyNames[1] = "teamId";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](4);
    fieldNames[0] = "betAmount";
    fieldNames[1] = "winner";
    fieldNames[2] = "betAddresses";
    fieldNames[3] = "name";
  }

  /**
   * @notice Register the table with its config.
   */
  function register() internal {
    StoreSwitch.registerTable(_tableId, _fieldLayout, _keySchema, _valueSchema, getKeyNames(), getFieldNames());
  }

  /**
   * @notice Register the table with its config.
   */
  function _register() internal {
    StoreCore.registerTable(_tableId, _fieldLayout, _keySchema, _valueSchema, getKeyNames(), getFieldNames());
  }

  /**
   * @notice Get betAmount.
   */
  function getBetAmount(bytes32 roundId, uint8 teamId) internal view returns (uint256 betAmount) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get betAmount.
   */
  function _getBetAmount(bytes32 roundId, uint8 teamId) internal view returns (uint256 betAmount) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set betAmount.
   */
  function setBetAmount(bytes32 roundId, uint8 teamId, uint256 betAmount) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((betAmount)), _fieldLayout);
  }

  /**
   * @notice Set betAmount.
   */
  function _setBetAmount(bytes32 roundId, uint8 teamId, uint256 betAmount) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((betAmount)), _fieldLayout);
  }

  /**
   * @notice Get winner.
   */
  function getWinner(bytes32 roundId, uint8 teamId) internal view returns (bool winner) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (_toBool(uint8(bytes1(_blob))));
  }

  /**
   * @notice Get winner.
   */
  function _getWinner(bytes32 roundId, uint8 teamId) internal view returns (bool winner) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (_toBool(uint8(bytes1(_blob))));
  }

  /**
   * @notice Set winner.
   */
  function setWinner(bytes32 roundId, uint8 teamId, bool winner) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((winner)), _fieldLayout);
  }

  /**
   * @notice Set winner.
   */
  function _setWinner(bytes32 roundId, uint8 teamId, bool winner) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    StoreCore.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((winner)), _fieldLayout);
  }

  /**
   * @notice Get betAddresses.
   */
  function getBetAddresses(bytes32 roundId, uint8 teamId) internal view returns (address[] memory betAddresses) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_address());
  }

  /**
   * @notice Get betAddresses.
   */
  function _getBetAddresses(bytes32 roundId, uint8 teamId) internal view returns (address[] memory betAddresses) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_address());
  }

  /**
   * @notice Set betAddresses.
   */
  function setBetAddresses(bytes32 roundId, uint8 teamId, address[] memory betAddresses) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode((betAddresses)));
  }

  /**
   * @notice Set betAddresses.
   */
  function _setBetAddresses(bytes32 roundId, uint8 teamId, address[] memory betAddresses) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    StoreCore.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode((betAddresses)));
  }

  /**
   * @notice Get the length of betAddresses.
   */
  function lengthBetAddresses(bytes32 roundId, uint8 teamId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 20;
    }
  }

  /**
   * @notice Get the length of betAddresses.
   */
  function _lengthBetAddresses(bytes32 roundId, uint8 teamId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 20;
    }
  }

  /**
   * @notice Get an item of betAddresses.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemBetAddresses(bytes32 roundId, uint8 teamId, uint256 _index) internal view returns (address) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 20, (_index + 1) * 20);
      return (address(bytes20(_blob)));
    }
  }

  /**
   * @notice Get an item of betAddresses.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItemBetAddresses(bytes32 roundId, uint8 teamId, uint256 _index) internal view returns (address) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 20, (_index + 1) * 20);
      return (address(bytes20(_blob)));
    }
  }

  /**
   * @notice Push an element to betAddresses.
   */
  function pushBetAddresses(bytes32 roundId, uint8 teamId, address _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Push an element to betAddresses.
   */
  function _pushBetAddresses(bytes32 roundId, uint8 teamId, address _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Pop an element from betAddresses.
   */
  function popBetAddresses(bytes32 roundId, uint8 teamId) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 0, 20);
  }

  /**
   * @notice Pop an element from betAddresses.
   */
  function _popBetAddresses(bytes32 roundId, uint8 teamId) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 0, 20);
  }

  /**
   * @notice Update an element of betAddresses at `_index`.
   */
  function updateBetAddresses(bytes32 roundId, uint8 teamId, uint256 _index, address _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 20), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update an element of betAddresses at `_index`.
   */
  function _updateBetAddresses(bytes32 roundId, uint8 teamId, uint256 _index, address _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 20), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Get name.
   */
  function getName(bytes32 roundId, uint8 teamId) internal view returns (string memory name) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 1);
    return (string(_blob));
  }

  /**
   * @notice Get name.
   */
  function _getName(bytes32 roundId, uint8 teamId) internal view returns (string memory name) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 1);
    return (string(_blob));
  }

  /**
   * @notice Set name.
   */
  function setName(bytes32 roundId, uint8 teamId, string memory name) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 1, bytes((name)));
  }

  /**
   * @notice Set name.
   */
  function _setName(bytes32 roundId, uint8 teamId, string memory name) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    StoreCore.setDynamicField(_tableId, _keyTuple, 1, bytes((name)));
  }

  /**
   * @notice Get the length of name.
   */
  function lengthName(bytes32 roundId, uint8 teamId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 1);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get the length of name.
   */
  function _lengthName(bytes32 roundId, uint8 teamId) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 1);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get an item of name.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemName(bytes32 roundId, uint8 teamId, uint256 _index) internal view returns (string memory) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 1, _index * 1, (_index + 1) * 1);
      return (string(_blob));
    }
  }

  /**
   * @notice Get an item of name.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItemName(bytes32 roundId, uint8 teamId, uint256 _index) internal view returns (string memory) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 1, _index * 1, (_index + 1) * 1);
      return (string(_blob));
    }
  }

  /**
   * @notice Push a slice to name.
   */
  function pushName(bytes32 roundId, uint8 teamId, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 1, bytes((_slice)));
  }

  /**
   * @notice Push a slice to name.
   */
  function _pushName(bytes32 roundId, uint8 teamId, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 1, bytes((_slice)));
  }

  /**
   * @notice Pop a slice from name.
   */
  function popName(bytes32 roundId, uint8 teamId) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 1, 1);
  }

  /**
   * @notice Pop a slice from name.
   */
  function _popName(bytes32 roundId, uint8 teamId) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 1, 1);
  }

  /**
   * @notice Update a slice of name at `_index`.
   */
  function updateName(bytes32 roundId, uint8 teamId, uint256 _index, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 1, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update a slice of name at `_index`.
   */
  function _updateName(bytes32 roundId, uint8 teamId, uint256 _index, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 1, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Get the full data.
   */
  function get(bytes32 roundId, uint8 teamId) internal view returns (TeamsData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    (bytes memory _staticData, EncodedLengths _encodedLengths, bytes memory _dynamicData) = StoreSwitch.getRecord(
      _tableId,
      _keyTuple,
      _fieldLayout
    );
    return decode(_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Get the full data.
   */
  function _get(bytes32 roundId, uint8 teamId) internal view returns (TeamsData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    (bytes memory _staticData, EncodedLengths _encodedLengths, bytes memory _dynamicData) = StoreCore.getRecord(
      _tableId,
      _keyTuple,
      _fieldLayout
    );
    return decode(_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function set(
    bytes32 roundId,
    uint8 teamId,
    uint256 betAmount,
    bool winner,
    address[] memory betAddresses,
    string memory name
  ) internal {
    bytes memory _staticData = encodeStatic(betAmount, winner);

    EncodedLengths _encodedLengths = encodeLengths(betAddresses, name);
    bytes memory _dynamicData = encodeDynamic(betAddresses, name);

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function _set(
    bytes32 roundId,
    uint8 teamId,
    uint256 betAmount,
    bool winner,
    address[] memory betAddresses,
    string memory name
  ) internal {
    bytes memory _staticData = encodeStatic(betAmount, winner);

    EncodedLengths _encodedLengths = encodeLengths(betAddresses, name);
    bytes memory _dynamicData = encodeDynamic(betAddresses, name);

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function set(bytes32 roundId, uint8 teamId, TeamsData memory _table) internal {
    bytes memory _staticData = encodeStatic(_table.betAmount, _table.winner);

    EncodedLengths _encodedLengths = encodeLengths(_table.betAddresses, _table.name);
    bytes memory _dynamicData = encodeDynamic(_table.betAddresses, _table.name);

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function _set(bytes32 roundId, uint8 teamId, TeamsData memory _table) internal {
    bytes memory _staticData = encodeStatic(_table.betAmount, _table.winner);

    EncodedLengths _encodedLengths = encodeLengths(_table.betAddresses, _table.name);
    bytes memory _dynamicData = encodeDynamic(_table.betAddresses, _table.name);

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Decode the tightly packed blob of static data using this table's field layout.
   */
  function decodeStatic(bytes memory _blob) internal pure returns (uint256 betAmount, bool winner) {
    betAmount = (uint256(Bytes.getBytes32(_blob, 0)));

    winner = (_toBool(uint8(Bytes.getBytes1(_blob, 32))));
  }

  /**
   * @notice Decode the tightly packed blob of dynamic data using the encoded lengths.
   */
  function decodeDynamic(
    EncodedLengths _encodedLengths,
    bytes memory _blob
  ) internal pure returns (address[] memory betAddresses, string memory name) {
    uint256 _start;
    uint256 _end;
    unchecked {
      _end = _encodedLengths.atIndex(0);
    }
    betAddresses = (SliceLib.getSubslice(_blob, _start, _end).decodeArray_address());

    _start = _end;
    unchecked {
      _end += _encodedLengths.atIndex(1);
    }
    name = (string(SliceLib.getSubslice(_blob, _start, _end).toBytes()));
  }

  /**
   * @notice Decode the tightly packed blobs using this table's field layout.
   * @param _staticData Tightly packed static fields.
   * @param _encodedLengths Encoded lengths of dynamic fields.
   * @param _dynamicData Tightly packed dynamic fields.
   */
  function decode(
    bytes memory _staticData,
    EncodedLengths _encodedLengths,
    bytes memory _dynamicData
  ) internal pure returns (TeamsData memory _table) {
    (_table.betAmount, _table.winner) = decodeStatic(_staticData);

    (_table.betAddresses, _table.name) = decodeDynamic(_encodedLengths, _dynamicData);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(bytes32 roundId, uint8 teamId) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(bytes32 roundId, uint8 teamId) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack static (fixed length) data using this table's schema.
   * @return The static data, encoded into a sequence of bytes.
   */
  function encodeStatic(uint256 betAmount, bool winner) internal pure returns (bytes memory) {
    return abi.encodePacked(betAmount, winner);
  }

  /**
   * @notice Tightly pack dynamic data lengths using this table's schema.
   * @return _encodedLengths The lengths of the dynamic fields (packed into a single bytes32 value).
   */
  function encodeLengths(
    address[] memory betAddresses,
    string memory name
  ) internal pure returns (EncodedLengths _encodedLengths) {
    // Lengths are effectively checked during copy by 2**40 bytes exceeding gas limits
    unchecked {
      _encodedLengths = EncodedLengthsLib.pack(betAddresses.length * 20, bytes(name).length);
    }
  }

  /**
   * @notice Tightly pack dynamic (variable length) data using this table's schema.
   * @return The dynamic data, encoded into a sequence of bytes.
   */
  function encodeDynamic(address[] memory betAddresses, string memory name) internal pure returns (bytes memory) {
    return abi.encodePacked(EncodeArray.encode((betAddresses)), bytes((name)));
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dynamic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(
    uint256 betAmount,
    bool winner,
    address[] memory betAddresses,
    string memory name
  ) internal pure returns (bytes memory, EncodedLengths, bytes memory) {
    bytes memory _staticData = encodeStatic(betAmount, winner);

    EncodedLengths _encodedLengths = encodeLengths(betAddresses, name);
    bytes memory _dynamicData = encodeDynamic(betAddresses, name);

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(bytes32 roundId, uint8 teamId) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));

    return _keyTuple;
  }
}

/**
 * @notice Cast a value to a bool.
 * @dev Boolean values are encoded as uint8 (1 = true, 0 = false), but Solidity doesn't allow casting between uint8 and bool.
 * @param value The uint8 value to convert.
 * @return result The boolean value.
 */
function _toBool(uint8 value) pure returns (bool result) {
  assembly {
    result := value
  }
}