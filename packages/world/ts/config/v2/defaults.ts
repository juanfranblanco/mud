import { CodegenInput, DeployInput, ModuleInput, SystemDeployInput, SystemInput, WorldInput } from "./input";

export const SYSTEM_DEPLOY_DEFAULTS = {
  disabled: false,
  registerFunctionSelectors: true,
  openAccess: true,
  accessList: [],
} as const satisfies SystemDeployInput;

export type SYSTEM_DEPLOY_DEFAULTS = typeof SYSTEM_DEPLOY_DEFAULTS;

export const SYSTEM_DEFAULTS = {
  deploy: SYSTEM_DEPLOY_DEFAULTS,
} as const satisfies Pick<SystemInput, "deploy">;

export type SYSTEM_DEFAULTS = typeof SYSTEM_DEFAULTS;

export const MODULE_DEFAULTS = {
  root: false,
  args: [],
  artifactPath: undefined,
} as const satisfies Pick<ModuleInput, "root" | "args" | "artifactPath">;

export type MODULE_DEFAULTS = typeof MODULE_DEFAULTS;

export const CODEGEN_DEFAULTS = {
  worldInterfaceName: "IWorld",
  worldgenDirectory: "world",
  worldImportPath: "@latticexyz/world/src/",
} as const satisfies CodegenInput;

export type CODEGEN_DEFAULTS = typeof CODEGEN_DEFAULTS;

export const DEPLOY_DEFAULTS = {
  customWorldContract: undefined,
  postDeployScript: "PostDeploy",
  deploysDirectory: "./deploys",
  worldsFile: "./worlds.json",
  upgradeableWorldImplementation: false,
} as const satisfies DeployInput;

export type DEPLOY_DEFAULTS = typeof DEPLOY_DEFAULTS;

export const CONFIG_DEFAULTS = {
  systems: {},
  tables: {},
  excludeSystems: [],
  modules: [],
  codegen: CODEGEN_DEFAULTS,
  deploy: DEPLOY_DEFAULTS,
} as const satisfies WorldInput;

export type CONFIG_DEFAULTS = typeof CONFIG_DEFAULTS;
