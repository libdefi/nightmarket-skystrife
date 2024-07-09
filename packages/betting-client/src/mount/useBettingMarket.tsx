import { useEffect, useMemo } from "react";
import { usePromiseValue } from "../usePromiseValue";
import { NetworkConfig } from "../mud/utils";
import { createBettingMarket } from "../network/createBettingMarket";

export const useBettingMarket = (config: NetworkConfig) => {
  const bettingMarketPromise = useMemo(async () => {
    return createBettingMarket(config);
  }, [config.chainId]);

  useEffect(() => {
    return () => {
      bettingMarketPromise.then((bm) => bm.network.world.dispose());
    };
  }, [bettingMarketPromise]);

  return usePromiseValue(bettingMarketPromise);
};
