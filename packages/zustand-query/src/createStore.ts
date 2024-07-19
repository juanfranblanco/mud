import { AbiType } from "@latticexyz/config";
import { createStore as createZustandStore } from "zustand/vanilla";
import { StoreApi } from "zustand";
import { mutative } from "zustand-mutative";
import { dynamicAbiTypeToDefaultValue, staticAbiTypeToDefaultValue } from "@latticexyz/schema-type/internal";

/**
 * A TableRecord is one row of the table. It includes both the key and the value.
 */
export type TableRecord = { readonly [field: string]: number | string | bigint | number[] | string[] | bigint[] };

type TableRecords = { readonly [key: string]: TableRecord };

/**
 * A Key is the unique identifier for a row in the table.
 */
export type Key = { [field: string]: number | string | bigint };

/**
 * A map from encoded key to decoded key
 */
export type Keys = { [encodedKey: string]: Key };

type Schema = { [key: string]: AbiType };

// TODO: reuse the store config table input for this
type TableConfigInput = {
  key: string[];
  schema: Schema;
};

type TableConfigFull = {
  key: string[];
  schema: Schema;
  label: string;
  namespace: string;
};

export type TablesConfig = {
  [namespace: string]: {
    [tableLabel: string]: TableConfigInput;
  };
};

type TableUpdate = { prev: TableRecord | undefined; current: TableRecord | undefined };
type TableUpdates = { [key: string]: TableUpdate };

type Unsubscribe = () => void;
type TableUpdatesListener = (updates: TableUpdates) => void;

type State = {
  config: {
    [namespace: string]: {
      [table: string]: TableConfigFull;
    };
  };
  records: {
    [namespace: string]: {
      [table: string]: TableRecords;
    };
  };
};

type SetRecordArgs = {
  tableLabel: TableLabel;
  key: Key;
  record: TableRecord;
};

type GetRecordArgs = {
  tableLabel: TableLabel;
  key: Key;
};

type SubscribeArgs = {
  tableLabel: TableLabel;
  listener: TableUpdatesListener;
};

type Actions = {
  actions: {
    /**
     * Set a record in a table. If a partial record is provided, existing fields stay unchanged
     * and non-existing fields are initialized with the default value for this field.
     * Key fields of the record are always set to the provided key.
     */
    setRecord: (args: SetRecordArgs) => void;
    /**
     * Get a record from a table.
     */
    getRecord: (args: GetRecordArgs) => TableRecord;
    /**
     * Dynamically register a new table in the store
     * @returns A bound Table object for easier interaction with the table.
     */
    registerTable: (config: TableConfigFull) => BoundTable;
    /**
     * @returns A bound Table object for easier interaction with the table.
     */
    getTable: (tableLabel: TableLabel) => BoundTable;
    /**
     * Add a listener for record updates on a table.
     * @returns A function to unsubscribe the listener.
     */
    subscribe: (args: SubscribeArgs) => Unsubscribe;
    // TODO: add setRecords (batch), getRecords, getKeys, getConfig, find (get records with filter on key or value)
  };
};

export type Store = StoreApi<State & Actions>;

type BoundSetRecordArgs = {
  key: Key;
  record: TableRecord;
};

type BoundGetRecordArgs = {
  key: Key;
};

type BoundSubscribeArgs = {
  listener: TableUpdatesListener;
};

export type BoundTable = {
  getRecord: (args: BoundGetRecordArgs) => TableRecord;
  setRecord: (args: BoundSetRecordArgs) => void;
  getRecords: () => TableRecords;
  getKeys: () => Keys;
  getConfig: () => TableConfigFull;
  subscribe: (args: BoundSubscribeArgs) => Unsubscribe;
};

type TableLabel = { label: string; namespace?: string };

type Subscribers = {
  [namespace: string]: {
    [table: string]: Set<TableUpdatesListener>;
  };
};

/**
 * Initializes a Zustand store based on the provided table configs.
 */
export function createStore(tablesConfig: TablesConfig): Store {
  const subscribers: Subscribers = {};

  return createZustandStore<State & Actions>()(
    mutative((set, get) => {
      const state: State = { config: {}, records: {} };

      for (const [namespace, tables] of Object.entries(tablesConfig)) {
        for (const [label, tableConfig] of Object.entries(tables)) {
          // Set config for tables
          state.config[namespace] ??= {};
          state.config[namespace][label] = { ...tableConfig, namespace, label };

          // Init records map for tables
          state.records[namespace] ??= {};
          state.records[namespace][label] = {};

          // Init subscribers set for tables
          subscribers[namespace] ??= {};
          subscribers[namespace][label] ??= new Set();
        }
      }

      /**
       * Encode a key object into a string that can be used as index in the store
       * TODO: Benchmark performance of this function
       */
      function encodeKey({ label, namespace }: TableLabel, key: Key): string {
        const keyOrder = get().config[namespace ?? ""][label].key;
        return keyOrder
          .map((keyName) => {
            const keyValue = key[keyName];
            if (keyValue == null) {
              throw new Error(`Provided key is missing field ${keyName}.`);
            }
            return key[keyName];
          })
          .join("|");
      }

      const getRecord = ({ tableLabel, key }: GetRecordArgs) => {
        return get().records[tableLabel.namespace ?? ""][tableLabel.label][encodeKey(tableLabel, key)];
      };

      // TODO: Benchmark performance of this function.
      const setRecord = ({ tableLabel, key, record }: SetRecordArgs) => {
        set((prev) => {
          const namespace = tableLabel.namespace ?? "";
          const label = tableLabel.label;

          if (prev.config[namespace] == null) {
            throw new Error(`Table '${namespace}__${label}' is not registered yet.`);
          }

          // Update record
          const encodedKey = encodeKey(tableLabel, key);
          const prevRecord = prev.records[namespace][label][encodedKey];
          const schema = prev.config[namespace][label].schema;
          const newRecord = Object.fromEntries(
            Object.keys(schema).map((fieldName) => [
              fieldName,
              key[fieldName] ?? // Key fields in record must match the key
                record[fieldName] ?? // Override provided record fields
                prevRecord?.[fieldName] ?? // Keep existing non-overridden fields
                staticAbiTypeToDefaultValue[schema[fieldName] as never] ?? // Default values for new fields
                dynamicAbiTypeToDefaultValue[schema[fieldName] as never],
            ]),
          );
          prev.records[tableLabel.namespace ?? ""][tableLabel.label][encodedKey] = newRecord;

          // Notify table subscribers
          subscribers[namespace][label].forEach((listener) =>
            listener({ [encodedKey]: { prev: prevRecord && { ...prevRecord }, current: newRecord } }),
          );
        });
      };

      const subscribe = ({ tableLabel, listener }: SubscribeArgs): Unsubscribe => {
        const namespace = tableLabel.namespace ?? "";
        const label = tableLabel.label;

        subscribers[namespace][label].add(listener);
        return () => subscribers[namespace][label].delete(listener);
      };

      const getTable = (tableLabel: TableLabel): BoundTable => {
        const namespace = tableLabel.namespace ?? "";
        const label = tableLabel.label;

        return {
          setRecord: ({ key, record }: BoundSetRecordArgs) => setRecord({ tableLabel, key, record }),
          getRecord: ({ key }: BoundGetRecordArgs) => getRecord({ tableLabel, key }),
          getRecords: () => get().records[namespace][label],
          getKeys: () => {
            const records = get().records[namespace][label];
            const keyFields = get().config[namespace][label].key;
            return Object.fromEntries(
              Object.entries(records).map(([key, record]) => [
                key,
                Object.fromEntries(Object.entries(record).filter(([field]) => keyFields.includes(field))),
                // Typecast needed because record values could be arrays, but we know they are not if they are key fields
              ]) as never,
            );
          },
          getConfig: () => get().config[namespace][label],
          subscribe: ({ listener }: BoundSubscribeArgs) => subscribe({ tableLabel, listener }),

          // TODO: dynamically add setters and getters for individual fields of the table
        };
      };

      const registerTable = (tableConfig: TableConfigFull): BoundTable => {
        set((prev) => {
          const { namespace, label } = tableConfig;
          // Set config for table
          prev.config[namespace] ??= {};
          prev.config[namespace][label] = tableConfig;

          // Init records map for table
          prev.records[namespace] ??= {};
          prev.records[namespace][label] ??= {};

          // Init subscribers set for table
          subscribers[namespace] ??= {};
          subscribers[namespace][label] ??= new Set();
        });
        return getTable(tableConfig);
      };

      return { ...state, actions: { setRecord, getRecord, getTable, registerTable, subscribe } };
    }),
  );
}
