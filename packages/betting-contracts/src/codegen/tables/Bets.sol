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

struct BetsData {
  uint256 amount;
  uint256 winnerAmount;
  string roundTitle;
  string teamName;
}

library Bets {
  // Hex below is the result of `WorldResourceIdLib.encode({ namespace: "", name: "Bets", typeId: RESOURCE_TABLE });`
  ResourceId constant _tableId = ResourceId.wrap(0x7462000000000000000000000000000042657473000000000000000000000000);

  FieldLayout constant _fieldLayout =
    FieldLayout.wrap(0x0040020220200000000000000000000000000000000000000000000000000000);

  // Hex-encoded key schema of (bytes32, uint8, address)
  Schema constant _keySchema = Schema.wrap(0x003503005f006100000000000000000000000000000000000000000000000000);
  // Hex-encoded value schema of (uint256, uint256, string, string)
  Schema constant _valueSchema = Schema.wrap(0x004002021f1fc5c5000000000000000000000000000000000000000000000000);

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](3);
    keyNames[0] = "roundId";
    keyNames[1] = "teamId";
    keyNames[2] = "betterAddress";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](4);
    fieldNames[0] = "amount";
    fieldNames[1] = "winnerAmount";
    fieldNames[2] = "roundTitle";
    fieldNames[3] = "teamName";
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
   * @notice Get amount.
   */
  function getAmount(bytes32 roundId, uint8 teamId, address betterAddress) internal view returns (uint256 amount) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get amount.
   */
  function _getAmount(bytes32 roundId, uint8 teamId, address betterAddress) internal view returns (uint256 amount) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set amount.
   */
  function setAmount(bytes32 roundId, uint8 teamId, address betterAddress, uint256 amount) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((amount)), _fieldLayout);
  }

  /**
   * @notice Set amount.
   */
  function _setAmount(bytes32 roundId, uint8 teamId, address betterAddress, uint256 amount) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((amount)), _fieldLayout);
  }

  /**
   * @notice Get winnerAmount.
   */
  function getWinnerAmount(
    bytes32 roundId,
    uint8 teamId,
    address betterAddress
  ) internal view returns (uint256 winnerAmount) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get winnerAmount.
   */
  function _getWinnerAmount(
    bytes32 roundId,
    uint8 teamId,
    address betterAddress
  ) internal view returns (uint256 winnerAmount) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set winnerAmount.
   */
  function setWinnerAmount(bytes32 roundId, uint8 teamId, address betterAddress, uint256 winnerAmount) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((winnerAmount)), _fieldLayout);
  }

  /**
   * @notice Set winnerAmount.
   */
  function _setWinnerAmount(bytes32 roundId, uint8 teamId, address betterAddress, uint256 winnerAmount) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    StoreCore.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((winnerAmount)), _fieldLayout);
  }

  /**
   * @notice Get roundTitle.
   */
  function getRoundTitle(
    bytes32 roundId,
    uint8 teamId,
    address betterAddress
  ) internal view returns (string memory roundTitle) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 0);
    return (string(_blob));
  }

  /**
   * @notice Get roundTitle.
   */
  function _getRoundTitle(
    bytes32 roundId,
    uint8 teamId,
    address betterAddress
  ) internal view returns (string memory roundTitle) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 0);
    return (string(_blob));
  }

  /**
   * @notice Set roundTitle.
   */
  function setRoundTitle(bytes32 roundId, uint8 teamId, address betterAddress, string memory roundTitle) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 0, bytes((roundTitle)));
  }

  /**
   * @notice Set roundTitle.
   */
  function _setRoundTitle(bytes32 roundId, uint8 teamId, address betterAddress, string memory roundTitle) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    StoreCore.setDynamicField(_tableId, _keyTuple, 0, bytes((roundTitle)));
  }

  /**
   * @notice Get the length of roundTitle.
   */
  function lengthRoundTitle(bytes32 roundId, uint8 teamId, address betterAddress) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get the length of roundTitle.
   */
  function _lengthRoundTitle(bytes32 roundId, uint8 teamId, address betterAddress) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get an item of roundTitle.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemRoundTitle(
    bytes32 roundId,
    uint8 teamId,
    address betterAddress,
    uint256 _index
  ) internal view returns (string memory) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 1, (_index + 1) * 1);
      return (string(_blob));
    }
  }

  /**
   * @notice Get an item of roundTitle.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItemRoundTitle(
    bytes32 roundId,
    uint8 teamId,
    address betterAddress,
    uint256 _index
  ) internal view returns (string memory) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 1, (_index + 1) * 1);
      return (string(_blob));
    }
  }

  /**
   * @notice Push a slice to roundTitle.
   */
  function pushRoundTitle(bytes32 roundId, uint8 teamId, address betterAddress, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 0, bytes((_slice)));
  }

  /**
   * @notice Push a slice to roundTitle.
   */
  function _pushRoundTitle(bytes32 roundId, uint8 teamId, address betterAddress, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 0, bytes((_slice)));
  }

  /**
   * @notice Pop a slice from roundTitle.
   */
  function popRoundTitle(bytes32 roundId, uint8 teamId, address betterAddress) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 0, 1);
  }

  /**
   * @notice Pop a slice from roundTitle.
   */
  function _popRoundTitle(bytes32 roundId, uint8 teamId, address betterAddress) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 0, 1);
  }

  /**
   * @notice Update a slice of roundTitle at `_index`.
   */
  function updateRoundTitle(
    bytes32 roundId,
    uint8 teamId,
    address betterAddress,
    uint256 _index,
    string memory _slice
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update a slice of roundTitle at `_index`.
   */
  function _updateRoundTitle(
    bytes32 roundId,
    uint8 teamId,
    address betterAddress,
    uint256 _index,
    string memory _slice
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Get teamName.
   */
  function getTeamName(
    bytes32 roundId,
    uint8 teamId,
    address betterAddress
  ) internal view returns (string memory teamName) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 1);
    return (string(_blob));
  }

  /**
   * @notice Get teamName.
   */
  function _getTeamName(
    bytes32 roundId,
    uint8 teamId,
    address betterAddress
  ) internal view returns (string memory teamName) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 1);
    return (string(_blob));
  }

  /**
   * @notice Set teamName.
   */
  function setTeamName(bytes32 roundId, uint8 teamId, address betterAddress, string memory teamName) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 1, bytes((teamName)));
  }

  /**
   * @notice Set teamName.
   */
  function _setTeamName(bytes32 roundId, uint8 teamId, address betterAddress, string memory teamName) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    StoreCore.setDynamicField(_tableId, _keyTuple, 1, bytes((teamName)));
  }

  /**
   * @notice Get the length of teamName.
   */
  function lengthTeamName(bytes32 roundId, uint8 teamId, address betterAddress) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 1);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get the length of teamName.
   */
  function _lengthTeamName(bytes32 roundId, uint8 teamId, address betterAddress) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 1);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get an item of teamName.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemTeamName(
    bytes32 roundId,
    uint8 teamId,
    address betterAddress,
    uint256 _index
  ) internal view returns (string memory) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 1, _index * 1, (_index + 1) * 1);
      return (string(_blob));
    }
  }

  /**
   * @notice Get an item of teamName.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItemTeamName(
    bytes32 roundId,
    uint8 teamId,
    address betterAddress,
    uint256 _index
  ) internal view returns (string memory) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 1, _index * 1, (_index + 1) * 1);
      return (string(_blob));
    }
  }

  /**
   * @notice Push a slice to teamName.
   */
  function pushTeamName(bytes32 roundId, uint8 teamId, address betterAddress, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 1, bytes((_slice)));
  }

  /**
   * @notice Push a slice to teamName.
   */
  function _pushTeamName(bytes32 roundId, uint8 teamId, address betterAddress, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 1, bytes((_slice)));
  }

  /**
   * @notice Pop a slice from teamName.
   */
  function popTeamName(bytes32 roundId, uint8 teamId, address betterAddress) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 1, 1);
  }

  /**
   * @notice Pop a slice from teamName.
   */
  function _popTeamName(bytes32 roundId, uint8 teamId, address betterAddress) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 1, 1);
  }

  /**
   * @notice Update a slice of teamName at `_index`.
   */
  function updateTeamName(
    bytes32 roundId,
    uint8 teamId,
    address betterAddress,
    uint256 _index,
    string memory _slice
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 1, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update a slice of teamName at `_index`.
   */
  function _updateTeamName(
    bytes32 roundId,
    uint8 teamId,
    address betterAddress,
    uint256 _index,
    string memory _slice
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 1, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Get the full data.
   */
  function get(bytes32 roundId, uint8 teamId, address betterAddress) internal view returns (BetsData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

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
  function _get(bytes32 roundId, uint8 teamId, address betterAddress) internal view returns (BetsData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

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
    address betterAddress,
    uint256 amount,
    uint256 winnerAmount,
    string memory roundTitle,
    string memory teamName
  ) internal {
    bytes memory _staticData = encodeStatic(amount, winnerAmount);

    EncodedLengths _encodedLengths = encodeLengths(roundTitle, teamName);
    bytes memory _dynamicData = encodeDynamic(roundTitle, teamName);

    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function _set(
    bytes32 roundId,
    uint8 teamId,
    address betterAddress,
    uint256 amount,
    uint256 winnerAmount,
    string memory roundTitle,
    string memory teamName
  ) internal {
    bytes memory _staticData = encodeStatic(amount, winnerAmount);

    EncodedLengths _encodedLengths = encodeLengths(roundTitle, teamName);
    bytes memory _dynamicData = encodeDynamic(roundTitle, teamName);

    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function set(bytes32 roundId, uint8 teamId, address betterAddress, BetsData memory _table) internal {
    bytes memory _staticData = encodeStatic(_table.amount, _table.winnerAmount);

    EncodedLengths _encodedLengths = encodeLengths(_table.roundTitle, _table.teamName);
    bytes memory _dynamicData = encodeDynamic(_table.roundTitle, _table.teamName);

    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function _set(bytes32 roundId, uint8 teamId, address betterAddress, BetsData memory _table) internal {
    bytes memory _staticData = encodeStatic(_table.amount, _table.winnerAmount);

    EncodedLengths _encodedLengths = encodeLengths(_table.roundTitle, _table.teamName);
    bytes memory _dynamicData = encodeDynamic(_table.roundTitle, _table.teamName);

    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Decode the tightly packed blob of static data using this table's field layout.
   */
  function decodeStatic(bytes memory _blob) internal pure returns (uint256 amount, uint256 winnerAmount) {
    amount = (uint256(Bytes.getBytes32(_blob, 0)));

    winnerAmount = (uint256(Bytes.getBytes32(_blob, 32)));
  }

  /**
   * @notice Decode the tightly packed blob of dynamic data using the encoded lengths.
   */
  function decodeDynamic(
    EncodedLengths _encodedLengths,
    bytes memory _blob
  ) internal pure returns (string memory roundTitle, string memory teamName) {
    uint256 _start;
    uint256 _end;
    unchecked {
      _end = _encodedLengths.atIndex(0);
    }
    roundTitle = (string(SliceLib.getSubslice(_blob, _start, _end).toBytes()));

    _start = _end;
    unchecked {
      _end += _encodedLengths.atIndex(1);
    }
    teamName = (string(SliceLib.getSubslice(_blob, _start, _end).toBytes()));
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
  ) internal pure returns (BetsData memory _table) {
    (_table.amount, _table.winnerAmount) = decodeStatic(_staticData);

    (_table.roundTitle, _table.teamName) = decodeDynamic(_encodedLengths, _dynamicData);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(bytes32 roundId, uint8 teamId, address betterAddress) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(bytes32 roundId, uint8 teamId, address betterAddress) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack static (fixed length) data using this table's schema.
   * @return The static data, encoded into a sequence of bytes.
   */
  function encodeStatic(uint256 amount, uint256 winnerAmount) internal pure returns (bytes memory) {
    return abi.encodePacked(amount, winnerAmount);
  }

  /**
   * @notice Tightly pack dynamic data lengths using this table's schema.
   * @return _encodedLengths The lengths of the dynamic fields (packed into a single bytes32 value).
   */
  function encodeLengths(
    string memory roundTitle,
    string memory teamName
  ) internal pure returns (EncodedLengths _encodedLengths) {
    // Lengths are effectively checked during copy by 2**40 bytes exceeding gas limits
    unchecked {
      _encodedLengths = EncodedLengthsLib.pack(bytes(roundTitle).length, bytes(teamName).length);
    }
  }

  /**
   * @notice Tightly pack dynamic (variable length) data using this table's schema.
   * @return The dynamic data, encoded into a sequence of bytes.
   */
  function encodeDynamic(string memory roundTitle, string memory teamName) internal pure returns (bytes memory) {
    return abi.encodePacked(bytes((roundTitle)), bytes((teamName)));
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dynamic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(
    uint256 amount,
    uint256 winnerAmount,
    string memory roundTitle,
    string memory teamName
  ) internal pure returns (bytes memory, EncodedLengths, bytes memory) {
    bytes memory _staticData = encodeStatic(amount, winnerAmount);

    EncodedLengths _encodedLengths = encodeLengths(roundTitle, teamName);
    bytes memory _dynamicData = encodeDynamic(roundTitle, teamName);

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(
    bytes32 roundId,
    uint8 teamId,
    address betterAddress
  ) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = roundId;
    _keyTuple[1] = bytes32(uint256(teamId));
    _keyTuple[2] = bytes32(uint256(uint160(betterAddress)));

    return _keyTuple;
  }
}
