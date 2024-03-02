/*
 * This file sets up all the definitions required for a MUD client.
 */

import { createConfig } from "wagmi";
import { setupNetwork } from "./setupNetwork";

export async function setup() {
  const network = await setupNetwork();

  const wagmiConfig = createConfig({
    chains: [network.publicClient.chain],
    client: () => network.publicClient,
  });

  return {
    network,
    wagmiConfig,
  };
}
