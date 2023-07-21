/* Autogenerated file. Do not edit manually. */

import { defineComponent, Type as RecsType, World } from "@latticexyz/recs";

export function defineContractComponents(world: World) {
  return {
    CounterTable: (() => {
      const keySchema = { key: "bytes32" } as const;
      const valueSchema = { value: "uint32" } as const;
      return defineComponent(
        world,
        {
          value: RecsType.Number,
        },
        {
          id: "0x00000000000000000000000000000000436f756e7465725461626c6500000000",
          metadata: {
            tableName: ":CounterTable",
            keySchema,
            valueSchema,
          },
        }
      );
    })(),
    MessageTable: (() => {
      const keySchema = {} as const;
      const valueSchema = { value: "string" } as const;
      return defineComponent(
        world,
        {
          value: RecsType.String,
        },
        {
          id: "0x000000000000000000000000000000004d6573736167655461626c6500000000",
          metadata: {
            tableName: ":MessageTable",
            keySchema,
            valueSchema,
          },
        }
      );
    })(),
    Inventory: (() => {
      const keySchema = {
        owner: "address",
        item: "uint32",
        itemVariant: "uint32",
      } as const;
      const valueSchema = { amount: "uint32" } as const;
      return defineComponent(
        world,
        {
          amount: RecsType.Number,
        },
        {
          id: "0x00000000000000000000000000000000496e76656e746f727900000000000000",
          metadata: {
            tableName: ":Inventory",
            keySchema,
            valueSchema,
          },
        }
      );
    })(),
  };
}
