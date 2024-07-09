import { useStore } from "./useStore";

export const useAmalgema = () => {
  const { externalWalletClient, externalWorldContract } = useStore();

  return { externalWalletClient, externalWorldContract };
};
