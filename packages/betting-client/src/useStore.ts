// import IWorldAbi from "betting-contracts/out/IWorld.sol/IWorld.abi.json";
// import { GetContractReturnType, PublicClient, Transport, Chain, Address } from "viem";
// import { create } from "zustand";
// import { createSkyStrife } from "headless-client/src/createSkyStrife";
// import { createBettingMarket } from "./network/createBettingMarket";

// export type ContractType = GetContractReturnType<typeof IWorldAbi, PublicClient<Transport, Chain>, Address>;

// export type Store = {
//   skystrife: Awaited<ReturnType<typeof createSkyStrife>> | undefined;
//   bettingMarket: Awaited<ReturnType<typeof createBettingMarket>> | undefined;
// };

// export const useStore = create<Store>(() => ({
//   skystrife: undefined,
//   bettingMarket: undefined,
// }));

import IWorldAbi from "betting-contracts/out/IWorld.sol/IWorld.abi.json";
import { GetContractReturnType, PublicClient, Transport, Chain, WalletClient, Address } from "viem";
import { create } from "zustand";
import { Config } from "wagmi";
import { createSkyStrife } from "headless-client/src/createSkyStrife";
import { createBettingMarket } from "./network/createBettingMarket";

export type ContractType = GetContractReturnType<typeof IWorldAbi, PublicClient<Transport, Chain>, Address>;

export type Store = {
  skystrife: Awaited<ReturnType<typeof createSkyStrife>> | undefined;
  bettingMarket: Awaited<ReturnType<typeof createBettingMarket>> | undefined;
  wagmiConfig: Config | null;
  externalWalletClient: WalletClient | null;
  externalWorldContract: ContractType | null;
};

export const useStore = create<Store>(() => ({
  wagmiConfig: null,
  externalWalletClient: null,
  externalWorldContract: null,
  loadingPageHidden: false,
  skystrife: undefined,
  bettingMarket: undefined,
}));
