import { RecsV1TableOptions } from "./types";

export function renderRecsV1Tables(options: RecsV1TableOptions) {
  const { tables } = options;

  return `/* Autogenerated file. Do not edit manually. */

import { TableId } from "@latticexyz/common";
import { defineComponent, Type as RecsType, World } from "@latticexyz/recs";

export function defineContractComponents(world: World) {
  return {
    ${tables.map((table) => `${table.tableName}: ${renderDefineComponent(table)},`).join("")}
  }
}
`;
}

function renderDefineComponent(table: RecsV1TableOptions["tables"][number]) {
  const { namespace, name } = table.staticResourceData;
  return `
    (() => {
      const tableId = new TableId("${namespace}", "${name}");
      return defineComponent(world, {
        ${table.fields.map(({ name, recsTypeString }) => `${name}: ${recsTypeString},`).join("")}
      }, {
        metadata: { contractId: tableId.toHex(), tableId: tableId.toString() },
      });
    })()
  `;
}
