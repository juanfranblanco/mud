// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

import { SystemCallData, SystemCallFromData } from "../../modules/init/types.sol";

/**
 * @title IBatchCallSystem
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface IBatchCallSystem {
  function batchCall(SystemCallData[] calldata systemCalls) external returns (bytes[] memory returnDatas);

  function batchCallFrom(SystemCallFromData[] calldata systemCalls) external returns (bytes[] memory returnDatas);
}
