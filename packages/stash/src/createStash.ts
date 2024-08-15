import { MutableState, Stash, StoreConfig, StoreSubscribers, TableSubscribers } from "./common";
import { DefaultActions, defaultActions } from "./decorators/default";
import { extend } from "./actions/extend";
import { Table } from "@latticexyz/store/config/v2";

export type Config = StoreConfig;

export type CreateStoreResult<config extends Config = Config> = Stash<config> & DefaultActions<config>;

/**
 * Initializes a Zustand stash based on the provided table configs.
 */
export function createStash<config extends Config>(storeConfig?: config): CreateStoreResult<config> {
  const tableSubscribers: TableSubscribers = {};
  const storeSubscribers: StoreSubscribers = new Set();

  const state: MutableState = {
    config: {},
    records: {},
  };

  // Initialize the stash
  if (storeConfig) {
    for (const [namespace, { tables }] of Object.entries(storeConfig.namespaces)) {
      for (const [table, fullTableConfig] of Object.entries(tables)) {
        // Remove unused artifacts from the stash config
        // eslint-disable-next-line @typescript-eslint/no-unused-vars
        const { deploy, codegen, ...tableConfig } = { ...(fullTableConfig as Table) };

        // Set config for tables
        state.config[namespace] ??= {};
        state.config[namespace][table] = tableConfig;

        // Init records map for tables
        state.records[namespace] ??= {};
        state.records[namespace][table] = {};

        // Init subscribers set for tables
        tableSubscribers[namespace] ??= {};
        tableSubscribers[namespace][table] ??= new Set();
      }
    }
  }

  const stash = {
    get: () => state,
    _: {
      state,
      tableSubscribers,
      storeSubscribers,
    },
  } satisfies Stash;

  return extend({ stash, actions: defaultActions(stash) }) as never;
}
