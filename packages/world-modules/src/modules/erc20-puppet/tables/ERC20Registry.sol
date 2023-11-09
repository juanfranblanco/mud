// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

/* Autogenerated file. Do not edit manually. */

// Import schema type
import { SchemaType } from "@latticexyz/schema-type/src/solidity/SchemaType.sol";

// Import store internals
import { IStore } from "@latticexyz/store/src/IStore.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { StoreCore } from "@latticexyz/store/src/StoreCore.sol";
import { Bytes } from "@latticexyz/store/src/Bytes.sol";
import { Memory } from "@latticexyz/store/src/Memory.sol";
import { SliceLib } from "@latticexyz/store/src/Slice.sol";
import { EncodeArray } from "@latticexyz/store/src/tightcoder/EncodeArray.sol";
import { FieldLayout, FieldLayoutLib } from "@latticexyz/store/src/FieldLayout.sol";
import { Schema, SchemaLib } from "@latticexyz/store/src/Schema.sol";
import { PackedCounter, PackedCounterLib } from "@latticexyz/store/src/PackedCounter.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";
import { RESOURCE_TABLE, RESOURCE_OFFCHAIN_TABLE } from "@latticexyz/store/src/storeResourceTypes.sol";

// Import user types
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";

FieldLayout constant _fieldLayout = FieldLayout.wrap(
  0x0014010014000000000000000000000000000000000000000000000000000000
);

library ERC20Registry {
  /**
   * @notice Get the table values' field layout.
   * @return _fieldLayout The field layout for the table.
   */
  function getFieldLayout() internal pure returns (FieldLayout) {
    return _fieldLayout;
  }

  /**
   * @notice Get the table's key schema.
   * @return _keySchema The key schema for the table.
   */
  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _keySchema = new SchemaType[](1);
    _keySchema[0] = SchemaType.BYTES32;

    return SchemaLib.encode(_keySchema);
  }

  /**
   * @notice Get the table's value schema.
   * @return _valueSchema The value schema for the table.
   */
  function getValueSchema() internal pure returns (Schema) {
    SchemaType[] memory _valueSchema = new SchemaType[](1);
    _valueSchema[0] = SchemaType.ADDRESS;

    return SchemaLib.encode(_valueSchema);
  }

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](1);
    keyNames[0] = "namespaceId";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](1);
    fieldNames[0] = "erc20Address";
  }

  /**
   * @notice Register the table with its config.
   */
  function register(ResourceId _tableId) internal {
    StoreSwitch.registerTable(_tableId, _fieldLayout, getKeySchema(), getValueSchema(), getKeyNames(), getFieldNames());
  }

  /**
   * @notice Register the table with its config.
   */
  function _register(ResourceId _tableId) internal {
    StoreCore.registerTable(_tableId, _fieldLayout, getKeySchema(), getValueSchema(), getKeyNames(), getFieldNames());
  }

  /**
   * @notice Get erc20Address.
   */
  function getErc20Address(ResourceId _tableId, ResourceId namespaceId) internal view returns (address erc20Address) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(namespaceId);

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Get erc20Address.
   */
  function getErc20Address(
    ResourceId _tableId,
    bytes32[] memory _keyTuple
  ) internal view returns (address erc20Address) {
    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Get erc20Address.
   */
  function _getErc20Address(ResourceId _tableId, ResourceId namespaceId) internal view returns (address erc20Address) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(namespaceId);

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Get erc20Address.
   */
  function _getErc20Address(
    ResourceId _tableId,
    bytes32[] memory _keyTuple
  ) internal view returns (address erc20Address) {
    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Get erc20Address.
   */
  function get(ResourceId _tableId, ResourceId namespaceId) internal view returns (address erc20Address) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(namespaceId);

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Get erc20Address.
   */
  function get(ResourceId _tableId, bytes32[] memory _keyTuple) internal view returns (address erc20Address) {
    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Get erc20Address.
   */
  function _get(ResourceId _tableId, ResourceId namespaceId) internal view returns (address erc20Address) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(namespaceId);

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Get erc20Address.
   */
  function _get(ResourceId _tableId, bytes32[] memory _keyTuple) internal view returns (address erc20Address) {
    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Set erc20Address.
   */
  function setErc20Address(ResourceId _tableId, ResourceId namespaceId, address erc20Address) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(namespaceId);

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((erc20Address)), _fieldLayout);
  }

  /**
   * @notice Set erc20Address.
   */
  function setErc20Address(ResourceId _tableId, bytes32[] memory _keyTuple, address erc20Address) internal {
    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((erc20Address)), _fieldLayout);
  }

  /**
   * @notice Set erc20Address.
   */
  function _setErc20Address(ResourceId _tableId, ResourceId namespaceId, address erc20Address) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(namespaceId);

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((erc20Address)), _fieldLayout);
  }

  /**
   * @notice Set erc20Address.
   */
  function _setErc20Address(ResourceId _tableId, bytes32[] memory _keyTuple, address erc20Address) internal {
    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((erc20Address)), _fieldLayout);
  }

  /**
   * @notice Set erc20Address.
   */
  function set(ResourceId _tableId, ResourceId namespaceId, address erc20Address) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(namespaceId);

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((erc20Address)), _fieldLayout);
  }

  /**
   * @notice Set erc20Address.
   */
  function set(ResourceId _tableId, bytes32[] memory _keyTuple, address erc20Address) internal {
    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((erc20Address)), _fieldLayout);
  }

  /**
   * @notice Set erc20Address.
   */
  function _set(ResourceId _tableId, ResourceId namespaceId, address erc20Address) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(namespaceId);

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((erc20Address)), _fieldLayout);
  }

  /**
   * @notice Set erc20Address.
   */
  function _set(ResourceId _tableId, bytes32[] memory _keyTuple, address erc20Address) internal {
    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((erc20Address)), _fieldLayout);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(ResourceId _tableId, ResourceId namespaceId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(namespaceId);

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(ResourceId _tableId, bytes32[] memory _keyTuple) internal {
    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(ResourceId _tableId, ResourceId namespaceId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(namespaceId);

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(ResourceId _tableId, bytes32[] memory _keyTuple) internal {
    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack static (fixed length) data using this table's schema.
   * @return The static data, encoded into a sequence of bytes.
   */
  function encodeStatic(address erc20Address) internal pure returns (bytes memory) {
    return abi.encodePacked(erc20Address);
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dyanmic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(address erc20Address) internal pure returns (bytes memory, PackedCounter, bytes memory) {
    bytes memory _staticData = encodeStatic(erc20Address);

    PackedCounter _encodedLengths;
    bytes memory _dynamicData;

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */

  function encodeKeyTuple(ResourceId namespaceId) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = ResourceId.unwrap(namespaceId);

    return _keyTuple;
  }
}
