import { useEffect } from "react";
import { useStore } from "../useStore";
import { getNetworkConfig } from "../mud/getBrowserNetworkConfig";
import { useBettingMarket } from "./useBettingMarket";

export const MountBettingMarket = () => {
  const config = getNetworkConfig();
  const bettingMarket = useBettingMarket(config);
  useEffect(() => {
    if (bettingMarket) {
      useStore.setState({ bettingMarket });
    }
  }, [bettingMarket]);

  return <></>;
};
