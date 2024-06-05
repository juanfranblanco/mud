import { CreateNonceManagerOptions, CreateNonceManagerResult, createNonceManager } from "./createNonceManager";
import { getNonceManagerId } from "./getNonceManagerId";

const nonceManagers = new Map<string, CreateNonceManagerResult>();

export async function getNonceManager({
  client,
  chainId,
  address, // TODO: rename to account?
  blockTag = "pending",
  ...opts
}: CreateNonceManagerOptions): Promise<CreateNonceManagerResult> {
  const id = await getNonceManagerId({ client, chainId, address, blockTag });

  const existingNonceManager = nonceManagers.get(id);
  if (existingNonceManager) {
    return existingNonceManager;
  }

  const nonceManager = createNonceManager({ client, chainId, address, blockTag, ...opts });
  nonceManagers.set(id, nonceManager);
  return nonceManager;
}
