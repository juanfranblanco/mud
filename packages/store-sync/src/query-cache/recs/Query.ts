import { ZustandStore } from "../../zustand";
import { AllTables, QueryCondition, QueryResultSubject, TableSubject } from "../common";
import { SchemaToPrimitives, StoreConfig, Table, Tables } from "@latticexyz/store";
import { query } from "../query";
import { QueryResultSubjectChange, subscribeToQuery } from "../subscribeToQuery";
import { Observable, filter, map } from "rxjs";
import { encodeEntity } from "../../recs";
import { KeySchema, SchemaToPrimitives as SchemaToPrimitivesProtocol } from "@latticexyz/protocol-parser";
import { Entity, QueryFragmentType, UpdateType } from "@latticexyz/recs";

type HasQueryFragment<T extends Table> = {
  type: QueryFragmentType.Has;
  table: T;
};

type NotQueryFragment<T extends Table> = {
  type: QueryFragmentType.Not;
  table: T;
};

type HasValueQueryFragment<T extends Table> = {
  type: QueryFragmentType.HasValue;
  table: T;
  value: SchemaToPrimitives<T["valueSchema"]>;
};

type NotValueQueryFragment<T extends Table> = {
  type: QueryFragmentType.NotValue;
  table: T;
  value: SchemaToPrimitives<T["valueSchema"]>;
};

export function Has<T extends Table>(table: T): HasQueryFragment<T> {
  return { type: QueryFragmentType.Has, table };
}

export function Not<T extends Table>(table: T): NotQueryFragment<T> {
  return { type: QueryFragmentType.Not, table };
}

export function HasValue<T extends Table>(
  table: T,
  value: SchemaToPrimitives<T["valueSchema"]>,
): HasValueQueryFragment<T> {
  return { type: QueryFragmentType.HasValue, table, value };
}

export function NotValue<T extends Table>(
  table: T,
  value: SchemaToPrimitives<T["valueSchema"]>,
): NotValueQueryFragment<T> {
  return { type: QueryFragmentType.NotValue, table, value };
}

export type QueryFragment<T extends Table> =
  | HasQueryFragment<T>
  | NotQueryFragment<T>
  | HasValueQueryFragment<T>
  | NotValueQueryFragment<T>;

function fragmentToTableSubject(fragment: QueryFragment<Table>): TableSubject {
  return {
    tableId: fragment.table.tableId,
    subject: Object.keys(fragment.table.keySchema),
  };
}

function fragmentToQueryConditions(fragment: QueryFragment<Table>): QueryCondition[] {
  return Object.entries((fragment as HasValueQueryFragment<Table> | NotValueQueryFragment<Table>).value).map(
    ([field, right]) => {
      if (fragment.type === QueryFragmentType.HasValue) {
        return {
          left: { tableId: fragment.table.tableId, field },
          op: "=",
          right,
        };
      } else {
        return {
          left: { tableId: fragment.table.tableId, field },
          op: "!=",
          right,
        };
      }
    },
  ) as QueryCondition[];
}

function fragmentsToFrom(fragments: QueryFragment<Table>[]): TableSubject[] {
  return fragments
    .filter(
      (fragment) =>
        fragment.type === QueryFragmentType.Has ||
        fragment.type === QueryFragmentType.HasValue ||
        fragment.type === QueryFragmentType.NotValue,
    )
    .map(fragmentToTableSubject);
}

function fragmentsToExcept(fragments: QueryFragment<Table>[]): TableSubject[] {
  return fragments.filter((fragment) => fragment.type === QueryFragmentType.Not).map(fragmentToTableSubject);
}

function fragmentsToWhere(fragments: QueryFragment<Table>[]): QueryCondition[] {
  return fragments
    .filter((fragment) => fragment.type === QueryFragmentType.HasValue || fragment.type === QueryFragmentType.NotValue)
    .map(fragmentToQueryConditions)
    .flat();
}

function fragmentToKeySchema(fragment: QueryFragment<Table>): KeySchema {
  const keySchema: KeySchema = {};
  Object.entries(fragment.table.keySchema).map(([keyName, value]) => (keySchema[keyName] = value.type));

  return keySchema;
}

function subjectToEntity(fragment: QueryFragment<Table>, subject: QueryResultSubject): Entity {
  const keySchema = fragmentToKeySchema(fragment);

  const key: SchemaToPrimitivesProtocol<KeySchema> = {};
  // @ts-expect-error Type 'string' is not assignable to type 'number | bigint | boolean | `0x${string}`'
  Object.keys(fragment.table.keySchema).map((keyName, i) => (key[keyName] = subject[i]));
  return encodeEntity(keySchema, key);
}

function subjectsToEntities(fragment: QueryFragment<Table>, subjects: readonly QueryResultSubject[]): Entity[] {
  const entities = subjects.map((subject) => {
    return subjectToEntity(fragment, subject);
  });

  return entities;
}

export async function runQuery<config extends StoreConfig, extraTables extends Tables | undefined = undefined>(
  store: ZustandStore<AllTables<config, extraTables>>,
  fragments: QueryFragment<Table>[],
): Promise<Set<Entity>> {
  const from = fragmentsToFrom(fragments);
  const except = fragmentsToExcept(fragments);
  const where = fragmentsToWhere(fragments);

  const result = await query(store, {
    from,
    except,
    where,
  });

  const entities = subjectsToEntities(fragments[0], result);

  return new Set(entities);
}

export type ComponentUpdate = {
  entity: Entity;
};

function subjectChangesToUpdate(
  fragment: QueryFragment<Table>,
  subjectChanges: readonly QueryResultSubjectChange[],
): ComponentUpdate & { type: UpdateType } {
  const subjectChange = subjectChanges[0];

  return {
    type: subjectChange.type === "enter" ? UpdateType.Enter : UpdateType.Exit,
    entity: subjectToEntity(fragment, subjectChange.subject),
  };
}

export async function defineQuery<config extends StoreConfig, extraTables extends Tables | undefined = undefined>(
  store: ZustandStore<AllTables<config, extraTables>>,
  fragments: QueryFragment<Table>[],
): Promise<{
  update$: Observable<ComponentUpdate & { type: UpdateType }>;
  matching: Observable<Entity[]>;
}> {
  const from = fragmentsToFrom(fragments);
  const except = fragmentsToExcept(fragments);
  const where = fragmentsToWhere(fragments);

  const { subjects$, subjectChanges$ } = await subscribeToQuery(store, {
    from,
    except,
    where,
  });

  return {
    update$: subjectChanges$.pipe(
      filter((subjectChanges) => subjectChanges.length > 0),
      map((subjectChanges) => subjectChangesToUpdate(fragments[0], subjectChanges)),
    ),
    matching: subjects$.pipe(map((subjects) => subjectsToEntities(fragments[0], subjects))),
  };
}

export async function defineUpdateQuery<config extends StoreConfig, extraTables extends Tables | undefined = undefined>(
  store: ZustandStore<AllTables<config, extraTables>>,
  fragments: QueryFragment<Table>[],
): Promise<Observable<ComponentUpdate & { type: UpdateType }>> {
  const { update$ } = await defineQuery(store, fragments);
  return update$.pipe(filter((update) => update.type === UpdateType.Update));
}

export async function defineEnterQuery<config extends StoreConfig, extraTables extends Tables | undefined = undefined>(
  store: ZustandStore<AllTables<config, extraTables>>,
  fragments: QueryFragment<Table>[],
): Promise<Observable<ComponentUpdate & { type: UpdateType }>> {
  const { update$ } = await defineQuery(store, fragments);
  return update$.pipe(filter((e) => e.type === UpdateType.Enter));
}

export async function defineExitQuery<config extends StoreConfig, extraTables extends Tables | undefined = undefined>(
  store: ZustandStore<AllTables<config, extraTables>>,
  fragments: QueryFragment<Table>[],
): Promise<Observable<ComponentUpdate & { type: UpdateType }>> {
  const { update$ } = await defineQuery(store, fragments);
  return update$.pipe(filter((e) => e.type === UpdateType.Exit));
}
