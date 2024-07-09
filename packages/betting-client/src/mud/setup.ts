/*
 * This file sets up all the definitions required for a MUD client.
 */

import { createSystemCalls } from "./createSystemCalls";
import { setupNetwork } from "./setupNetwork";
import { NetworkConfig } from "../mud/utils";
export type SetupResult = Awaited<ReturnType<typeof setup>>;

export async function setup(config: NetworkConfig) {
  const network = await setupNetwork();
  const systemCalls = createSystemCalls(network);

  return {
    network,
    systemCalls,
  };
}
