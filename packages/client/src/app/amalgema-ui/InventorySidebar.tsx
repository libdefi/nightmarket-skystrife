import { Entity } from "@latticexyz/recs";
import { useAmalgema } from "../../useAmalgema";
import { IconButton } from "../ui/Theme/SkyStrife/IconButton";
import { Discord } from "../ui/Theme/SkyStrife/Icons/Discord";
import { Button } from "../ui/Theme/SkyStrife/Button";
import { Twitter } from "../ui/Theme/SkyStrife/Icons/Twitter";
import { DISCORD_URL, FEEDBACK_URL, HOW_TO_PLAY_URL, TWITTER_URL } from "../links";
import { CurrentProfile } from "./CurrentProfile";
import { addressToEntityID } from "../../mud/setupNetwork";
import { Tutorial } from "../ui/Theme/SkyStrife/Icons/Tutorial";
import { useComponentValue } from "@latticexyz/react";
import { EMOJI } from "../../constants";
import { LabeledOrbInput } from "./SummonIsland/common";
import { SessionWalletManager } from "./SessionWalletManager";
import { SeasonPass } from "./SeasonPass";
import { useExternalAccount } from "./hooks/useExternalAccount";
import { MATCH_COST } from "./SummonIsland/MatchCost";
import { useCurrentMatchReward } from "./hooks/useCurrentMatchReward";
import { useHasSkyKeyExternalWallet } from "./hooks/useHasSkyKey";
import { useBurnerBalance } from "./hooks/useBalance";
import { Link } from "../ui/Theme/SkyStrife/Typography";

const DECIMALS = 18;

function Resources() {
  const {
    externalWalletClient,
    components: { ERC20Registry, Orb_Balances },
  } = useAmalgema();

  const { address } = useExternalAccount();

  const registry = useComponentValue(
    ERC20Registry,
    "0x6e734f7262000000000000000000000000000000000000000000000000000000" as Entity, // TODO: encodeNamespace?
  );

  const balance = useComponentValue(Orb_Balances, address ? addressToEntityID(address) : ("0" as Entity));

  return (
    <div
      className="flex justify-between"
      onClick={() => {
        if (externalWalletClient && registry) {
          externalWalletClient.watchAsset({
            type: "ERC20",
            options: {
              address: registry.erc20Address,
              decimals: DECIMALS,
              symbol: EMOJI,
            },
          });
        }
      }}
    >
      <LabeledOrbInput amount={balance ? balance.value : 0n} label="My Resources" />
    </div>
  );
}

export function InventorySidebar() {
  const { address } = useExternalAccount();
  const matchReward = useCurrentMatchReward();
  const hasSkyKey = useHasSkyKeyExternalWallet();
  const burnerBalance = useBurnerBalance();

  return (
    <div className="flex flex-col bg-ss-bg-1 border-l border-ss-stroke h-screen overflow-y-auto p-8 pt-4 items-stretch w-[420px] shrink-0">
      <CurrentProfile />

      <div className="h-4 shrink-0"></div>

      <SeasonPass account={address} />

      <div className="h-4" />

      {address && (
        <>
          {import.meta.env.DEV && hasSkyKey && (
            <>
              <div className="h-8 shrink-0" />
              <div className="text-red-600 font-bold text-2xl text-center">
                <p>YOU ARE LOGGED IN WITH THE SKYKEY WALLET.</p>
                <p>You are able to create matches without using 🔮</p>
              </div>
            </>
          )}

          {burnerBalance?.danger && (
            <>
              <div className="h-8 shrink-0" />
              <SessionWalletManager />
            </>
          )}
        </>
      )}

      <div className="h-8 shrink-0" />

      <Resources />

      <div className="h-2 shrink-0" />

      <LabeledOrbInput amount={MATCH_COST} label="Match Creation Cost" />

      <div className="h-2 shrink-0" />

      <LabeledOrbInput amount={matchReward} label="Current Match Reward" />

      <div className="h-2 shrink-0" />

      <div className="h-[100%]" />

      <div className="h-6 shrink-0" />

      <div className="flex h-fit justify-around mb-4">
        <a href={DISCORD_URL} target="_blank" rel="noreferrer">
          <IconButton>
            <Discord />
          </IconButton>
        </a>

        <a href={TWITTER_URL} target="_blank" rel="noreferrer">
          <IconButton>
            <Twitter />
          </IconButton>
        </a>

        <a href={HOW_TO_PLAY_URL} target="_blank" rel="noreferrer">
          <IconButton>
            <Tutorial />
          </IconButton>
        </a>
      </div>

      <div className="h-12" />

      <div className="flex gap-x-3 items-center mx-auto">
        <Link className="uppercase text-ss-text-x-light underline" href={"/privacy-policy"}>
          privacy policy
        </Link>

        <div className="w-6 text-center text-ss-text-x-light">|</div>

        <Link className="uppercase text-ss-text-x-light underline" href={"/terms.pdf"}>
          terms of service
        </Link>
      </div>
    </div>
  );
}
