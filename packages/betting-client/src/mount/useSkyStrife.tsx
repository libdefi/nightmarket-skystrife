import { useEffect, useMemo } from "react";
import { createSkyStrife } from "headless-client/src/createSkyStrife";
import { usePromiseValue } from "../usePromiseValue";

export const useSkyStrife = (chainId: number) => {
  const skyStrifePromise = useMemo(async () => {
    return createSkyStrife({ chainId });
  }, [chainId]);

  useEffect(() => {
    return () => {
      skyStrifePromise.then((ss) => ss.networkLayer.network.world.dispose());
    };
  }, [skyStrifePromise]);

  return usePromiseValue(skyStrifePromise);
};
