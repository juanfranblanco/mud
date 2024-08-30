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

struct TokenData {
  uint8 decimals;
  uint256 totalSupply;
  address owner;
  string name;
  string symbol;
}

library Token {
  FieldLayout constant _fieldLayout =
    FieldLayout.wrap(0x0035030201201400000000000000000000000000000000000000000000000000);

  // Hex-encoded key schema of (bytes32)
  Schema constant _keySchema = Schema.wrap(0x002001005f000000000000000000000000000000000000000000000000000000);
  // Hex-encoded value schema of (uint8, uint256, address, string, string)
  Schema constant _valueSchema = Schema.wrap(0x00350302001f61c5c50000000000000000000000000000000000000000000000);

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](1);
    keyNames[0] = "id";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](5);
    fieldNames[0] = "decimals";
    fieldNames[1] = "totalSupply";
    fieldNames[2] = "owner";
    fieldNames[3] = "name";
    fieldNames[4] = "symbol";
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
   * @notice Register the table with its config (using the specified store).
   */
  function register(IStore _store, ResourceId _tableId) internal {
    _store.registerTable(_tableId, _fieldLayout, _keySchema, _valueSchema, getKeyNames(), getFieldNames());
  }

  /**
   * @notice Get decimals.
   */
  function getDecimals(ResourceId _tableId, bytes32 id) internal view returns (uint8 decimals) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (uint8(bytes1(_blob)));
  }

  /**
   * @notice Get decimals.
   */
  function _getDecimals(ResourceId _tableId, bytes32 id) internal view returns (uint8 decimals) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (uint8(bytes1(_blob)));
  }

  /**
   * @notice Get decimals (using the specified store).
   */
  function getDecimals(IStore _store, ResourceId _tableId, bytes32 id) internal view returns (uint8 decimals) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes32 _blob = _store.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (uint8(bytes1(_blob)));
  }

  /**
   * @notice Set decimals.
   */
  function setDecimals(ResourceId _tableId, bytes32 id, uint8 decimals) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((decimals)), _fieldLayout);
  }

  /**
   * @notice Set decimals.
   */
  function _setDecimals(ResourceId _tableId, bytes32 id, uint8 decimals) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((decimals)), _fieldLayout);
  }

  /**
   * @notice Set decimals (using the specified store).
   */
  function setDecimals(IStore _store, ResourceId _tableId, bytes32 id, uint8 decimals) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    _store.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((decimals)), _fieldLayout);
  }

  /**
   * @notice Get totalSupply.
   */
  function getTotalSupply(ResourceId _tableId, bytes32 id) internal view returns (uint256 totalSupply) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get totalSupply.
   */
  function _getTotalSupply(ResourceId _tableId, bytes32 id) internal view returns (uint256 totalSupply) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get totalSupply (using the specified store).
   */
  function getTotalSupply(IStore _store, ResourceId _tableId, bytes32 id) internal view returns (uint256 totalSupply) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes32 _blob = _store.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set totalSupply.
   */
  function setTotalSupply(ResourceId _tableId, bytes32 id, uint256 totalSupply) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((totalSupply)), _fieldLayout);
  }

  /**
   * @notice Set totalSupply.
   */
  function _setTotalSupply(ResourceId _tableId, bytes32 id, uint256 totalSupply) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreCore.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((totalSupply)), _fieldLayout);
  }

  /**
   * @notice Set totalSupply (using the specified store).
   */
  function setTotalSupply(IStore _store, ResourceId _tableId, bytes32 id, uint256 totalSupply) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    _store.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((totalSupply)), _fieldLayout);
  }

  /**
   * @notice Get owner.
   */
  function getOwner(ResourceId _tableId, bytes32 id) internal view returns (address owner) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Get owner.
   */
  function _getOwner(ResourceId _tableId, bytes32 id) internal view returns (address owner) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Get owner (using the specified store).
   */
  function getOwner(IStore _store, ResourceId _tableId, bytes32 id) internal view returns (address owner) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes32 _blob = _store.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Set owner.
   */
  function setOwner(ResourceId _tableId, bytes32 id, address owner) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked((owner)), _fieldLayout);
  }

  /**
   * @notice Set owner.
   */
  function _setOwner(ResourceId _tableId, bytes32 id, address owner) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreCore.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked((owner)), _fieldLayout);
  }

  /**
   * @notice Set owner (using the specified store).
   */
  function setOwner(IStore _store, ResourceId _tableId, bytes32 id, address owner) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    _store.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked((owner)), _fieldLayout);
  }

  /**
   * @notice Get name.
   */
  function getName(ResourceId _tableId, bytes32 id) internal view returns (string memory name) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 0);
    return (string(_blob));
  }

  /**
   * @notice Get name.
   */
  function _getName(ResourceId _tableId, bytes32 id) internal view returns (string memory name) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 0);
    return (string(_blob));
  }

  /**
   * @notice Get name (using the specified store).
   */
  function getName(IStore _store, ResourceId _tableId, bytes32 id) internal view returns (string memory name) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes memory _blob = _store.getDynamicField(_tableId, _keyTuple, 0);
    return (string(_blob));
  }

  /**
   * @notice Set name.
   */
  function setName(ResourceId _tableId, bytes32 id, string memory name) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 0, bytes((name)));
  }

  /**
   * @notice Set name.
   */
  function _setName(ResourceId _tableId, bytes32 id, string memory name) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreCore.setDynamicField(_tableId, _keyTuple, 0, bytes((name)));
  }

  /**
   * @notice Set name (using the specified store).
   */
  function setName(IStore _store, ResourceId _tableId, bytes32 id, string memory name) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    _store.setDynamicField(_tableId, _keyTuple, 0, bytes((name)));
  }

  /**
   * @notice Get the length of name.
   */
  function lengthName(ResourceId _tableId, bytes32 id) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get the length of name.
   */
  function _lengthName(ResourceId _tableId, bytes32 id) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get the length of name (using the specified store).
   */
  function lengthName(IStore _store, ResourceId _tableId, bytes32 id) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    uint256 _byteLength = _store.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get an item of name.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemName(ResourceId _tableId, bytes32 id, uint256 _index) internal view returns (string memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 1, (_index + 1) * 1);
      return (string(_blob));
    }
  }

  /**
   * @notice Get an item of name.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItemName(ResourceId _tableId, bytes32 id, uint256 _index) internal view returns (string memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 1, (_index + 1) * 1);
      return (string(_blob));
    }
  }

  /**
   * @notice Get an item of name (using the specified store).
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemName(
    IStore _store,
    ResourceId _tableId,
    bytes32 id,
    uint256 _index
  ) internal view returns (string memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    unchecked {
      bytes memory _blob = _store.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 1, (_index + 1) * 1);
      return (string(_blob));
    }
  }

  /**
   * @notice Push a slice to name.
   */
  function pushName(ResourceId _tableId, bytes32 id, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 0, bytes((_slice)));
  }

  /**
   * @notice Push a slice to name.
   */
  function _pushName(ResourceId _tableId, bytes32 id, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 0, bytes((_slice)));
  }

  /**
   * @notice Push a slice to name (using the specified store).
   */
  function pushName(IStore _store, ResourceId _tableId, bytes32 id, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    _store.pushToDynamicField(_tableId, _keyTuple, 0, bytes((_slice)));
  }

  /**
   * @notice Pop a slice from name.
   */
  function popName(ResourceId _tableId, bytes32 id) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 0, 1);
  }

  /**
   * @notice Pop a slice from name.
   */
  function _popName(ResourceId _tableId, bytes32 id) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 0, 1);
  }

  /**
   * @notice Pop a slice from name (using the specified store).
   */
  function popName(IStore _store, ResourceId _tableId, bytes32 id) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    _store.popFromDynamicField(_tableId, _keyTuple, 0, 1);
  }

  /**
   * @notice Update a slice of name at `_index`.
   */
  function updateName(ResourceId _tableId, bytes32 id, uint256 _index, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update a slice of name at `_index`.
   */
  function _updateName(ResourceId _tableId, bytes32 id, uint256 _index, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update a slice of name (using the specified store) at `_index`.
   */
  function updateName(IStore _store, ResourceId _tableId, bytes32 id, uint256 _index, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    unchecked {
      bytes memory _encoded = bytes((_slice));
      _store.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Get symbol.
   */
  function getSymbol(ResourceId _tableId, bytes32 id) internal view returns (string memory symbol) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 1);
    return (string(_blob));
  }

  /**
   * @notice Get symbol.
   */
  function _getSymbol(ResourceId _tableId, bytes32 id) internal view returns (string memory symbol) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 1);
    return (string(_blob));
  }

  /**
   * @notice Get symbol (using the specified store).
   */
  function getSymbol(IStore _store, ResourceId _tableId, bytes32 id) internal view returns (string memory symbol) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes memory _blob = _store.getDynamicField(_tableId, _keyTuple, 1);
    return (string(_blob));
  }

  /**
   * @notice Set symbol.
   */
  function setSymbol(ResourceId _tableId, bytes32 id, string memory symbol) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 1, bytes((symbol)));
  }

  /**
   * @notice Set symbol.
   */
  function _setSymbol(ResourceId _tableId, bytes32 id, string memory symbol) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreCore.setDynamicField(_tableId, _keyTuple, 1, bytes((symbol)));
  }

  /**
   * @notice Set symbol (using the specified store).
   */
  function setSymbol(IStore _store, ResourceId _tableId, bytes32 id, string memory symbol) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    _store.setDynamicField(_tableId, _keyTuple, 1, bytes((symbol)));
  }

  /**
   * @notice Get the length of symbol.
   */
  function lengthSymbol(ResourceId _tableId, bytes32 id) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 1);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get the length of symbol.
   */
  function _lengthSymbol(ResourceId _tableId, bytes32 id) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 1);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get the length of symbol (using the specified store).
   */
  function lengthSymbol(IStore _store, ResourceId _tableId, bytes32 id) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    uint256 _byteLength = _store.getDynamicFieldLength(_tableId, _keyTuple, 1);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get an item of symbol.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemSymbol(ResourceId _tableId, bytes32 id, uint256 _index) internal view returns (string memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 1, _index * 1, (_index + 1) * 1);
      return (string(_blob));
    }
  }

  /**
   * @notice Get an item of symbol.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItemSymbol(ResourceId _tableId, bytes32 id, uint256 _index) internal view returns (string memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 1, _index * 1, (_index + 1) * 1);
      return (string(_blob));
    }
  }

  /**
   * @notice Get an item of symbol (using the specified store).
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemSymbol(
    IStore _store,
    ResourceId _tableId,
    bytes32 id,
    uint256 _index
  ) internal view returns (string memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    unchecked {
      bytes memory _blob = _store.getDynamicFieldSlice(_tableId, _keyTuple, 1, _index * 1, (_index + 1) * 1);
      return (string(_blob));
    }
  }

  /**
   * @notice Push a slice to symbol.
   */
  function pushSymbol(ResourceId _tableId, bytes32 id, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 1, bytes((_slice)));
  }

  /**
   * @notice Push a slice to symbol.
   */
  function _pushSymbol(ResourceId _tableId, bytes32 id, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 1, bytes((_slice)));
  }

  /**
   * @notice Push a slice to symbol (using the specified store).
   */
  function pushSymbol(IStore _store, ResourceId _tableId, bytes32 id, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    _store.pushToDynamicField(_tableId, _keyTuple, 1, bytes((_slice)));
  }

  /**
   * @notice Pop a slice from symbol.
   */
  function popSymbol(ResourceId _tableId, bytes32 id) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 1, 1);
  }

  /**
   * @notice Pop a slice from symbol.
   */
  function _popSymbol(ResourceId _tableId, bytes32 id) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 1, 1);
  }

  /**
   * @notice Pop a slice from symbol (using the specified store).
   */
  function popSymbol(IStore _store, ResourceId _tableId, bytes32 id) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    _store.popFromDynamicField(_tableId, _keyTuple, 1, 1);
  }

  /**
   * @notice Update a slice of symbol at `_index`.
   */
  function updateSymbol(ResourceId _tableId, bytes32 id, uint256 _index, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 1, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update a slice of symbol at `_index`.
   */
  function _updateSymbol(ResourceId _tableId, bytes32 id, uint256 _index, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 1, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update a slice of symbol (using the specified store) at `_index`.
   */
  function updateSymbol(IStore _store, ResourceId _tableId, bytes32 id, uint256 _index, string memory _slice) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    unchecked {
      bytes memory _encoded = bytes((_slice));
      _store.spliceDynamicData(_tableId, _keyTuple, 1, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Get the full data.
   */
  function get(ResourceId _tableId, bytes32 id) internal view returns (TokenData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

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
  function _get(ResourceId _tableId, bytes32 id) internal view returns (TokenData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    (bytes memory _staticData, EncodedLengths _encodedLengths, bytes memory _dynamicData) = StoreCore.getRecord(
      _tableId,
      _keyTuple,
      _fieldLayout
    );
    return decode(_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Get the full data (using the specified store).
   */
  function get(IStore _store, ResourceId _tableId, bytes32 id) internal view returns (TokenData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    (bytes memory _staticData, EncodedLengths _encodedLengths, bytes memory _dynamicData) = _store.getRecord(
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
    ResourceId _tableId,
    bytes32 id,
    uint8 decimals,
    uint256 totalSupply,
    address owner,
    string memory name,
    string memory symbol
  ) internal {
    bytes memory _staticData = encodeStatic(decimals, totalSupply, owner);

    EncodedLengths _encodedLengths = encodeLengths(name, symbol);
    bytes memory _dynamicData = encodeDynamic(name, symbol);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function _set(
    ResourceId _tableId,
    bytes32 id,
    uint8 decimals,
    uint256 totalSupply,
    address owner,
    string memory name,
    string memory symbol
  ) internal {
    bytes memory _staticData = encodeStatic(decimals, totalSupply, owner);

    EncodedLengths _encodedLengths = encodeLengths(name, symbol);
    bytes memory _dynamicData = encodeDynamic(name, symbol);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Set the full data using individual values (using the specified store).
   */
  function set(
    IStore _store,
    ResourceId _tableId,
    bytes32 id,
    uint8 decimals,
    uint256 totalSupply,
    address owner,
    string memory name,
    string memory symbol
  ) internal {
    bytes memory _staticData = encodeStatic(decimals, totalSupply, owner);

    EncodedLengths _encodedLengths = encodeLengths(name, symbol);
    bytes memory _dynamicData = encodeDynamic(name, symbol);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    _store.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function set(ResourceId _tableId, bytes32 id, TokenData memory _table) internal {
    bytes memory _staticData = encodeStatic(_table.decimals, _table.totalSupply, _table.owner);

    EncodedLengths _encodedLengths = encodeLengths(_table.name, _table.symbol);
    bytes memory _dynamicData = encodeDynamic(_table.name, _table.symbol);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function _set(ResourceId _tableId, bytes32 id, TokenData memory _table) internal {
    bytes memory _staticData = encodeStatic(_table.decimals, _table.totalSupply, _table.owner);

    EncodedLengths _encodedLengths = encodeLengths(_table.name, _table.symbol);
    bytes memory _dynamicData = encodeDynamic(_table.name, _table.symbol);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Set the full data using the data struct (using the specified store).
   */
  function set(IStore _store, ResourceId _tableId, bytes32 id, TokenData memory _table) internal {
    bytes memory _staticData = encodeStatic(_table.decimals, _table.totalSupply, _table.owner);

    EncodedLengths _encodedLengths = encodeLengths(_table.name, _table.symbol);
    bytes memory _dynamicData = encodeDynamic(_table.name, _table.symbol);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    _store.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Decode the tightly packed blob of static data using this table's field layout.
   */
  function decodeStatic(bytes memory _blob) internal pure returns (uint8 decimals, uint256 totalSupply, address owner) {
    decimals = (uint8(Bytes.getBytes1(_blob, 0)));

    totalSupply = (uint256(Bytes.getBytes32(_blob, 1)));

    owner = (address(Bytes.getBytes20(_blob, 33)));
  }

  /**
   * @notice Decode the tightly packed blob of dynamic data using the encoded lengths.
   */
  function decodeDynamic(
    EncodedLengths _encodedLengths,
    bytes memory _blob
  ) internal pure returns (string memory name, string memory symbol) {
    uint256 _start;
    uint256 _end;
    unchecked {
      _end = _encodedLengths.atIndex(0);
    }
    name = (string(SliceLib.getSubslice(_blob, _start, _end).toBytes()));

    _start = _end;
    unchecked {
      _end += _encodedLengths.atIndex(1);
    }
    symbol = (string(SliceLib.getSubslice(_blob, _start, _end).toBytes()));
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
  ) internal pure returns (TokenData memory _table) {
    (_table.decimals, _table.totalSupply, _table.owner) = decodeStatic(_staticData);

    (_table.name, _table.symbol) = decodeDynamic(_encodedLengths, _dynamicData);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(ResourceId _tableId, bytes32 id) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(ResourceId _tableId, bytes32 id) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Delete all data for given keys (using the specified store).
   */
  function deleteRecord(IStore _store, ResourceId _tableId, bytes32 id) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    _store.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Tightly pack static (fixed length) data using this table's schema.
   * @return The static data, encoded into a sequence of bytes.
   */
  function encodeStatic(uint8 decimals, uint256 totalSupply, address owner) internal pure returns (bytes memory) {
    return abi.encodePacked(decimals, totalSupply, owner);
  }

  /**
   * @notice Tightly pack dynamic data lengths using this table's schema.
   * @return _encodedLengths The lengths of the dynamic fields (packed into a single bytes32 value).
   */
  function encodeLengths(
    string memory name,
    string memory symbol
  ) internal pure returns (EncodedLengths _encodedLengths) {
    // Lengths are effectively checked during copy by 2**40 bytes exceeding gas limits
    unchecked {
      _encodedLengths = EncodedLengthsLib.pack(bytes(name).length, bytes(symbol).length);
    }
  }

  /**
   * @notice Tightly pack dynamic (variable length) data using this table's schema.
   * @return The dynamic data, encoded into a sequence of bytes.
   */
  function encodeDynamic(string memory name, string memory symbol) internal pure returns (bytes memory) {
    return abi.encodePacked(bytes((name)), bytes((symbol)));
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dynamic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(
    uint8 decimals,
    uint256 totalSupply,
    address owner,
    string memory name,
    string memory symbol
  ) internal pure returns (bytes memory, EncodedLengths, bytes memory) {
    bytes memory _staticData = encodeStatic(decimals, totalSupply, owner);

    EncodedLengths _encodedLengths = encodeLengths(name, symbol);
    bytes memory _dynamicData = encodeDynamic(name, symbol);

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(bytes32 id) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    return _keyTuple;
  }
}