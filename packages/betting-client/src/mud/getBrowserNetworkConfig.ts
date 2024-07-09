import { Wallet } from "ethers";
import { getChain, getWorldFromChainId } from "./utils";

export const getBurnerWallet = () => {
  const params = new URLSearchParams(window.location.search);

  const manualPrivateKey = params.get("privateKey");
  if (manualPrivateKey) return new Wallet(manualPrivateKey).privateKey;

  const storageKey = "mud:burnerWallet";

  const privateKey = localStorage.getItem(storageKey);
  if (privateKey) return privateKey;

  const burnerWallet = Wallet.createRandom();
  localStorage.setItem(storageKey, burnerWallet.privateKey);
  return burnerWallet.privateKey;
};

export function getNetworkConfig() {
  const params = new URLSearchParams(window.location.search);
  const chainId = Number(params.get("chainId") || import.meta.env.VITE_CHAIN_ID || 31337);
  const chain = getChain(chainId);

  const world = getWorldFromChainId(chain.id);
  const worldAddress = params.get("worldAddress") || world?.address;
  if (!worldAddress) {
    throw new Error(`No world address found for chain ${chainId}. Did you run \`mud deploy\`?`);
  }

  const initialBlockNumber = params.has("initialBlockNumber")
    ? Number(params.get("initialBlockNumber"))
    : world?.blockNumber ?? -1; // -1 will attempt to find the block number from RPC

  const useBurner = params.has("useBurner");
  const burnerWalletPrivateKey = params.has("anon") ? Wallet.createRandom().privateKey : getBurnerWallet();

  return {
    clock: {
      period: 1000,
      initialTime: 0,
      syncInterval: 2000,
    },
    provider: {
      chainId,
      jsonRpcUrl: params.get("rpc") ?? chain.rpcUrls.default.http[0],
      wsRpcUrl: params.get("wsRpc") ?? chain.rpcUrls.default.webSocket?.[0],
    },
    privateKey: burnerWalletPrivateKey,
    useBurner,
    chainId,
    faucetServiceUrl: params.get("faucet") ?? chain.faucetUrl,
    worldAddress,
    initialBlockNumber,
    chain,
  };
}
