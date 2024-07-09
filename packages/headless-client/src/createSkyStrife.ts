import { z } from "zod";
import { NetworkLayer, createNetworkLayer } from "client/src/layers/Network/";
import { createNetworkConfig } from "./createNetworkConfig";
import { SyncStep } from "@latticexyz/store-sync";
import { filter, firstValueFrom, take } from "rxjs";
import { Wallet } from "ethers";
import { createBurnerAccount, transportObserver } from "@latticexyz/common";
import {
  createPublicClient,
  fallback,
  webSocket,
  http,
  createWalletClient,
  Hex,
  ClientConfig,
  stringToHex,
  GetContractReturnType,
  PublicClient,
  Transport,
  Chain,
  Address,
  isHex,
  pad,
  getContract,
} from "viem";
import IWorldAbi from "contracts/out/IWorld.sol/IWorld.abi.json";
import { HeadlessLayer, createHeadlessLayer } from "client/src/layers/Headless";
import { Entity } from "@latticexyz/recs";
import { transactionQueue } from "@latticexyz/common/actions";

let env: Record<string, string | number | boolean | undefined>;
if (typeof process !== "undefined" && process.env) {
  env = z
    .object({
      CHAIN_ID: z.coerce.number().positive().optional(),
      PRIVATE_KEY: z
        .string()
        .optional()
        .transform((val) => (val ? (isHex(val) ? val : stringToHex(val, { size: 64 })) : undefined)),
      DISABLE_INDEXER: z
        .string()
        .optional()
        .transform((val) => (val ? val === "true" : undefined)),
      LEVEL_ID: z.string().optional(),
      MATCH_ENTITY: z.string().optional(),
    })
    .parse(process.env, {
      errorMap: (issue) => ({
        message: `Missing or invalid environment variable: ${issue.path.join(".")}`,
      }),
    });
} else {
  env = {};
}

export type SkyStrife = Awaited<ReturnType<typeof createSkyStrife>>;

export async function createSkyStrife(
  props: {
    chainId?: number;
    disableIndexer?: boolean;
    matchEntity?: Entity | undefined;
  } = {},
): Promise<{
  networkLayer: NetworkLayer;
  headlessLayer: HeadlessLayer;
  createPlayer: (privateKey?: Hex) => {
    worldContract: GetContractReturnType<typeof IWorldAbi, PublicClient<Transport, Chain>, Address>;
    walletClient: ReturnType<typeof createWalletClient>;
    address: Hex;
    entity: Hex;
  };
}> {
  const chainId = props?.chainId || env.CHAIN_ID;
  const disableIndexer = props?.disableIndexer || env.DISABLE_INDEXER;
  const matchEntity = props?.matchEntity || (env.MATCH_ENTITY as Entity | undefined);

  if (!chainId) {
    throw new Error("CHAIN_ID is required");
  }

  const networkConfig = createNetworkConfig(chainId as number, {
    disableIndexer: Boolean(disableIndexer),
    matchEntity,
    privateKey: env.PRIVATE_KEY as string,
  });

  console.log(`Connecting to ${networkConfig.chain.name}...`);
  if (matchEntity) {
    console.log(`Loading Match: ${matchEntity}`);
  }

  const networkLayer = await createNetworkLayer(networkConfig);
  const headlessLayer = await createHeadlessLayer(networkLayer);

  const {
    components: { SyncProgress },
  } = networkLayer;

  async function waitForSync() {
    const live$ = SyncProgress.update$.pipe(
      filter((progress) => {
        const [val] = progress.value;

        if (val) {
          console.log(val.message);
        }

        return val?.step === SyncStep.LIVE;
      }),
      take(1),
    );

    return firstValueFrom(live$);
  }

  const clientOptions = {
    chain: networkConfig.chain,
    transport: transportObserver(fallback([webSocket(), http()], { retryCount: 0 })),
    pollingInterval: 250,
  } as const satisfies ClientConfig;

  const publicClient = createPublicClient(clientOptions);

  function createPlayer(privateKey?: Hex) {
    if (!privateKey) {
      privateKey = Wallet.createRandom().privateKey as Hex;
    }

    const burnerAccount = createBurnerAccount(privateKey);
    const burnerWalletClient = createWalletClient({
      ...clientOptions,
      account: burnerAccount,
    });
    const txQueue = transactionQueue({
      queueConcurrency: 3,
    });
    const extendedWalletClient = burnerWalletClient.extend(txQueue);

    const worldContract = getContract({
      address: networkConfig.worldAddress as Hex,
      abi: IWorldAbi,
      client: {
        public: publicClient,
        wallet: extendedWalletClient,
      },
    });

    return {
      worldContract,
      walletClient: burnerWalletClient,
      address: burnerAccount.address,
      entity: pad(burnerAccount.address, { size: 32 }).toLowerCase() as Hex,
    };
  }

  return {
    networkLayer,
    headlessLayer,
    createPlayer,
  };
}
