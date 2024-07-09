import { useStore } from "@/useStore";

export const useMUD = () => {
  const { skystrife, bettingMarket, externalWorldContract } = useStore();

  if (skystrife == null || bettingMarket == null) {
    throw new Error("Store not initialized");
  }

  return {
    skystrife,
    bettingMarket,
    externalWorldContract,
  };
};
