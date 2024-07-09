import { useEffect } from "react";
import { useStore } from "../useStore";
import { useSkyStrife } from "./useSkyStrife";
import { getNetworkConfig } from "../mud/getBrowserNetworkConfig";

export const MountSkyStrife = () => {
  const config = getNetworkConfig();
  const skystrife = useSkyStrife(config.chainId);
  useEffect(() => {
    if (skystrife) {
      useStore.setState({ skystrife });
    }
  }, [skystrife]);

  return <></>;
};
