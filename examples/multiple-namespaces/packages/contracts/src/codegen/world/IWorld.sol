// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

import { IBaseWorld } from "@latticexyz/world/src/codegen/interfaces/IBaseWorld.sol";

import { game__IHealSystem } from "./game__IHealSystem.sol";
import { game__IMoveSystem } from "./game__IMoveSystem.sol";
import { game__IScoreSystem } from "./game__IScoreSystem.sol";
import { somePlugin__IScoreSystem } from "./somePlugin__IScoreSystem.sol";

/**
 * @title IWorld
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice This interface integrates all systems and associated function selectors
 * that are dynamically registered in the World during deployment.
 * @dev This is an autogenerated file; do not edit manually.
 */
interface IWorld is IBaseWorld, game__IHealSystem, game__IMoveSystem, game__IScoreSystem, somePlugin__IScoreSystem {}
