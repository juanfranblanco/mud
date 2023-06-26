import path from "path";
import {
  AbsoluteImportDatum,
  RelativeImportDatum,
  ImportDatum,
  StaticResourceData,
  RenderKeyTuple,
  RenderType,
} from "./types";
import { posixPath } from "../utils";

export const renderedSolidityHeader = `// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */`;

/**
 * Renders a list of lines
 */
export function renderList<T>(list: T[], renderItem: (item: T, index: number) => string): string {
  return internalRenderList("", list, renderItem);
}

/**
 * Renders a comma-separated list of arguments for solidity functions, ignoring empty and undefined ones
 */
export function renderArguments(args: (string | undefined)[] | readonly (string | undefined)[]): string {
  const filteredArgs = args.filter((arg) => arg !== undefined && arg !== "") as string[];
  return internalRenderList(",", filteredArgs, (arg) => arg);
}

export function renderCommonData({
  staticResourceData,
  keyTuple,
}: {
  staticResourceData?: StaticResourceData;
  keyTuple: RenderKeyTuple[];
}): {
  _tableId: string;
  _typedTableId: string;
  _keyArgs: string;
  _typedKeyArgs: string;
  _keyTupleDefinition: string;
} {
  // static resource means static tableId as well, and no tableId arguments
  const _tableId = staticResourceData ? "" : "_tableId";
  const _typedTableId = staticResourceData ? "" : "bytes32 _tableId";

  const _keyArgs = renderArguments(keyTuple.map(({ name }) => name));
  const _typedKeyArgs = renderArguments(keyTuple.map(({ name, typeWithLocation }) => `${typeWithLocation} ${name}`));

  const _keyTupleDefinition = `
    bytes32[] memory _keyTuple = new bytes32[](${keyTuple.length});
    ${renderList(keyTuple, (key, index) => `_keyTuple[${index}] = ${renderValueTypeToBytes32(key.name, key)};`)}
  `;

  return {
    _tableId,
    _typedTableId,
    _keyArgs,
    _typedKeyArgs,
    _keyTupleDefinition,
  };
}

/** For 2 paths which are relative to a common root, create a relative import path from one to another */
export function solidityRelativeImportPath(fromPath: string, usedInPath: string): string {
  // 1st "./" must be added because path strips it,
  // but solidity expects it unless there's "../" ("./../" is fine).
  // 2nd and 3rd "./" forcefully avoid absolute paths (everything is relative to `src`).
  return "./" + path.relative("./" + usedInPath, "./" + fromPath);
}

/**
 * Aggregates, deduplicates and renders imports for symbols per path.
 * Identical symbols from different paths are NOT handled, they should be checked before rendering.
 */
export function renderImports(imports: ImportDatum[]): string {
  return renderAbsoluteImports(
    imports.map((importDatum) => {
      if ("path" in importDatum) {
        return importDatum;
      } else {
        return {
          symbol: importDatum.symbol,
          path: solidityRelativeImportPath(importDatum.fromPath, importDatum.usedInPath),
        };
      }
    })
  );
}

/**
 * Aggregates, deduplicates and renders imports for symbols per path.
 * Identical symbols from different paths are NOT handled, they should be checked before rendering.
 */
export function renderRelativeImports(imports: RelativeImportDatum[]): string {
  return renderAbsoluteImports(
    imports.map(({ symbol, fromPath, usedInPath }) => ({
      symbol,
      path: solidityRelativeImportPath(fromPath, usedInPath),
    }))
  );
}

/**
 * Aggregates, deduplicates and renders imports for symbols per path.
 * Identical symbols from different paths are NOT handled, they should be checked before rendering.
 */
export function renderAbsoluteImports(imports: AbsoluteImportDatum[]): string {
  // Aggregate symbols by import path, also deduplicating them
  const aggregatedImports = new Map<string, Set<string>>();
  for (const { symbol, path } of imports) {
    if (!aggregatedImports.has(path)) {
      aggregatedImports.set(path, new Set());
    }
    aggregatedImports.get(path)?.add(symbol);
  }
  // Render imports
  const renderedImports = [];
  for (const [path, symbols] of aggregatedImports) {
    const renderedSymbols = [...symbols].join(", ");
    renderedImports.push(`import { ${renderedSymbols} } from "${posixPath(path)}";`);
  }
  return renderedImports.join("\n");
}

export function renderWithStore(
  storeArgument: boolean,
  callback: (
    _typedStore: string | undefined,
    _store: string,
    _commentSuffix: string,
    _untypedStore: string | undefined
  ) => string
): string {
  let result = "";
  result += callback(undefined, "StoreSwitch", "", undefined);

  if (storeArgument) {
    result += "\n" + callback("IStore _store", "_store", " (using the specified store)", "_store");
  }

  return result;
}

export function renderTableId(staticResourceData: StaticResourceData): {
  hardcodedTableId: string;
  tableIdDefinition: string;
} {
  const hardcodedTableId = `bytes32(abi.encodePacked(bytes16("${staticResourceData.namespace}"), bytes16("${staticResourceData.name}")))`;

  const tableIdDefinition = `
    bytes32 constant _tableId = ${hardcodedTableId};
    bytes32 constant ${staticResourceData.tableIdName} = _tableId;
  `;
  return {
    hardcodedTableId,
    tableIdDefinition,
  };
}

export function renderValueTypeToBytes32(name: string, { typeUnwrap, internalTypeId }: RenderType): string {
  const innerText = typeUnwrap.length ? `${typeUnwrap}(${name})` : name;

  if (internalTypeId === "bytes32") {
    return innerText;
  } else if (internalTypeId.match(/^bytes\d{1,2}$/)) {
    return `bytes32(${innerText})`;
  } else if (internalTypeId.match(/^uint\d{1,3}$/)) {
    return `bytes32(uint256(${innerText}))`;
  } else if (internalTypeId.match(/^int\d{1,3}$/)) {
    return `bytes32(uint256(int256(${innerText})))`;
  } else if (internalTypeId === "address") {
    return `bytes32(uint256(uint160(${innerText})))`;
  } else if (internalTypeId === "bool") {
    return `_boolToBytes32(${innerText})`;
  } else {
    throw new Error(`Unknown value type id ${internalTypeId}`);
  }
}

function internalRenderList<T>(
  lineTerminator: string,
  list: T[],
  renderItem: (item: T, index: number) => string
): string {
  return list
    .map((item, index) => renderItem(item, index) + (index === list.length - 1 ? "" : lineTerminator))
    .join("\n");
}
