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

library Chargers {
  // Hex below is the result of `WorldResourceIdLib.encode({ namespace: "", name: "Chargers", typeId: RESOURCE_TABLE });`
  ResourceId constant _tableId = ResourceId.wrap(0x7462000000000000000000000000000043686172676572730000000000000000);

  FieldLayout constant _fieldLayout =
    FieldLayout.wrap(0x0000000100000000000000000000000000000000000000000000000000000000);

  // Hex-encoded key schema of (bytes32, bytes32)
  Schema constant _keySchema = Schema.wrap(0x004002005f5f0000000000000000000000000000000000000000000000000000);
  // Hex-encoded value schema of (bytes32[])
  Schema constant _valueSchema = Schema.wrap(0x00000001c1000000000000000000000000000000000000000000000000000000);

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](2);
    keyNames[0] = "matchEntity";
    keyNames[1] = "chargee";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](1);
    fieldNames[0] = "chargers";
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
   * @notice Get chargers.
   */
  function getChargers(bytes32 matchEntity, bytes32 chargee) internal view returns (bytes32[] memory chargers) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes32());
  }

  /**
   * @notice Get chargers.
   */
  function _getChargers(bytes32 matchEntity, bytes32 chargee) internal view returns (bytes32[] memory chargers) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes32());
  }

  /**
   * @notice Get chargers.
   */
  function get(bytes32 matchEntity, bytes32 chargee) internal view returns (bytes32[] memory chargers) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes32());
  }

  /**
   * @notice Get chargers.
   */
  function _get(bytes32 matchEntity, bytes32 chargee) internal view returns (bytes32[] memory chargers) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes32());
  }

  /**
   * @notice Set chargers.
   */
  function setChargers(bytes32 matchEntity, bytes32 chargee, bytes32[] memory chargers) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode((chargers)));
  }

  /**
   * @notice Set chargers.
   */
  function _setChargers(bytes32 matchEntity, bytes32 chargee, bytes32[] memory chargers) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    StoreCore.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode((chargers)));
  }

  /**
   * @notice Set chargers.
   */
  function set(bytes32 matchEntity, bytes32 chargee, bytes32[] memory chargers) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode((chargers)));
  }

  /**
   * @notice Set chargers.
   */
  function _set(bytes32 matchEntity, bytes32 chargee, bytes32[] memory chargers) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    StoreCore.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode((chargers)));
  }

  /**
   * @notice Get the length of chargers.
   */
  function lengthChargers(bytes32 matchEntity, bytes32 chargee) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 32;
    }
  }

  /**
   * @notice Get the length of chargers.
   */
  function _lengthChargers(bytes32 matchEntity, bytes32 chargee) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 32;
    }
  }

  /**
   * @notice Get the length of chargers.
   */
  function length(bytes32 matchEntity, bytes32 chargee) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 32;
    }
  }

  /**
   * @notice Get the length of chargers.
   */
  function _length(bytes32 matchEntity, bytes32 chargee) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 32;
    }
  }

  /**
   * @notice Get an item of chargers.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemChargers(bytes32 matchEntity, bytes32 chargee, uint256 _index) internal view returns (bytes32) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 32, (_index + 1) * 32);
      return (bytes32(_blob));
    }
  }

  /**
   * @notice Get an item of chargers.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItemChargers(bytes32 matchEntity, bytes32 chargee, uint256 _index) internal view returns (bytes32) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 32, (_index + 1) * 32);
      return (bytes32(_blob));
    }
  }

  /**
   * @notice Get an item of chargers.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItem(bytes32 matchEntity, bytes32 chargee, uint256 _index) internal view returns (bytes32) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 32, (_index + 1) * 32);
      return (bytes32(_blob));
    }
  }

  /**
   * @notice Get an item of chargers.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItem(bytes32 matchEntity, bytes32 chargee, uint256 _index) internal view returns (bytes32) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 32, (_index + 1) * 32);
      return (bytes32(_blob));
    }
  }

  /**
   * @notice Push an element to chargers.
   */
  function pushChargers(bytes32 matchEntity, bytes32 chargee, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Push an element to chargers.
   */
  function _pushChargers(bytes32 matchEntity, bytes32 chargee, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Push an element to chargers.
   */
  function push(bytes32 matchEntity, bytes32 chargee, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Push an element to chargers.
   */
  function _push(bytes32 matchEntity, bytes32 chargee, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Pop an element from chargers.
   */
  function popChargers(bytes32 matchEntity, bytes32 chargee) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 0, 32);
  }

  /**
   * @notice Pop an element from chargers.
   */
  function _popChargers(bytes32 matchEntity, bytes32 chargee) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 0, 32);
  }

  /**
   * @notice Pop an element from chargers.
   */
  function pop(bytes32 matchEntity, bytes32 chargee) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 0, 32);
  }

  /**
   * @notice Pop an element from chargers.
   */
  function _pop(bytes32 matchEntity, bytes32 chargee) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 0, 32);
  }

  /**
   * @notice Update an element of chargers at `_index`.
   */
  function updateChargers(bytes32 matchEntity, bytes32 chargee, uint256 _index, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 32), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update an element of chargers at `_index`.
   */
  function _updateChargers(bytes32 matchEntity, bytes32 chargee, uint256 _index, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 32), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update an element of chargers at `_index`.
   */
  function update(bytes32 matchEntity, bytes32 chargee, uint256 _index, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 32), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update an element of chargers at `_index`.
   */
  function _update(bytes32 matchEntity, bytes32 chargee, uint256 _index, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 32), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(bytes32 matchEntity, bytes32 chargee) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(bytes32 matchEntity, bytes32 chargee) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack dynamic data lengths using this table's schema.
   * @return _encodedLengths The lengths of the dynamic fields (packed into a single bytes32 value).
   */
  function encodeLengths(bytes32[] memory chargers) internal pure returns (EncodedLengths _encodedLengths) {
    // Lengths are effectively checked during copy by 2**40 bytes exceeding gas limits
    unchecked {
      _encodedLengths = EncodedLengthsLib.pack(chargers.length * 32);
    }
  }

  /**
   * @notice Tightly pack dynamic (variable length) data using this table's schema.
   * @return The dynamic data, encoded into a sequence of bytes.
   */
  function encodeDynamic(bytes32[] memory chargers) internal pure returns (bytes memory) {
    return abi.encodePacked(EncodeArray.encode((chargers)));
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dynamic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(bytes32[] memory chargers) internal pure returns (bytes memory, EncodedLengths, bytes memory) {
    bytes memory _staticData;
    EncodedLengths _encodedLengths = encodeLengths(chargers);
    bytes memory _dynamicData = encodeDynamic(chargers);

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(bytes32 matchEntity, bytes32 chargee) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = chargee;

    return _keyTuple;
  }
}