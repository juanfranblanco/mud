import { unionToTuple } from "@ark/util";

export type valuesOf<T extends object> = unionToTuple<T[keyof T]>;

export function valuesOf<T extends object>(value: T): valuesOf<T> {
  return Object.values(value) as never;
}
