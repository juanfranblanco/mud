import { Component, Type, World, defineComponent } from "@latticexyz/recs";
import { StoreComponentMetadata } from "./common";
import { SchemaAbiTypeToRecsType, schemaAbiTypeToRecsType } from "./schemaAbiTypeToRecsType";
import { Table } from "@latticexyz/config";
import { mapObject } from "@latticexyz/common/utils";
import { ResourceLabel, resourceToLabel } from "@latticexyz/common";
import { getKeySchema, getSchemaTypes, getValueSchema } from "@latticexyz/protocol-parser/internal";

export type TableToComponent<table extends Table> = Component<
  {
    __staticData: Type.OptionalString;
    __encodedLengths: Type.OptionalString;
    __dynamicData: Type.OptionalString;
  } & {
    [fieldName in keyof getValueSchema<table>]: Type & SchemaAbiTypeToRecsType<table["schema"][fieldName]["type"]>;
  },
  StoreComponentMetadata & {
    componentName: table["name"];
    tableName: ResourceLabel;
    keySchema: getSchemaTypes<getKeySchema<table>>;
    valueSchema: getSchemaTypes<getValueSchema<table>>;
  }
>;

export function tableToComponent<table extends Table>(world: World, table: table): TableToComponent<table> {
  const keySchema = getSchemaTypes(getKeySchema(table));
  const valueSchema = getSchemaTypes(getValueSchema(table));
  return defineComponent(
    world,
    {
      ...mapObject(valueSchema, (type) => schemaAbiTypeToRecsType[type]),
      __staticData: Type.OptionalString,
      __encodedLengths: Type.OptionalString,
      __dynamicData: Type.OptionalString,
    },
    {
      id: table.tableId,
      metadata: {
        componentName: table.name,
        tableName: resourceToLabel(table),
        keySchema,
        valueSchema,
      },
    },
  ) as TableToComponent<table>;
}
