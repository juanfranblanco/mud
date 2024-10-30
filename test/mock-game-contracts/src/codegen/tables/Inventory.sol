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

library Inventory {
  // Hex below is the result of `WorldResourceIdLib.encode({ namespace: "", name: "Inventory", typeId: RESOURCE_TABLE });`
  ResourceId constant _tableId = ResourceId.wrap(0x74620000000000000000000000000000496e76656e746f727900000000000000);

  FieldLayout constant _fieldLayout =
    FieldLayout.wrap(0x0004010004000000000000000000000000000000000000000000000000000000);

  // Hex-encoded key schema of (address, uint8)
  Schema constant _keySchema = Schema.wrap(0x0015020061000000000000000000000000000000000000000000000000000000);
  // Hex-encoded value schema of (uint32)
  Schema constant _valueSchema = Schema.wrap(0x0004010003000000000000000000000000000000000000000000000000000000);

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](2);
    keyNames[0] = "player";
    keyNames[1] = "item";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](1);
    fieldNames[0] = "amount";
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
  function getAmount(address player, uint8 item) internal view returns (uint32 amount) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint160(player)));
    _keyTuple[1] = bytes32(uint256(item));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (uint32(bytes4(_blob)));
  }

  /**
   * @notice Get amount.
   */
  function _getAmount(address player, uint8 item) internal view returns (uint32 amount) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint160(player)));
    _keyTuple[1] = bytes32(uint256(item));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (uint32(bytes4(_blob)));
  }

  /**
   * @notice Get amount.
   */
  function get(address player, uint8 item) internal view returns (uint32 amount) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint160(player)));
    _keyTuple[1] = bytes32(uint256(item));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (uint32(bytes4(_blob)));
  }

  /**
   * @notice Get amount.
   */
  function _get(address player, uint8 item) internal view returns (uint32 amount) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint160(player)));
    _keyTuple[1] = bytes32(uint256(item));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (uint32(bytes4(_blob)));
  }

  /**
   * @notice Set amount.
   */
  function setAmount(address player, uint8 item, uint32 amount) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint160(player)));
    _keyTuple[1] = bytes32(uint256(item));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((amount)), _fieldLayout);
  }

  /**
   * @notice Set amount.
   */
  function _setAmount(address player, uint8 item, uint32 amount) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint160(player)));
    _keyTuple[1] = bytes32(uint256(item));

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((amount)), _fieldLayout);
  }

  /**
   * @notice Set amount.
   */
  function set(address player, uint8 item, uint32 amount) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint160(player)));
    _keyTuple[1] = bytes32(uint256(item));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((amount)), _fieldLayout);
  }

  /**
   * @notice Set amount.
   */
  function _set(address player, uint8 item, uint32 amount) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint160(player)));
    _keyTuple[1] = bytes32(uint256(item));

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((amount)), _fieldLayout);
  }

  /**
   * @notice Delete all data for given key.
   */
  function deleteRecord(address player, uint8 item) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint160(player)));
    _keyTuple[1] = bytes32(uint256(item));

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given key.
   */
  function _deleteRecord(address player, uint8 item) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint160(player)));
    _keyTuple[1] = bytes32(uint256(item));

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack static (fixed length) data using this table's schema.
   * @return The static data, encoded into a sequence of bytes.
   */
  function encodeStatic(uint32 amount) internal pure returns (bytes memory) {
    return abi.encodePacked(amount);
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dynamic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(uint32 amount) internal pure returns (bytes memory, EncodedLengths, bytes memory) {
    bytes memory _staticData = encodeStatic(amount);

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(address player, uint8 item) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(uint160(player)));
    _keyTuple[1] = bytes32(uint256(item));

    return _keyTuple;
  }
}
