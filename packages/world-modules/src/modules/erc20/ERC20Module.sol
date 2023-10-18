// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { ResourceIds } from "@latticexyz/store/src/codegen/tables/ResourceIds.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";
import { Module } from "@latticexyz/world/src/Module.sol";
import { WorldResourceIdLib } from "@latticexyz/world/src/WorldResourceId.sol";
import { IBaseWorld } from "@latticexyz/world/src/codegen/interfaces/IBaseWorld.sol";
import { InstalledModules } from "@latticexyz/world/src/codegen/tables/InstalledModules.sol";

import { Puppet } from "../puppet/Puppet.sol";
import { registerPuppet } from "../puppet/registerPuppet.sol";
import { MODULE_NAME as PUPPET_MODULE_NAME } from "../puppet/constants.sol";
import { PuppetModule } from "../puppet/PuppetModule.sol";

import { MODULE_NAME, MODULE_NAMESPACE, MODULE_NAMESPACE_ID, ERC20_REGISTRY_TABLE_ID } from "./constants.sol";
import { _allowancesTableId, _balancesTableId, _metadataTableId, _erc20SystemId } from "./utils.sol";
import { ERC20System } from "./ERC20System.sol";

import { ERC20Registry } from "./tables/ERC20Registry.sol";
import { Balances } from "./tables/Balances.sol";
import { Allowances } from "./tables/Allowances.sol";
import { Metadata, MetadataData } from "./tables/Metadata.sol";

contract ERC20Module is Module {
  error ERC20Module_InvalidNamespace(bytes14 namespace);

  function getName() public pure override returns (bytes16) {
    return MODULE_NAME;
  }

  /**
   * Register systems and tables for a new ERC20 token in a given namespace
   */
  function _registerERC20(bytes14 namespace) internal {
    // Register the tables
    Allowances.register(_allowancesTableId(namespace));
    Balances.register(_balancesTableId(namespace));
    Metadata.register(_metadataTableId(namespace));

    // Register a new ERC20System
    IBaseWorld(_world()).registerSystem(_erc20SystemId(namespace), new ERC20System(), true);
  }

  function _installDependencies() internal {
    // If the PuppetModule is not installed yet, install it
    if (InstalledModules.get(PUPPET_MODULE_NAME, keccak256(new bytes(0))) == address(0)) {
      IBaseWorld(_world()).installModule(new PuppetModule(), new bytes(0));
    }
  }

  function install(bytes memory args) public {
    // Require the module to not be installed with these args yet
    if (InstalledModules.get(MODULE_NAME, keccak256(args)) != address(0)) {
      revert Module_AlreadyInstalled();
    }

    // Extract args
    (bytes14 namespace, MetadataData memory metadata) = abi.decode(args, (bytes14, MetadataData));

    // Require the namespace to not be the module's namespace
    if (namespace == MODULE_NAMESPACE) {
      revert ERC20Module_InvalidNamespace(namespace);
    }

    // Install dependencies
    _installDependencies();

    // Register the ERC20 tables and system
    _registerERC20(namespace);

    // Initialize the Metadata
    Metadata.set(_metadataTableId(namespace), metadata);

    // Deploy and register the ERC20 puppet.
    IBaseWorld world = IBaseWorld(_world());
    ResourceId erc20SystemId = _erc20SystemId(namespace);
    Puppet puppet = new Puppet(world, erc20SystemId);
    registerPuppet(world, erc20SystemId, address(puppet));

    // Transfer ownership of the namespace to the caller
    ResourceId namespaceId = WorldResourceIdLib.encodeNamespace(namespace);
    world.transferOwnership(namespaceId, _msgSender());

    // Register the ERC20 in the ERC20Registry
    if (!ResourceIds.getExists(ERC20_REGISTRY_TABLE_ID)) {
      ERC20Registry.register(ERC20_REGISTRY_TABLE_ID);
    }
    ERC20Registry.set(ERC20_REGISTRY_TABLE_ID, namespaceId, address(puppet));
  }

  function installRoot(bytes memory) public pure {
    revert Module_RootInstallNotSupported();
  }
}
