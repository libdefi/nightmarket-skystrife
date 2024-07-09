import { NetworkConfig } from "../mud/utils";
import { setup } from "../mud/setup";

export type BettingMarket = Awaited<ReturnType<typeof createBettingMarket>>;

export async function createBettingMarket(config: NetworkConfig) {
  console.log("creating betting market");

  const { network } = await setup(config);

  const layer = {
    world: network.world,
    network,
    components: {
      ...network.components,
    },
  };

  return layer;
}
