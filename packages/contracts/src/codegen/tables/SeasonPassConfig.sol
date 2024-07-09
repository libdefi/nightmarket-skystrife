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

struct SeasonPassConfigData {
  uint256 minPrice;
  uint256 startingPrice;
  uint256 rate;
  uint256 multiplier;
  uint256 mintCutoff;
}

library SeasonPassConfig {
  // Hex below is the result of `WorldResourceIdLib.encode({ namespace: "", name: "SeasonPassConfig", typeId: RESOURCE_TABLE });`
  ResourceId constant _tableId = ResourceId.wrap(0x74620000000000000000000000000000536561736f6e50617373436f6e666967);

  FieldLayout constant _fieldLayout =
    FieldLayout.wrap(0x00a0050020202020200000000000000000000000000000000000000000000000);

  // Hex-encoded key schema of ()
  Schema constant _keySchema = Schema.wrap(0x0000000000000000000000000000000000000000000000000000000000000000);
  // Hex-encoded value schema of (uint256, uint256, uint256, uint256, uint256)
  Schema constant _valueSchema = Schema.wrap(0x00a005001f1f1f1f1f0000000000000000000000000000000000000000000000);

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](0);
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](5);
    fieldNames[0] = "minPrice";
    fieldNames[1] = "startingPrice";
    fieldNames[2] = "rate";
    fieldNames[3] = "multiplier";
    fieldNames[4] = "mintCutoff";
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
   * @notice Get minPrice.
   */
  function getMinPrice() internal view returns (uint256 minPrice) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get minPrice.
   */
  function _getMinPrice() internal view returns (uint256 minPrice) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set minPrice.
   */
  function setMinPrice(uint256 minPrice) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((minPrice)), _fieldLayout);
  }

  /**
   * @notice Set minPrice.
   */
  function _setMinPrice(uint256 minPrice) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((minPrice)), _fieldLayout);
  }

  /**
   * @notice Get startingPrice.
   */
  function getStartingPrice() internal view returns (uint256 startingPrice) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get startingPrice.
   */
  function _getStartingPrice() internal view returns (uint256 startingPrice) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set startingPrice.
   */
  function setStartingPrice(uint256 startingPrice) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreSwitch.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((startingPrice)), _fieldLayout);
  }

  /**
   * @notice Set startingPrice.
   */
  function _setStartingPrice(uint256 startingPrice) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreCore.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((startingPrice)), _fieldLayout);
  }

  /**
   * @notice Get rate.
   */
  function getRate() internal view returns (uint256 rate) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get rate.
   */
  function _getRate() internal view returns (uint256 rate) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set rate.
   */
  function setRate(uint256 rate) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreSwitch.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked((rate)), _fieldLayout);
  }

  /**
   * @notice Set rate.
   */
  function _setRate(uint256 rate) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreCore.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked((rate)), _fieldLayout);
  }

  /**
   * @notice Get multiplier.
   */
  function getMultiplier() internal view returns (uint256 multiplier) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 3, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get multiplier.
   */
  function _getMultiplier() internal view returns (uint256 multiplier) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 3, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set multiplier.
   */
  function setMultiplier(uint256 multiplier) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreSwitch.setStaticField(_tableId, _keyTuple, 3, abi.encodePacked((multiplier)), _fieldLayout);
  }

  /**
   * @notice Set multiplier.
   */
  function _setMultiplier(uint256 multiplier) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreCore.setStaticField(_tableId, _keyTuple, 3, abi.encodePacked((multiplier)), _fieldLayout);
  }

  /**
   * @notice Get mintCutoff.
   */
  function getMintCutoff() internal view returns (uint256 mintCutoff) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 4, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get mintCutoff.
   */
  function _getMintCutoff() internal view returns (uint256 mintCutoff) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 4, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set mintCutoff.
   */
  function setMintCutoff(uint256 mintCutoff) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreSwitch.setStaticField(_tableId, _keyTuple, 4, abi.encodePacked((mintCutoff)), _fieldLayout);
  }

  /**
   * @notice Set mintCutoff.
   */
  function _setMintCutoff(uint256 mintCutoff) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreCore.setStaticField(_tableId, _keyTuple, 4, abi.encodePacked((mintCutoff)), _fieldLayout);
  }

  /**
   * @notice Get the full data.
   */
  function get() internal view returns (SeasonPassConfigData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](0);

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
  function _get() internal view returns (SeasonPassConfigData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](0);

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
  function set(uint256 minPrice, uint256 startingPrice, uint256 rate, uint256 multiplier, uint256 mintCutoff) internal {
    bytes memory _staticData = encodeStatic(minPrice, startingPrice, rate, multiplier, mintCutoff);

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function _set(
    uint256 minPrice,
    uint256 startingPrice,
    uint256 rate,
    uint256 multiplier,
    uint256 mintCutoff
  ) internal {
    bytes memory _staticData = encodeStatic(minPrice, startingPrice, rate, multiplier, mintCutoff);

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function set(SeasonPassConfigData memory _table) internal {
    bytes memory _staticData = encodeStatic(
      _table.minPrice,
      _table.startingPrice,
      _table.rate,
      _table.multiplier,
      _table.mintCutoff
    );

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function _set(SeasonPassConfigData memory _table) internal {
    bytes memory _staticData = encodeStatic(
      _table.minPrice,
      _table.startingPrice,
      _table.rate,
      _table.multiplier,
      _table.mintCutoff
    );

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Decode the tightly packed blob of static data using this table's field layout.
   */
  function decodeStatic(
    bytes memory _blob
  )
    internal
    pure
    returns (uint256 minPrice, uint256 startingPrice, uint256 rate, uint256 multiplier, uint256 mintCutoff)
  {
    minPrice = (uint256(Bytes.getBytes32(_blob, 0)));

    startingPrice = (uint256(Bytes.getBytes32(_blob, 32)));

    rate = (uint256(Bytes.getBytes32(_blob, 64)));

    multiplier = (uint256(Bytes.getBytes32(_blob, 96)));

    mintCutoff = (uint256(Bytes.getBytes32(_blob, 128)));
  }

  /**
   * @notice Decode the tightly packed blobs using this table's field layout.
   * @param _staticData Tightly packed static fields.
   *
   *
   */
  function decode(
    bytes memory _staticData,
    EncodedLengths,
    bytes memory
  ) internal pure returns (SeasonPassConfigData memory _table) {
    (_table.minPrice, _table.startingPrice, _table.rate, _table.multiplier, _table.mintCutoff) = decodeStatic(
      _staticData
    );
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord() internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord() internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack static (fixed length) data using this table's schema.
   * @return The static data, encoded into a sequence of bytes.
   */
  function encodeStatic(
    uint256 minPrice,
    uint256 startingPrice,
    uint256 rate,
    uint256 multiplier,
    uint256 mintCutoff
  ) internal pure returns (bytes memory) {
    return abi.encodePacked(minPrice, startingPrice, rate, multiplier, mintCutoff);
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dynamic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(
    uint256 minPrice,
    uint256 startingPrice,
    uint256 rate,
    uint256 multiplier,
    uint256 mintCutoff
  ) internal pure returns (bytes memory, EncodedLengths, bytes memory) {
    bytes memory _staticData = encodeStatic(minPrice, startingPrice, rate, multiplier, mintCutoff);

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple() internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    return _keyTuple;
  }
}
