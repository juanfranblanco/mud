import { MutableState, Store, StoreConfig, StoreSubscribers, TableSubscribers } from "./common";
import { DefaultActions, defaultActions } from "./decorators/default";
import { extend } from "./actions/extend";

export type Config = StoreConfig;

export type CreateStoreResult<config extends Config = Config> = Store<config> & DefaultActions<config>;

/**
 * Initializes a Zustand store based on the provided table configs.
 */
export function createStore<config extends Config>(storeConfig?: config): CreateStoreResult<config> {
  const tableSubscribers: TableSubscribers = {};
  const storeSubscribers: StoreSubscribers = new Set();

  const state: MutableState = {
    config: {},
    records: {},
  };

  // Initialize the store
  if (storeConfig) {
    for (const [namespace, { tables }] of Object.entries(storeConfig.namespaces)) {
      for (const [table, tableConfig] of Object.entries(tables)) {
        // TODO: add option to resolveTables to not add codegen/deploy?
        // eslint-disable-next-line @typescript-eslint/no-unused-vars
        const { codegen, deploy, ...relevantConfig } = tableConfig;

        // Set config for tables
        state.config[namespace] ??= {};
        state.config[namespace][table] = relevantConfig;

        // Init records map for tables
        state.records[namespace] ??= {};
        state.records[namespace][table] = {};

        // Init subscribers set for tables
        tableSubscribers[namespace] ??= {};
        tableSubscribers[namespace][table] ??= new Set();
      }
    }
  }

  const store = {
    get: () => state,
    _: {
      state,
      tableSubscribers,
      storeSubscribers,
    },
  } satisfies Store;

  return extend({ store, actions: defaultActions(store) });
}
