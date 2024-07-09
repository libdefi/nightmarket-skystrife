import { SkyStrife } from "headless-client/src/createSkyStrife";
import { useEffect, useState, useMemo } from "react";
import { BettingMarket } from "../network/createBettingMarket";
import { useObservableValue } from "../useObservableValue";
import { concat, map } from "rxjs";
import { getComponentValue } from "@latticexyz/recs";
import { SyncStep } from "@latticexyz/store-sync";
import { singletonEntity } from "@latticexyz/store-sync/recs";
import { filterNullish } from "@latticexyz/utils";

type Props = {
  skystrife: SkyStrife | undefined;
  bettingMarket: BettingMarket | undefined;
};

export const LoadingScreen = ({ skystrife, bettingMarket }: Props) => {
  const [isComplete, setIsComplete] = useState(false);
  const [isDelayedComplete, setIsDelayedComplete] = useState(false);

  const bettingMarketLoadingState = useObservableValue(
    useMemo(() => {
      if (!bettingMarket) return;
      const {
        components: { SyncProgress },
      } = bettingMarket;

      return concat([1], SyncProgress.update$).pipe(
        map(() => {
          const loadingState = getComponentValue(SyncProgress, singletonEntity);
          return loadingState ?? null;
        }),
        filterNullish(),
      );
    }, [bettingMarket]),
    {
      message: "Connecting",
      percentage: 0,
      step: SyncStep.INITIALIZE,
      lastBlockNumberProcessed: 0n,
      latestBlockNumber: 0n,
    },
  );

  const skyStrifeLoadingState = useObservableValue(
    useMemo(() => {
      if (!skystrife) return;
      const {
        networkLayer: {
          components: { SyncProgress },
        },
      } = skystrife;

      return concat([1], SyncProgress.update$).pipe(
        map(() => {
          const loadingState = getComponentValue(SyncProgress, singletonEntity);
          return loadingState ?? null;
        }),
        filterNullish(),
      );
    }, [skystrife]),
    {
      message: "Connecting",
      percentage: 0,
      step: SyncStep.INITIALIZE,
      lastBlockNumberProcessed: 0n,
      latestBlockNumber: 0n,
    },
  );

  useEffect(() => {
    if (bettingMarketLoadingState.step === SyncStep.LIVE && skyStrifeLoadingState.step === SyncStep.LIVE) {
      setIsComplete(true);
      setTimeout(() => setIsDelayedComplete(true), 1000);
    }
  }, [bettingMarketLoadingState, skyStrifeLoadingState]);

  if (isDelayedComplete) {
    return null;
  }

  return (
    <div
      style={{
        zIndex: 1200,
        background: "linear-gradient(rgba(24, 23, 16, 0.9), rgba(24, 23, 16, 0.9))",
        backgroundPosition: "right",
        backgroundSize: "cover",
      }}
      className="fixed items-center justify-center w-screen h-screen bg-black p-12 flex flex-col pointer-events-none"
    >
      <div className="flex flex-col w-[540px] p-8 justify-items">
        <div
          style={{
            fontSize: "40px",
            lineHeight: "100%",
            letterSpacing: "-2%",
          }}
          className="normal-case text-center text-white"
        >
          Night Market: {bettingMarketLoadingState.message}
        </div>
        <div className="flex flex-col grow items-center mt-4 text-center">
          <div className="h-4"></div>
          <div className="w-full">
            <div className="w-full bg-gray-200 rounded-full h-4">
              <div
                className="bg-blue-600 h-4 rounded-full"
                style={{ width: `${bettingMarketLoadingState.percentage}%` }}
              ></div>
            </div>
          </div>
          <div className="mt-2 text-white">{bettingMarketLoadingState.percentage}%</div>
        </div>
        <div
          style={{
            fontSize: "40px",
            lineHeight: "100%",
            letterSpacing: "-2%",
          }}
          className="normal-case text-center mt-8 text-white"
        >
          Sky Strife: {skyStrifeLoadingState.message}
        </div>
        <div className="flex flex-col grow items-center mt-4 text-center">
          <div className="h-4"></div>
          <div className="w-full">
            <div className="w-full bg-gray-200 rounded-full h-4">
              <div
                className="bg-green-600 h-4 rounded-full"
                style={{ width: `${skyStrifeLoadingState.percentage}%` }}
              ></div>
            </div>
          </div>
          <div className="mt-2 text-white">{skyStrifeLoadingState.percentage}%</div>
        </div>
      </div>
    </div>
    // <div className="flex bg-gray-900 justify-center items-center h-screen">
    //   <div className="relative inline-flex">
    //     <div className="w-8 h-8 bg-green-500 rounded-full"></div>
    //     <div className="w-8 h-8 bg-green-500 rounded-full absolute top-0 left-0 animate-ping"></div>
    //     <div className="w-8 h-8 bg-green-500 rounded-full absolute top-0 left-0 animate-pulse"></div>
    //   </div>
    // </div>
  );
};
