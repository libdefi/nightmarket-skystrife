import React, { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import BetControl from "../../components/BetControl";
import BetTable from "../../components/BetTable";
import { useMUD } from "@/ui/useMUD";
import { Has, getComponentValue, Entity } from "@latticexyz/recs";
import { useEntityQuery } from "@latticexyz/react";
import { calculateRemainingTime } from "../../utils/calculateRemainingTime";
import { calculateOdds } from "../../utils/calculateOdds";
import { MatchList } from "../../ui/MatchList";
import { useAccount } from "wagmi";
import { ConnectButton } from "@rainbow-me/rainbowkit";
import { toast, Toaster } from "react-hot-toast";

interface TeamData {
  name: string;
  betAmount: string;
  odds: number;
  id: number;
}

const RoundPage: React.FC = () => {
  const { roundId } = useParams<{ roundId: string }>();
  const [selectedOutcome, setSelectedOutcome] = useState<string>("");
  const [selectedTeamIndex, setSelectedTeamIndex] = useState<number>(0);
  const [selectedMatch, setSelectedMatch] = useState<string>("");
  const { isConnected, address } = useAccount();

  const {
    bettingMarket: {
      components: { Rounds, Teams },
    },
    externalWorldContract,
  } = useMUD();

  const extractNumberFromHex = (hex: string): number => {
    const cleanHex = hex.startsWith("0x") ? hex.slice(2) : hex;
    const last64Chars = cleanHex.slice(-64);
    return Number(BigInt(`0x${last64Chars}`));
  };

  const roundIds = useEntityQuery([Has(Rounds)]);
  const matchingRoundId = roundIds.find((id) => id.toString() === roundId);
  const roundData = matchingRoundId ? getComponentValue(Rounds, matchingRoundId) : null;

  const teams = useEntityQuery([Has(Teams)]);

  const teamRoundIds = matchingRoundId ? teams.filter((team) => team.toString().startsWith(matchingRoundId)) : [];

  const teamData: TeamData[] = teamRoundIds
    .map((id) => {
      const team = getComponentValue(Teams, id);
      if (!team || !roundData) return null;
      const teamBetAmount = team.betAmount;
      const totalBetAmount = roundData.betAmount;
      return {
        name: team.name,
        betAmount: teamBetAmount.toString(),
        odds: calculateOdds(teamBetAmount, totalBetAmount),
        id: extractNumberFromHex(id.toString()),
      };
    })
    .filter((data): data is NonNullable<typeof data> => data !== null);

  useEffect(() => {
    if (teamData.length > 0 && !selectedOutcome) {
      setSelectedOutcome(teamData[0].name);
      setSelectedTeamIndex(teamData[0].id);
    }
  }, [teamData]);

  const title = roundData?.title || "Unknown Round";
  const remainingTime = roundData?.betPeriod ? calculateRemainingTime(roundData.betPeriod) : "00D 00H 00M";

  const handleBetClick = (name: string, id: number) => {
    setSelectedOutcome(name);
    setSelectedTeamIndex(id);
  };

  const handleSelectMatch = (matchEntity: string) => {
    setSelectedMatch(matchEntity);
  };

  const resolution = async () => {
    try {
      if (!address || !externalWorldContract || !roundId) {
        console.error("Missing required data for resolution");
        console.log("address:", address);
        console.log("externalWorldContract:", externalWorldContract);
        console.log("roundId:", roundId);
        toast.error("Missing required data for resolution");
        return;
      }

      const resolutionPromise = externalWorldContract.write.resolution(
        [roundId as `0x${string}`, selectedMatch as `0x${string}`],
        {
          account: address,
        },
      );

      await toast.promise(resolutionPromise, {
        loading: "Resolving...",
        success: "Resolution successful!",
        error: "Failed to resolve",
      });

      console.log("Resolution successful");
    } catch (error) {
      console.error("Failed to resolution:", error);
      toast.error("Failed to resolution");
    }
  };

  return (
    <div className="bg-gray-900 text-white min-h-screen p-8">
      <Toaster position="bottom-right" />
      <div className="container mx-auto">
        <h1 className="text-3xl font-bold mb-4">{title}</h1>
        <p className="mb-8">Time Remaining: {remainingTime}</p>
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          <div className="lg:col-span-2">
            <BetTable onBetClick={handleBetClick} teamData={teamData} remainingTime={remainingTime} />
          </div>
          <div className="lg:col-span-1">
            <BetControl
              selectedOutcome={selectedOutcome}
              selectedTeamIndex={selectedTeamIndex}
              roundId={matchingRoundId}
              remainingTime={remainingTime}
            />
            {remainingTime === "00D 00H 00M" && (
              <div className="mt-8">
                <label htmlFor="matchSelect" className="block text-white mb-2">
                  Select Match:
                </label>
                <MatchList selectedMatch={selectedMatch} onSelectMatch={handleSelectMatch} />
                {isConnected ? (
                  <button
                    onClick={resolution}
                    className="bg-red-500 hover:bg-red-600 text-white font-bold py-2 px-4 rounded m-1 w-full"
                  >
                    Resolution
                  </button>
                ) : (
                  <ConnectButton />
                )}
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default RoundPage;
