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

library ResourceTag {
  // Hex below is the result of `WorldResourceIdLib.encode({ namespace: "metadata", name: "ResourceTag", typeId: RESOURCE_TABLE });`
  ResourceId constant _tableId = ResourceId.wrap(0x74626d657461646174610000000000005265736f757263655461670000000000);

  FieldLayout constant _fieldLayout =
    FieldLayout.wrap(0x0000000100000000000000000000000000000000000000000000000000000000);

  // Hex-encoded key schema of (bytes32, bytes32)
  Schema constant _keySchema = Schema.wrap(0x004002005f5f0000000000000000000000000000000000000000000000000000);
  // Hex-encoded value schema of (bytes)
  Schema constant _valueSchema = Schema.wrap(0x00000001c4000000000000000000000000000000000000000000000000000000);

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](2);
    keyNames[0] = "resource";
    keyNames[1] = "tag";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](1);
    fieldNames[0] = "value";
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
   * @notice Get value.
   */
  function getValue(ResourceId resource, bytes32 tag) internal view returns (bytes memory value) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 0);
    return (bytes(_blob));
  }

  /**
   * @notice Get value.
   */
  function _getValue(ResourceId resource, bytes32 tag) internal view returns (bytes memory value) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 0);
    return (bytes(_blob));
  }

  /**
   * @notice Get value.
   */
  function get(ResourceId resource, bytes32 tag) internal view returns (bytes memory value) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 0);
    return (bytes(_blob));
  }

  /**
   * @notice Get value.
   */
  function _get(ResourceId resource, bytes32 tag) internal view returns (bytes memory value) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 0);
    return (bytes(_blob));
  }

  /**
   * @notice Set value.
   */
  function setValue(ResourceId resource, bytes32 tag, bytes memory value) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 0, bytes((value)));
  }

  /**
   * @notice Set value.
   */
  function _setValue(ResourceId resource, bytes32 tag, bytes memory value) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    StoreCore.setDynamicField(_tableId, _keyTuple, 0, bytes((value)));
  }

  /**
   * @notice Set value.
   */
  function set(ResourceId resource, bytes32 tag, bytes memory value) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 0, bytes((value)));
  }

  /**
   * @notice Set value.
   */
  function _set(ResourceId resource, bytes32 tag, bytes memory value) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    StoreCore.setDynamicField(_tableId, _keyTuple, 0, bytes((value)));
  }

  /**
   * @notice Get the length of value.
   */
  function lengthValue(ResourceId resource, bytes32 tag) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get the length of value.
   */
  function _lengthValue(ResourceId resource, bytes32 tag) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get the length of value.
   */
  function length(ResourceId resource, bytes32 tag) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get the length of value.
   */
  function _length(ResourceId resource, bytes32 tag) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get an item of value.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemValue(ResourceId resource, bytes32 tag, uint256 _index) internal view returns (bytes memory) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 1, (_index + 1) * 1);
      return (bytes(_blob));
    }
  }

  /**
   * @notice Get an item of value.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItemValue(ResourceId resource, bytes32 tag, uint256 _index) internal view returns (bytes memory) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 1, (_index + 1) * 1);
      return (bytes(_blob));
    }
  }

  /**
   * @notice Get an item of value.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItem(ResourceId resource, bytes32 tag, uint256 _index) internal view returns (bytes memory) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 1, (_index + 1) * 1);
      return (bytes(_blob));
    }
  }

  /**
   * @notice Get an item of value.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItem(ResourceId resource, bytes32 tag, uint256 _index) internal view returns (bytes memory) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 1, (_index + 1) * 1);
      return (bytes(_blob));
    }
  }

  /**
   * @notice Push a slice to value.
   */
  function pushValue(ResourceId resource, bytes32 tag, bytes memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 0, bytes((_slice)));
  }

  /**
   * @notice Push a slice to value.
   */
  function _pushValue(ResourceId resource, bytes32 tag, bytes memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 0, bytes((_slice)));
  }

  /**
   * @notice Push a slice to value.
   */
  function push(ResourceId resource, bytes32 tag, bytes memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 0, bytes((_slice)));
  }

  /**
   * @notice Push a slice to value.
   */
  function _push(ResourceId resource, bytes32 tag, bytes memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 0, bytes((_slice)));
  }

  /**
   * @notice Pop a slice from value.
   */
  function popValue(ResourceId resource, bytes32 tag) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 0, 1);
  }

  /**
   * @notice Pop a slice from value.
   */
  function _popValue(ResourceId resource, bytes32 tag) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 0, 1);
  }

  /**
   * @notice Pop a slice from value.
   */
  function pop(ResourceId resource, bytes32 tag) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 0, 1);
  }

  /**
   * @notice Pop a slice from value.
   */
  function _pop(ResourceId resource, bytes32 tag) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 0, 1);
  }

  /**
   * @notice Update a slice of value at `_index`.
   */
  function updateValue(ResourceId resource, bytes32 tag, uint256 _index, bytes memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update a slice of value at `_index`.
   */
  function _updateValue(ResourceId resource, bytes32 tag, uint256 _index, bytes memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update a slice of value at `_index`.
   */
  function update(ResourceId resource, bytes32 tag, uint256 _index, bytes memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update a slice of value at `_index`.
   */
  function _update(ResourceId resource, bytes32 tag, uint256 _index, bytes memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Delete all data for given key.
   */
  function deleteRecord(ResourceId resource, bytes32 tag) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given key.
   */
  function _deleteRecord(ResourceId resource, bytes32 tag) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack dynamic data lengths using this table's schema.
   * @return _encodedLengths The lengths of the dynamic fields (packed into a single bytes32 value).
   */
  function encodeLengths(bytes memory value) internal pure returns (EncodedLengths _encodedLengths) {
    // Lengths are effectively checked during copy by 2**40 bytes exceeding gas limits
    unchecked {
      _encodedLengths = EncodedLengthsLib.pack(bytes(value).length);
    }
  }

  /**
   * @notice Tightly pack dynamic (variable length) data using this table's schema.
   * @return The dynamic data, encoded into a sequence of bytes.
   */
  function encodeDynamic(bytes memory value) internal pure returns (bytes memory) {
    return abi.encodePacked(bytes((value)));
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dynamic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(bytes memory value) internal pure returns (bytes memory, EncodedLengths, bytes memory) {
    bytes memory _staticData;
    EncodedLengths _encodedLengths = encodeLengths(value);
    bytes memory _dynamicData = encodeDynamic(value);

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(ResourceId resource, bytes32 tag) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = ResourceId.unwrap(resource);
    _keyTuple[1] = tag;

    return _keyTuple;
  }
}
