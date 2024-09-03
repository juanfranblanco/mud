import { DecodeDozerRecordsResult, DozerQueryResult, decodeRecords } from "./decodeRecords";
import { Hex } from "viem";
import { TableQuery } from "./common";
import { Table } from "@latticexyz/config";

type DozerResponseSuccess = {
  block_height: string;
  result: DozerQueryResult[];
};

type DozerResponseFail = { msg: string };

type DozerResponse = DozerResponseSuccess | DozerResponseFail;

function isDozerResponseFail(response: DozerResponse): response is DozerResponseFail {
  return "msg" in response;
}

type FetchRecordsArgs = {
  dozerUrl: string;
  storeAddress: Hex;
  queries: TableQuery[];
};

type FetchRecordsResult =
  | {
      blockHeight: bigint;
      result: {
        table: Table;
        records: DecodeDozerRecordsResult;
      }[];
    }
  | undefined;

export async function fetchRecords({ dozerUrl, queries, storeAddress }: FetchRecordsArgs): Promise<FetchRecordsResult> {
  const response: DozerResponse = await (
    await fetch(new URL("/q", dozerUrl), {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(queries.map((query) => ({ address: storeAddress, query: query.sql }))),
    })
  ).json();

  if (isDozerResponseFail(response)) {
    console.warn(`Dozer response: ${response.msg}\n\nTry reproducing via cURL:
    curl ${dozerUrl} \\
    --compressed \\
    -H 'Accept-Encoding: gzip' \\
    -H 'Content-Type: application/json' \\
    -d '[${queries.map((query) => `{"address": "${storeAddress}", "query": "${query.sql.replaceAll('"', '\\"')}"}`).join(",")}]'`);
    return;
  }

  const result: FetchRecordsResult = {
    blockHeight: BigInt(response.block_height),
    result: response.result.map((records, index) => ({
      table: queries[index].table,
      records: decodeRecords({ schema: queries[index].table.schema, records }),
    })),
  };

  return result;
}
