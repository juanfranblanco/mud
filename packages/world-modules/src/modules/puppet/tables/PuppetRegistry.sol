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

// Import user types
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";

library PuppetRegistry {
  FieldLayout constant _fieldLayout =
    FieldLayout.wrap(0x0014010014000000000000000000000000000000000000000000000000000000);

  // Hex-encoded key schema of (bytes32)
  Schema constant _keySchema = Schema.wrap(0x002001005f000000000000000000000000000000000000000000000000000000);
  // Hex-encoded value schema of (address)
  Schema constant _valueSchema = Schema.wrap(0x0014010061000000000000000000000000000000000000000000000000000000);

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](1);
    keyNames[0] = "systemId";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](1);
    fieldNames[0] = "puppet";
  }

  /**
   * @notice Register the table with its config.
   */
  function register(ResourceId _tableId) internal {
    StoreSwitch.registerTable(_tableId, _fieldLayout, _keySchema, _valueSchema, getKeyNames(), getFieldNames());
  }

  /**
   * @notice Register the table with its config.
   */
  function _register(ResourceId _tableId) internal {
    StoreCore.registerTable(_tableId, _fieldLayout, _keySchema, _valueSchema, getKeyNames(), getFieldNames());
  }

  /**
   * @notice Get puppet.
   */
  function getPuppet(ResourceId _tableId, ResourceId systemId) internal view returns (address puppet) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(systemId);

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Get puppet.
   */
  function _getPuppet(ResourceId _tableId, ResourceId systemId) internal view returns (address puppet) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(systemId);

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Get puppet.
   */
  function get(ResourceId _tableId, ResourceId systemId) internal view returns (address puppet) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(systemId);

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Get puppet.
   */
  function _get(ResourceId _tableId, ResourceId systemId) internal view returns (address puppet) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(systemId);

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Set puppet.
   */
  function setPuppet(ResourceId _tableId, ResourceId systemId, address puppet) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(systemId);

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((puppet)), _fieldLayout);
  }

  /**
   * @notice Set puppet.
   */
  function _setPuppet(ResourceId _tableId, ResourceId systemId, address puppet) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(systemId);

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((puppet)), _fieldLayout);
  }

  /**
   * @notice Set puppet.
   */
  function set(ResourceId _tableId, ResourceId systemId, address puppet) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(systemId);

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((puppet)), _fieldLayout);
  }

  /**
   * @notice Set puppet.
   */
  function _set(ResourceId _tableId, ResourceId systemId, address puppet) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(systemId);

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((puppet)), _fieldLayout);
  }

  /**
   * @notice Delete all data for given key.
   */
  function deleteRecord(ResourceId _tableId, ResourceId systemId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(systemId);

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given key.
   */
  function _deleteRecord(ResourceId _tableId, ResourceId systemId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(systemId);

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack static (fixed length) data using this table's schema.
   * @return The static data, encoded into a sequence of bytes.
   */
  function encodeStatic(address puppet) internal pure returns (bytes memory) {
    return abi.encodePacked(puppet);
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dynamic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(address puppet) internal pure returns (bytes memory, EncodedLengths, bytes memory) {
    bytes memory _staticData = encodeStatic(puppet);

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(ResourceId systemId) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(systemId);

    return _keyTuple;
  }
}
