import { AbiFunction, Address, Hex, createWalletClient, http, parseAbi } from "viem";
import { getBlockNumber, getLogs } from "viem/actions";
import { helloStoreEvent } from "@latticexyz/store";
import { helloWorldEvent } from "@latticexyz/world";
import { getWorldAbi } from "@latticexyz/world/internal";
import { CHAINS } from "../../../consts";
import { ChainId } from "../../../hooks/useChainId";

export const dynamic = "force-dynamic";

async function getClient() {
  // TODO: resolve ts error
  const chain = CHAINS[Number(process.env.NEXT_PUBLIC_CHAIN_ID) as ChainId];
  const client = createWalletClient({
    chain,
    transport: http(),
  });

  return client;
}

async function getParameters(worldAddress: Address) {
  const client = await getClient();
  const toBlock = await getBlockNumber(client);
  const logs = await getLogs(client, {
    strict: true,
    address: worldAddress,
    events: parseAbi([helloStoreEvent, helloWorldEvent] as const),
    fromBlock: "earliest",
    toBlock,
  });
  const fromBlock = logs[0]?.blockNumber ?? 0n;
  // world is considered loaded when both events are emitted
  const isWorldDeployed = logs.length === 2;

  console.log("logs", logs);

  return { fromBlock, toBlock, isWorldDeployed };
}

export async function GET(req: Request) {
  const { searchParams } = new URL(req.url);
  const worldAddress = searchParams.get("address") as Hex;

  if (!worldAddress) {
    return Response.json({ error: "address is required" }, { status: 400 });
  }

  try {
    const client = await getClient();
    const { fromBlock, toBlock, isWorldDeployed } = await getParameters(worldAddress);
    const worldAbiResponse = await getWorldAbi({
      client,
      worldAddress,
      fromBlock,
      toBlock,
    });

    const abi = worldAbiResponse
      .filter((entry): entry is AbiFunction => entry.type === "function")
      .sort((a, b) => a.name.localeCompare(b.name));

    return Response.json({ abi, isWorldDeployed });
  } catch (error: unknown) {
    if (error instanceof Error) {
      return Response.json({ error: error.message }, { status: 400 });
    } else {
      return Response.json({ error: "An unknown error occurred" }, { status: 400 });
    }
  }
}
