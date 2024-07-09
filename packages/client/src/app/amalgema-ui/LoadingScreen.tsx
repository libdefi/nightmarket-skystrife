import React, { useEffect, useMemo, useState } from "react";
import { getComponentValue } from "@latticexyz/recs";
import { concat, map } from "rxjs";
import { useObservableValue } from "../../useObservableValue";
import { filterNullish } from "@latticexyz/utils";
import { NetworkLayer } from "../../layers/Network";
import { Button } from "../ui/Theme/SkyStrife/Button";
import { Body, Caption, Link, OverlineLarge } from "../ui/Theme/SkyStrife/Typography";
import { Card } from "../ui/Theme/SkyStrife/Card";
import { DISCORD_URL, HOW_TO_PLAY_URL, LATTICE_URL, MUD_URL } from "../links";
import { SyncStep } from "@latticexyz/store-sync";
import { singletonEntity } from "@latticexyz/store-sync/recs";
import { useStore } from "../../useStore";
import { DateTime } from "luxon";

type Props = {
  networkLayer: NetworkLayer | null;
  usePrepTime?: boolean;
};

function getNowSeconds() {
  return Math.floor(DateTime.now().toSeconds());
}

function createAnalyticsSender(networkLayer: NetworkLayer) {
  const {
    components: { SyncProgress },
    utils: { sendAnalyticsEvent },
    network: {
      matchEntity,
      networkConfig: { indexerUrl },
    },
  } = networkLayer;

  sendAnalyticsEvent("loading-screen", {
    startTime: getNowSeconds(),
    matchEntity,
  });
  if (indexerUrl) {
    sendAnalyticsEvent("loading-screen", {
      startSnapshotFetch: getNowSeconds(),
      matchEntity,
    });
  }

  let sentEndEvent = false;
  let sentEndSnapshotFetch = false;
  let sentStartSnapshotHydrate = false;
  let sentEndSnapshotHydrate = false;
  let sentStartRpcHydrate = false;
  let sentEndRpcHydrate = false;

  SyncProgress.update$.subscribe(() => {
    const loadingState = getComponentValue(SyncProgress, singletonEntity);
    if (!loadingState) return;

    if (!sentEndSnapshotFetch && loadingState.step === SyncStep.SNAPSHOT) {
      sendAnalyticsEvent("loading-screen", {
        endSnapshotFetch: getNowSeconds(),
        matchEntity,
        blockNumber: loadingState.lastBlockNumberProcessed.toString(),
      });
      sentEndSnapshotFetch = true;
    }

    if (
      !sentStartSnapshotHydrate &&
      loadingState.step === SyncStep.SNAPSHOT &&
      loadingState.message.includes("Hydrating")
    ) {
      sendAnalyticsEvent("loading-screen", {
        startSnapshotHydrate: getNowSeconds(),
        matchEntity,
      });
      sentStartSnapshotHydrate = true;
    }

    if (
      !sentEndSnapshotHydrate &&
      loadingState.step === SyncStep.SNAPSHOT &&
      loadingState.message.includes("Hydrating") &&
      loadingState.percentage === 100
    ) {
      sendAnalyticsEvent("loading-screen", {
        endSnapshotHydrate: getNowSeconds(),
        matchEntity,
      });
      sentEndSnapshotHydrate = true;
    }

    if (!sentStartRpcHydrate && loadingState.step === SyncStep.RPC) {
      sendAnalyticsEvent("loading-screen", {
        startRpcHydrate: getNowSeconds(),
        matchEntity,
        blockNumber: loadingState.lastBlockNumberProcessed.toString(),
      });
      sentStartRpcHydrate = true;
    }

    if (sentStartRpcHydrate && !sentEndRpcHydrate && loadingState.step === SyncStep.LIVE) {
      sendAnalyticsEvent("loading-screen", {
        endRpcHydrate: getNowSeconds(),
        matchEntity,
        blockNumber: loadingState.lastBlockNumberProcessed.toString(),
      });
      sentEndRpcHydrate = true;
    }

    if (!sentEndEvent && loadingState.step === SyncStep.LIVE) {
      sendAnalyticsEvent("loading-screen", {
        endTime: getNowSeconds(),
        matchEntity,
      });
      sentEndEvent = true;
    }
  });
}

export const LoadingScreen = ({ networkLayer, usePrepTime }: Props) => {
  const { loadingPageHidden: hide } = useStore();
  const setHide = (h: boolean) => {
    useStore.setState({ loadingPageHidden: h });
  };

  const [isMatch, setIsMatch] = React.useState(false);

  const [prepareGameProgress, setPrepareGameProgress] = useState(0);
  const [startGameProgress, setStartGameProgress] = useState(false);

  const loadingState = useObservableValue(
    useMemo(() => {
      if (!networkLayer) return;
      const {
        components: { SyncProgress },
        network: { matchEntity },
      } = networkLayer;

      createAnalyticsSender(networkLayer);
      setIsMatch(Boolean(matchEntity));

      // use LoadingState.update$ as a trigger rather than a value
      // and concat with an initial value to trigger the first look up
      return concat([1], SyncProgress.update$).pipe(
        map(() => {
          const loadingState = getComponentValue(SyncProgress, singletonEntity);
          return loadingState ?? null;
        }),
        filterNullish(),
      );
    }, [networkLayer]),
    {
      message: "Connecting",
      percentage: 0,
      step: SyncStep.INITIALIZE,
      lastBlockNumberProcessed: 0n,
      latestBlockNumber: 0n,
    },
  );

  const [worldValid, setWorldValid] = useState(true);
  useEffect(() => {
    if (!networkLayer) return;
    if (loadingState.step !== SyncStep.LIVE) return;

    if (!usePrepTime || prepareGameProgress === 100) {
      const {
        components: { SkyPoolConfig },
      } = networkLayer;

      // check if there is a value for a table that is only available after the game is ready
      // SkyPoolConfig is set in the PostDeploy script
      // if it does not exist something is wrong
      const skyPoolConfig = getComponentValue(SkyPoolConfig, singletonEntity);
      setWorldValid(!!skyPoolConfig);
    }
  }, [loadingState.step, networkLayer, prepareGameProgress, usePrepTime]);

  useEffect(() => {
    if (!usePrepTime) return;
    if (!networkLayer) return;
    if (loadingState.step !== SyncStep.LIVE) return;

    setStartGameProgress(true);
  }, [loadingState, networkLayer, prepareGameProgress, usePrepTime]);

  const prepTimeSeconds = import.meta.env.PROD ? 10 : 1;
  useEffect(() => {
    if (!startGameProgress) return;

    const interval = setInterval(
      () => {
        setPrepareGameProgress((prev) => {
          if (prev === 100) {
            clearInterval(interval);
            return prev;
          }
          return prev + 1;
        });
      },
      (prepTimeSeconds * 1000) / 100,
    );

    return () => clearInterval(interval);
  }, [networkLayer, prepTimeSeconds, startGameProgress, usePrepTime]);

  const doneLoading = usePrepTime ? prepareGameProgress === 100 : loadingState.step === SyncStep.LIVE;
  useEffect(() => {
    if (doneLoading && isMatch && worldValid) setHide(true);
  }, [doneLoading, isMatch, worldValid]);

  const showPrepMessage = loadingState.step === SyncStep.LIVE && usePrepTime;

  const loadingMessage = showPrepMessage ? "Preparing Game" : loadingState.message;
  const loadingPercentage = showPrepMessage ? prepareGameProgress : Math.round(loadingState.percentage);
  const showPercentage = showPrepMessage || loadingPercentage > 0;

  if (hide) {
    return null;
  }

  return (
    <div
      style={{
        zIndex: 1200,
        background: "linear-gradient(rgba(24, 23, 16, 0.4), rgba(24, 23, 16, 0.4)), url(assets/ss-splash-min.png)",
        backgroundPosition: "right",
        backgroundSize: "cover",
      }}
      className="fixed items-center justify-center w-screen h-screen bg-black p-12 flex flex-col pointer-events-none"
    >
      <Card primary className="flex flex-col w-[540px] p-8 justify-items">
        {isMatch && (
          <>
            <OverlineLarge
              style={{
                fontSize: "40px",
                lineHeight: "100%",
                letterSpacing: "-2%",
              }}
              className="normal-case text-center"
            >
              Entering Match...
            </OverlineLarge>
          </>
        )}

        {!isMatch && (
          <>
            <OverlineLarge
              style={{
                fontSize: "80px",
                lineHeight: "100%",
                letterSpacing: "-2%",
              }}
              className="normal-case text-center"
            >
              Sky Strife
            </OverlineLarge>
          </>
        )}

        {!doneLoading && (
          <div className="flex flex-col grow items-center mt-4 text-center">
            <Body>Sky Strife is a fast-paced, onchain RTS game running on Redstone.</Body>

            <div className="h-4"></div>

            <a className="w-full" href={HOW_TO_PLAY_URL} target="_blank" rel="noreferrer">
              <Button buttonType="tertiary" size="lg" className="w-full">
                How To Play
              </Button>
            </a>
          </div>
        )}

        {doneLoading && worldValid && (
          <div className="flex flex-col grow pointer-events-auto">
            <Body className="px-4 mt-4 text-center text-sm font-thin">
              By clicking &apos;I agree&apos;, you acknowledge that you (i) agree to the{" "}
              <Link className="" href={"/terms.pdf"}>
                Terms of Service
              </Link>{" "}
              and (ii) have read and understood our <Link href={"/privacy-policy"}>Privacy Policy</Link>.
            </Body>

            <div className="h-3" />

            <Button
              buttonType="primary"
              size="lg"
              onClick={() => {
                if (networkLayer)
                  networkLayer.utils.sendAnalyticsEvent("loading-screen", {
                    hideClicked: getNowSeconds(),
                    matchEntity: networkLayer.network.matchEntity,
                    blockNumber: loadingState.lastBlockNumberProcessed.toString(),
                  });
                setHide(true);
              }}
              className="w-full"
            >
              I agree
            </Button>
          </div>
        )}

        {doneLoading && !worldValid && (
          <div className="flex flex-row w-full mt-8 justify-center items-center">
            <img height="64px" width="64px" src="/public/assets/dragoon_attack.gif" />
            <div className="w-4"></div>
            <Body className="text-center text-3xl text-ss-text-default">
              {import.meta.env.DEV
                ? "The connected Sky Strife world is not valid. This usually means contract deployment is ongoing or failed. Check your console for more information."
                : "Something went wrong. Please report this issue on Discord."}
            </Body>
            <div className="w-4"></div>
            <img height="64px" width="64px" src="/public/assets/dragoon_attack.gif" />
          </div>
        )}

        {!doneLoading && (
          <div className="flex flex-row w-full mt-8 justify-center items-center">
            <img height="64px" width="64px" src="/public/assets/dragoon_attack.gif" />
            <div className="w-4"></div>
            <Body className="text-center text-3xl text-ss-text-default">
              {loadingMessage}
              {showPercentage && <div className="text-ss-blue">({loadingPercentage}%)</div>}
            </Body>
            <div className="w-4"></div>
            <img height="64px" width="64px" src="/public/assets/dragoon_attack.gif" />
          </div>
        )}
      </Card>

      <div className="stretch"></div>

      <div className="flex justify-between stretch">
        <div className="absolute bottom-6 left-6 flex justify-between">
          <Link className="text-ss-gold" href={LATTICE_URL}>
            lattice.xyz
          </Link>

          <div className="w-6 text-center text-ss-divider-stroke">|</div>

          <Link className="text-ss-gold" href={DISCORD_URL}>
            join discord
          </Link>

          <div className="w-6 text-center text-ss-divider-stroke">|</div>

          <Link className="text-ss-gold" href={HOW_TO_PLAY_URL}>
            getting started
          </Link>

          <div className="w-6 text-center text-ss-divider-stroke">|</div>

          <Link className="text-ss-gold" href={"/privacy-policy"}>
            privacy policy
          </Link>

          <div className="w-6 text-center text-ss-divider-stroke">|</div>

          <Link className="text-ss-gold" href={"/terms.pdf"}>
            terms of service
          </Link>
        </div>

        <Caption className="absolute bottom-6 right-6 ml-4 text-neutral-300">
          powered by{" "}
          <Link className="text-ss-gold" href={MUD_URL}>
            MUD
          </Link>
        </Caption>
      </div>
    </div>
  );
};
