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

ResourceId constant _tableId = ResourceId.wrap(
  bytes32(abi.encodePacked(RESOURCE_TABLE, bytes14(""), bytes16("Dynamics2")))
);
ResourceId constant Dynamics2TableId = _tableId;

FieldLayout constant _fieldLayout = FieldLayout.wrap(
  0x0000000300000000000000000000000000000000000000000000000000000000
);

struct Dynamics2Data {
  uint64[] u64;
  string str;
  bytes b;
}

library Dynamics2 {
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
    SchemaType[] memory _valueSchema = new SchemaType[](3);
    _valueSchema[0] = SchemaType.UINT64_ARRAY;
    _valueSchema[1] = SchemaType.STRING;
    _valueSchema[2] = SchemaType.BYTES;

    return SchemaLib.encode(_valueSchema);
  }

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](1);
    keyNames[0] = "key";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](3);
    fieldNames[0] = "u64";
    fieldNames[1] = "str";
    fieldNames[2] = "b";
  }

  /**
   * @notice Register the table with its config.
   */
  function register() internal {
    StoreSwitch.registerTable(_tableId, _fieldLayout, getKeySchema(), getValueSchema(), getKeyNames(), getFieldNames());
  }

  /**
   * @notice Register the table with its config.
   */
  function _register() internal {
    StoreCore.registerTable(_tableId, _fieldLayout, getKeySchema(), getValueSchema(), getKeyNames(), getFieldNames());
  }

  /**
   * @notice Get u64.
   */
  function getU64(bytes32 key) internal view returns (uint64[] memory u64) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint64());
  }

  /**
   * @notice Get u64.
   */
  function getU64(bytes32[] memory _keyTuple) internal view returns (uint64[] memory u64) {
    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint64());
  }

  /**
   * @notice Get u64.
   */
  function _getU64(bytes32 key) internal view returns (uint64[] memory u64) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint64());
  }

  /**
   * @notice Get u64.
   */
  function _getU64(bytes32[] memory _keyTuple) internal view returns (uint64[] memory u64) {
    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint64());
  }

  /**
   * @notice Set u64.
   */
  function setU64(bytes32 key, uint64[] memory u64) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode((u64)));
  }

  /**
   * @notice Set u64.
   */
  function setU64(bytes32[] memory _keyTuple, uint64[] memory u64) internal {
    StoreSwitch.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode((u64)));
  }

  /**
   * @notice Set u64.
   */
  function _setU64(bytes32 key, uint64[] memory u64) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    StoreCore.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode((u64)));
  }

  /**
   * @notice Set u64.
   */
  function _setU64(bytes32[] memory _keyTuple, uint64[] memory u64) internal {
    StoreCore.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode((u64)));
  }

  /**
   * @notice Get the length of u64.
   */
  function lengthU64(bytes32 key) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 8;
    }
  }

  /**
   * @notice Get the length of u64.
   */
  function lengthU64(bytes32[] memory _keyTuple) internal view returns (uint256) {
    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 8;
    }
  }

  /**
   * @notice Get the length of u64.
   */
  function _lengthU64(bytes32 key) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 8;
    }
  }

  /**
   * @notice Get the length of u64.
   */
  function _lengthU64(bytes32[] memory _keyTuple) internal view returns (uint256) {
    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 8;
    }
  }

  /**
   * @notice Get an item of u64.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemU64(bytes32 key, uint256 _index) internal view returns (uint64) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 8, (_index + 1) * 8);
      return (uint64(bytes8(_blob)));
    }
  }

  /**
   * @notice Get an item of u64.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemU64(bytes32[] memory _keyTuple, uint256 _index) internal view returns (uint64) {
    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 8, (_index + 1) * 8);
      return (uint64(bytes8(_blob)));
    }
  }

  /**
   * @notice Get an item of u64.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItemU64(bytes32 key, uint256 _index) internal view returns (uint64) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 8, (_index + 1) * 8);
      return (uint64(bytes8(_blob)));
    }
  }

  /**
   * @notice Get an item of u64.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItemU64(bytes32[] memory _keyTuple, uint256 _index) internal view returns (uint64) {
    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 8, (_index + 1) * 8);
      return (uint64(bytes8(_blob)));
    }
  }

  /**
   * @notice Push an element to u64.
   */
  function pushU64(bytes32 key, uint64 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Push an element to u64.
   */
  function pushU64(bytes32[] memory _keyTuple, uint64 _element) internal {
    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Push an element to u64.
   */
  function _pushU64(bytes32 key, uint64 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Push an element to u64.
   */
  function _pushU64(bytes32[] memory _keyTuple, uint64 _element) internal {
    StoreCore.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Pop an element from u64.
   */
  function popU64(bytes32 key) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 0, 8);
  }

  /**
   * @notice Pop an element from u64.
   */
  function popU64(bytes32[] memory _keyTuple) internal {
    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 0, 8);
  }

  /**
   * @notice Pop an element from u64.
   */
  function _popU64(bytes32 key) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 0, 8);
  }

  /**
   * @notice Pop an element from u64.
   */
  function _popU64(bytes32[] memory _keyTuple) internal {
    StoreCore.popFromDynamicField(_tableId, _keyTuple, 0, 8);
  }

  /**
   * @notice Update an element of u64 at `_index`.
   */
  function updateU64(bytes32 key, uint256 _index, uint64 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 8), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update an element of u64 at `_index`.
   */
  function updateU64(bytes32[] memory _keyTuple, uint256 _index, uint64 _element) internal {
    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 8), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update an element of u64 at `_index`.
   */
  function _updateU64(bytes32 key, uint256 _index, uint64 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 8), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update an element of u64 at `_index`.
   */
  function _updateU64(bytes32[] memory _keyTuple, uint256 _index, uint64 _element) internal {
    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 8), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Get str.
   */
  function getStr(bytes32 key) internal view returns (string memory str) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 1);
    return (string(_blob));
  }

  /**
   * @notice Get str.
   */
  function getStr(bytes32[] memory _keyTuple) internal view returns (string memory str) {
    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 1);
    return (string(_blob));
  }

  /**
   * @notice Get str.
   */
  function _getStr(bytes32 key) internal view returns (string memory str) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 1);
    return (string(_blob));
  }

  /**
   * @notice Get str.
   */
  function _getStr(bytes32[] memory _keyTuple) internal view returns (string memory str) {
    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 1);
    return (string(_blob));
  }

  /**
   * @notice Set str.
   */
  function setStr(bytes32 key, string memory str) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 1, bytes((str)));
  }

  /**
   * @notice Set str.
   */
  function setStr(bytes32[] memory _keyTuple, string memory str) internal {
    StoreSwitch.setDynamicField(_tableId, _keyTuple, 1, bytes((str)));
  }

  /**
   * @notice Set str.
   */
  function _setStr(bytes32 key, string memory str) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    StoreCore.setDynamicField(_tableId, _keyTuple, 1, bytes((str)));
  }

  /**
   * @notice Set str.
   */
  function _setStr(bytes32[] memory _keyTuple, string memory str) internal {
    StoreCore.setDynamicField(_tableId, _keyTuple, 1, bytes((str)));
  }

  /**
   * @notice Get the length of str.
   */
  function lengthStr(bytes32 key) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 1);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get the length of str.
   */
  function lengthStr(bytes32[] memory _keyTuple) internal view returns (uint256) {
    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 1);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get the length of str.
   */
  function _lengthStr(bytes32 key) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 1);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get the length of str.
   */
  function _lengthStr(bytes32[] memory _keyTuple) internal view returns (uint256) {
    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 1);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get an item of str.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemStr(bytes32 key, uint256 _index) internal view returns (string memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 1, _index * 1, (_index + 1) * 1);
      return (string(_blob));
    }
  }

  /**
   * @notice Get an item of str.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemStr(bytes32[] memory _keyTuple, uint256 _index) internal view returns (string memory) {
    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 1, _index * 1, (_index + 1) * 1);
      return (string(_blob));
    }
  }

  /**
   * @notice Get an item of str.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItemStr(bytes32 key, uint256 _index) internal view returns (string memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 1, _index * 1, (_index + 1) * 1);
      return (string(_blob));
    }
  }

  /**
   * @notice Get an item of str.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItemStr(bytes32[] memory _keyTuple, uint256 _index) internal view returns (string memory) {
    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 1, _index * 1, (_index + 1) * 1);
      return (string(_blob));
    }
  }

  /**
   * @notice Push a slice to str.
   */
  function pushStr(bytes32 key, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 1, bytes((_slice)));
  }

  /**
   * @notice Push a slice to str.
   */
  function pushStr(bytes32[] memory _keyTuple, string memory _slice) internal {
    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 1, bytes((_slice)));
  }

  /**
   * @notice Push a slice to str.
   */
  function _pushStr(bytes32 key, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 1, bytes((_slice)));
  }

  /**
   * @notice Push a slice to str.
   */
  function _pushStr(bytes32[] memory _keyTuple, string memory _slice) internal {
    StoreCore.pushToDynamicField(_tableId, _keyTuple, 1, bytes((_slice)));
  }

  /**
   * @notice Pop a slice from str.
   */
  function popStr(bytes32 key) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 1, 1);
  }

  /**
   * @notice Pop a slice from str.
   */
  function popStr(bytes32[] memory _keyTuple) internal {
    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 1, 1);
  }

  /**
   * @notice Pop a slice from str.
   */
  function _popStr(bytes32 key) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 1, 1);
  }

  /**
   * @notice Pop a slice from str.
   */
  function _popStr(bytes32[] memory _keyTuple) internal {
    StoreCore.popFromDynamicField(_tableId, _keyTuple, 1, 1);
  }

  /**
   * @notice Update a slice of str at `_index`.
   */
  function updateStr(bytes32 key, uint256 _index, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 1, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update a slice of str at `_index`.
   */
  function updateStr(bytes32[] memory _keyTuple, uint256 _index, string memory _slice) internal {
    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 1, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update a slice of str at `_index`.
   */
  function _updateStr(bytes32 key, uint256 _index, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 1, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update a slice of str at `_index`.
   */
  function _updateStr(bytes32[] memory _keyTuple, uint256 _index, string memory _slice) internal {
    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 1, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Get b.
   */
  function getB(bytes32 key) internal view returns (bytes memory b) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 2);
    return (bytes(_blob));
  }

  /**
   * @notice Get b.
   */
  function getB(bytes32[] memory _keyTuple) internal view returns (bytes memory b) {
    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 2);
    return (bytes(_blob));
  }

  /**
   * @notice Get b.
   */
  function _getB(bytes32 key) internal view returns (bytes memory b) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 2);
    return (bytes(_blob));
  }

  /**
   * @notice Get b.
   */
  function _getB(bytes32[] memory _keyTuple) internal view returns (bytes memory b) {
    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 2);
    return (bytes(_blob));
  }

  /**
   * @notice Set b.
   */
  function setB(bytes32 key, bytes memory b) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 2, bytes((b)));
  }

  /**
   * @notice Set b.
   */
  function setB(bytes32[] memory _keyTuple, bytes memory b) internal {
    StoreSwitch.setDynamicField(_tableId, _keyTuple, 2, bytes((b)));
  }

  /**
   * @notice Set b.
   */
  function _setB(bytes32 key, bytes memory b) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    StoreCore.setDynamicField(_tableId, _keyTuple, 2, bytes((b)));
  }

  /**
   * @notice Set b.
   */
  function _setB(bytes32[] memory _keyTuple, bytes memory b) internal {
    StoreCore.setDynamicField(_tableId, _keyTuple, 2, bytes((b)));
  }

  /**
   * @notice Get the length of b.
   */
  function lengthB(bytes32 key) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 2);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get the length of b.
   */
  function lengthB(bytes32[] memory _keyTuple) internal view returns (uint256) {
    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 2);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get the length of b.
   */
  function _lengthB(bytes32 key) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 2);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get the length of b.
   */
  function _lengthB(bytes32[] memory _keyTuple) internal view returns (uint256) {
    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 2);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get an item of b.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemB(bytes32 key, uint256 _index) internal view returns (bytes memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 2, _index * 1, (_index + 1) * 1);
      return (bytes(_blob));
    }
  }

  /**
   * @notice Get an item of b.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemB(bytes32[] memory _keyTuple, uint256 _index) internal view returns (bytes memory) {
    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 2, _index * 1, (_index + 1) * 1);
      return (bytes(_blob));
    }
  }

  /**
   * @notice Get an item of b.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItemB(bytes32 key, uint256 _index) internal view returns (bytes memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 2, _index * 1, (_index + 1) * 1);
      return (bytes(_blob));
    }
  }

  /**
   * @notice Get an item of b.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItemB(bytes32[] memory _keyTuple, uint256 _index) internal view returns (bytes memory) {
    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 2, _index * 1, (_index + 1) * 1);
      return (bytes(_blob));
    }
  }

  /**
   * @notice Push a slice to b.
   */
  function pushB(bytes32 key, bytes memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 2, bytes((_slice)));
  }

  /**
   * @notice Push a slice to b.
   */
  function pushB(bytes32[] memory _keyTuple, bytes memory _slice) internal {
    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 2, bytes((_slice)));
  }

  /**
   * @notice Push a slice to b.
   */
  function _pushB(bytes32 key, bytes memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 2, bytes((_slice)));
  }

  /**
   * @notice Push a slice to b.
   */
  function _pushB(bytes32[] memory _keyTuple, bytes memory _slice) internal {
    StoreCore.pushToDynamicField(_tableId, _keyTuple, 2, bytes((_slice)));
  }

  /**
   * @notice Pop a slice from b.
   */
  function popB(bytes32 key) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 2, 1);
  }

  /**
   * @notice Pop a slice from b.
   */
  function popB(bytes32[] memory _keyTuple) internal {
    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 2, 1);
  }

  /**
   * @notice Pop a slice from b.
   */
  function _popB(bytes32 key) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 2, 1);
  }

  /**
   * @notice Pop a slice from b.
   */
  function _popB(bytes32[] memory _keyTuple) internal {
    StoreCore.popFromDynamicField(_tableId, _keyTuple, 2, 1);
  }

  /**
   * @notice Update a slice of b at `_index`.
   */
  function updateB(bytes32 key, uint256 _index, bytes memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 2, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update a slice of b at `_index`.
   */
  function updateB(bytes32[] memory _keyTuple, uint256 _index, bytes memory _slice) internal {
    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 2, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update a slice of b at `_index`.
   */
  function _updateB(bytes32 key, uint256 _index, bytes memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 2, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update a slice of b at `_index`.
   */
  function _updateB(bytes32[] memory _keyTuple, uint256 _index, bytes memory _slice) internal {
    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 2, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Get the full data.
   */
  function get(bytes32 key) internal view returns (Dynamics2Data memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    (bytes memory _staticData, PackedCounter _encodedLengths, bytes memory _dynamicData) = StoreSwitch.getRecord(
      _tableId,
      _keyTuple,
      _fieldLayout
    );
    return decode(_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Get the full data.
   */
  function get(bytes32[] memory _keyTuple) internal view returns (Dynamics2Data memory _table) {
    (bytes memory _staticData, PackedCounter _encodedLengths, bytes memory _dynamicData) = StoreSwitch.getRecord(
      _tableId,
      _keyTuple,
      _fieldLayout
    );
    return decode(_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Get the full data.
   */
  function _get(bytes32 key) internal view returns (Dynamics2Data memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    (bytes memory _staticData, PackedCounter _encodedLengths, bytes memory _dynamicData) = StoreCore.getRecord(
      _tableId,
      _keyTuple,
      _fieldLayout
    );
    return decode(_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Get the full data.
   */
  function _get(bytes32[] memory _keyTuple) internal view returns (Dynamics2Data memory _table) {
    (bytes memory _staticData, PackedCounter _encodedLengths, bytes memory _dynamicData) = StoreCore.getRecord(
      _tableId,
      _keyTuple,
      _fieldLayout
    );
    return decode(_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function set(bytes32 key, uint64[] memory u64, string memory str, bytes memory b) internal {
    bytes memory _staticData;
    PackedCounter _encodedLengths = encodeLengths(u64, str, b);
    bytes memory _dynamicData = encodeDynamic(u64, str, b);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function set(bytes32[] memory _keyTuple, uint64[] memory u64, string memory str, bytes memory b) internal {
    bytes memory _staticData;
    PackedCounter _encodedLengths = encodeLengths(u64, str, b);
    bytes memory _dynamicData = encodeDynamic(u64, str, b);

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function _set(bytes32 key, uint64[] memory u64, string memory str, bytes memory b) internal {
    bytes memory _staticData;
    PackedCounter _encodedLengths = encodeLengths(u64, str, b);
    bytes memory _dynamicData = encodeDynamic(u64, str, b);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function _set(bytes32[] memory _keyTuple, uint64[] memory u64, string memory str, bytes memory b) internal {
    bytes memory _staticData;
    PackedCounter _encodedLengths = encodeLengths(u64, str, b);
    bytes memory _dynamicData = encodeDynamic(u64, str, b);

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function set(bytes32 key, Dynamics2Data memory _table) internal {
    bytes memory _staticData;
    PackedCounter _encodedLengths = encodeLengths(_table.u64, _table.str, _table.b);
    bytes memory _dynamicData = encodeDynamic(_table.u64, _table.str, _table.b);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function set(bytes32[] memory _keyTuple, Dynamics2Data memory _table) internal {
    bytes memory _staticData;
    PackedCounter _encodedLengths = encodeLengths(_table.u64, _table.str, _table.b);
    bytes memory _dynamicData = encodeDynamic(_table.u64, _table.str, _table.b);

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function _set(bytes32 key, Dynamics2Data memory _table) internal {
    bytes memory _staticData;
    PackedCounter _encodedLengths = encodeLengths(_table.u64, _table.str, _table.b);
    bytes memory _dynamicData = encodeDynamic(_table.u64, _table.str, _table.b);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function _set(bytes32[] memory _keyTuple, Dynamics2Data memory _table) internal {
    bytes memory _staticData;
    PackedCounter _encodedLengths = encodeLengths(_table.u64, _table.str, _table.b);
    bytes memory _dynamicData = encodeDynamic(_table.u64, _table.str, _table.b);

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Decode the tightly packed blob of dynamic data using the encoded lengths.
   */
  function decodeDynamic(
    PackedCounter _encodedLengths,
    bytes memory _blob
  ) internal pure returns (uint64[] memory u64, string memory str, bytes memory b) {
    uint256 _start;
    uint256 _end;
    unchecked {
      _end = _encodedLengths.atIndex(0);
    }
    u64 = (SliceLib.getSubslice(_blob, _start, _end).decodeArray_uint64());

    _start = _end;
    unchecked {
      _end += _encodedLengths.atIndex(1);
    }
    str = (string(SliceLib.getSubslice(_blob, _start, _end).toBytes()));

    _start = _end;
    unchecked {
      _end += _encodedLengths.atIndex(2);
    }
    b = (bytes(SliceLib.getSubslice(_blob, _start, _end).toBytes()));
  }

  /**
   * @notice Decode the tightly packed blobs using this table's field layout.
   *
   * @param _encodedLengths Encoded lengths of dynamic fields.
   * @param _dynamicData Tightly packed dynamic fields.
   */
  function decode(
    bytes memory,
    PackedCounter _encodedLengths,
    bytes memory _dynamicData
  ) internal pure returns (Dynamics2Data memory _table) {
    (_table.u64, _table.str, _table.b) = decodeDynamic(_encodedLengths, _dynamicData);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(bytes32 key) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(bytes32[] memory _keyTuple) internal {
    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(bytes32 key) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(bytes32[] memory _keyTuple) internal {
    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack dynamic data lengths using this table's schema.
   * @return _encodedLengths The lengths of the dynamic fields (packed into a single bytes32 value).
   */
  function encodeLengths(
    uint64[] memory u64,
    string memory str,
    bytes memory b
  ) internal pure returns (PackedCounter _encodedLengths) {
    // Lengths are effectively checked during copy by 2**40 bytes exceeding gas limits
    unchecked {
      _encodedLengths = PackedCounterLib.pack(u64.length * 8, bytes(str).length, bytes(b).length);
    }
  }

  /**
   * @notice Tightly pack dynamic (variable length) data using this table's schema.
   * @return The dynamic data, encoded into a sequence of bytes.
   */
  function encodeDynamic(uint64[] memory u64, string memory str, bytes memory b) internal pure returns (bytes memory) {
    return abi.encodePacked(EncodeArray.encode((u64)), bytes((str)), bytes((b)));
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dyanmic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(
    uint64[] memory u64,
    string memory str,
    bytes memory b
  ) internal pure returns (bytes memory, PackedCounter, bytes memory) {
    bytes memory _staticData;
    PackedCounter _encodedLengths = encodeLengths(u64, str, b);
    bytes memory _dynamicData = encodeDynamic(u64, str, b);

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */

  function encodeKeyTuple(bytes32 key) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = key;

    return _keyTuple;
  }
}
