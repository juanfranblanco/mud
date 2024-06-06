import { conform } from "@arktype/util";
import { World, Systems } from "./output";
import { Store } from "@latticexyz/store";
import { storeToV1 } from "@latticexyz/store/config/v2";

type systemsToV1<systems extends Systems> = {
  [key in keyof systems]: {
    name?: systems[key]["name"];
    registerFunctionSelectors: systems[key]["registerFunctionSelectors"];
  } & ({ openAccess: true } | { openAccess: false; accessList: systems[key]["accessList"] });
};

function systemsToV1<systems extends Systems>(systems: systems): systemsToV1<systems> {
  return systems;
}

export type worldToV1<world> = world extends World
  ? Omit<storeToV1<world>, "v2"> & {
      systems: systemsToV1<world["systems"]>;
      excludeSystems: world["excludeSystems"];
      worldContractName: world["deploy"]["customWorldContract"];
      postDeployScript: world["deploy"]["postDeployScript"];
      deploysDirectory: world["deploy"]["deploysDirectory"];
      worldsFile: world["deploy"]["worldsFile"];
      worldInterfaceName: world["codegen"]["worldInterfaceName"];
      worldgenDirectory: world["codegen"]["worldgenDirectory"];
      worldImportPath: world["codegen"]["worldImportPath"];
      v2: world;
    }
  : never;

export function worldToV1<world>(world: conform<world, World>): worldToV1<world> {
  const v1WorldConfig = {
    systems: systemsToV1(world.systems),
    excludeSystems: world.excludeSystems,
    worldContractName: world.deploy.customWorldContract,
    postDeployScript: world.deploy.postDeployScript,
    deploysDirectory: world.deploy.deploysDirectory,
    worldsFile: world.deploy.worldsFile,
    worldInterfaceName: world.codegen.worldInterfaceName,
    worldgenDirectory: world.codegen.worldgenDirectory,
    worldImportPath: world.codegen.worldImportPath,
  };

  return { ...storeToV1(world as Store), ...v1WorldConfig, v2: world } as never;
}
