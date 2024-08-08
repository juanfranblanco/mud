import { Table } from "@latticexyz/config";
import { Keys, Store } from "./common";
import { TableRecord } from "./common";
import { recordMatches } from "./recordEquals";
import { getRecords } from "./actions/getRecords";
import { getKeys } from "./actions/getKeys";

// TODO: add more query fragments - ie GreaterThan, LessThan, Range, etc

export type QueryFragment = {
  table: Table;
  /**
   * Checking an individual table row for whether it matches the query fragment
   */
  match: (store: Store, encodedKey: string) => boolean;
  /**
   * The keys that should be included in the query result if this is the first fragment in the query.
   * This is to avoid having to iterate over each key in the first table if there is a more efficient
   * way to get to the initial result.
   */
  getInitialKeys: (store: Store) => Keys;
};

/**
 * Matches all records that exist in the table.
 * RECS equivalent: Has(Component)
 */
export function In(table: Table): QueryFragment {
  const match = (store: Store, encodedKey: string) => encodedKey in getRecords({ store, table });
  const getInitialKeys = (store: Store) => getKeys({ store, table });
  return { table, match, getInitialKeys };
}

/**
 * Matches all records that don't exist in the table.
 * RECS equivalent: Not(Component)
 */
export function NotIn(table: Table): QueryFragment {
  const match = (store: Store, encodedKey: string) => !(encodedKey in getRecords({ store, table }));
  const getInitialKeys = () => ({});
  return { table, match, getInitialKeys };
}

/**
 * Matches all records that match the provided partial record.
 * This works for both value and key, since both are part of the record.
 * RECS equivalent (only for value match): HasValue(Component, value)
 */
export function MatchRecord(table: Table, partialRecord: TableRecord): QueryFragment {
  const match = (store: Store, encodedKey: string) => {
    const record = getRecords({ store, table })[encodedKey];
    return recordMatches(partialRecord, record);
  };
  // TODO: this is a very naive and inefficient implementation for large tables, can be optimized via indexer tables
  const getInitialKeys = (store: Store) =>
    Object.fromEntries(Object.entries(getKeys({ store, table })).filter(([key]) => match(store, key)));
  return { table, match, getInitialKeys };
}

/**
 * Matches all records that don't match the provided partial record.
 * This works for both value and key, since both are part of the record.
 * RECS equivalent (only for value match): NotValue(Component, value)
 * @param table
 * @param partialRecord
 */
export function NotMatchRecord(table: Table, partialRecord: TableRecord): QueryFragment {
  const match = (store: Store, encodedKey: string) => {
    const record = getRecords({ store, table })[encodedKey];
    return !recordMatches(partialRecord, record);
  };
  // TODO: this is a very naive and inefficient implementation for large tables, can be optimized via indexer tables
  const getInitialKeys = (store: Store) =>
    Object.fromEntries(Object.entries(getKeys({ store, table })).filter(([key]) => match(store, key)));
  return { table, match, getInitialKeys };
}
