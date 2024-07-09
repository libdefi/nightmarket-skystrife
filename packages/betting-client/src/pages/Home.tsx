import React from "react";
import { useNavigate } from "react-router-dom";
import Carousel from "../components/Carousel";
import { useEntityQuery } from "@latticexyz/react";
import { useMUD } from "@/ui/useMUD";
import { Has, getComponentValue } from "@latticexyz/recs";
import { weiToEther } from "../utils/weiToEther";
import { calculateRemainingTime } from "../utils/calculateRemainingTime";

interface TeamData {
  name: string;
  betAmount: bigint;
}

export const Home = () => {
  const navigate = useNavigate();

  const handleCardClick = (id: string) => {
    window.location.href = `/round/${id}`;
  };

  const {
    bettingMarket: {
      components: { Rounds, Teams },
    },
  } = useMUD();

  const roundIds = useEntityQuery([Has(Rounds)]);
  const roundData = roundIds.map((round) => getComponentValue(Rounds, round));
  console.log("@@@roundData=", roundData);

  const teams = useEntityQuery([Has(Teams)]);
  const teamRoundIds: string[] = teams.map((team) => team.substring(0, 66));
  const teamData: TeamData[] = teams.map((team) => getComponentValue(Teams, team) || { name: "", betAmount: 0n });
  console.log("@@@teamData=", teamData);
  return (
    <div className="w-screen min-h-screen bg-gray-900 text-white p-4">
      <Carousel />
      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4 mx-12 mt-8">
        {roundData.map((round, idx) => {
          const roundId = roundIds[idx];
          const remainingTime = round?.betPeriod ? calculateRemainingTime(round.betPeriod) : "00D 00H 00M";
          console.log(`Round ${idx} remainingTime:`, remainingTime);

          const teamIndexes: number[] = teamRoundIds.reduce<number[]>((acc, id, index) => {
            if (id === roundId) {
              acc.push(index);
            }
            return acc;
          }, []);

          const roundTeams = teamIndexes.map((index) => teamData[index]);
          console.log(`Round ${idx} teams:`, roundTeams);

          return (
            <div
              key={idx}
              className="p-4 bg-gray-800 rounded-lg shadow-md cursor-pointer relative"
              onClick={() => handleCardClick(roundId.toString())}
            >
              {round && (
                <>
                  <div className="mb-4">
                    <p className="text-xl">{round.title}</p>
                    <p className="text-sm text-gray-400">
                      RoundCreator:{" "}
                      <a
                        href={`https://explorer.redstone.xyz/address/${round.roundCreator}`}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="text-blue-400 hover:text-blue-500"
                      >
                        {`${round.roundCreator.substring(0, 4)}...${round.roundCreator.substring(round.roundCreator.length - 4)}`}
                      </a>
                    </p>
                  </div>
                  <ul>
                    {roundTeams.map((team, teamIdx) => (
                      <li key={teamIdx} className="flex justify-between mb-2">
                        <span className="text-lg">{team?.name}</span>
                        <span className="text-green-500">{weiToEther(team?.betAmount)} ETH</span>
                      </li>
                    ))}
                  </ul>
                  {remainingTime !== "00D 00H 00M" && round.betPeriod && (
                    <div className="absolute top-4 right-4 bg-red-500 text-black px-2 py-1 rounded-full shadow-lg animate-blink">
                      <span className="font-bold text-white">Ongoing</span>
                    </div>
                  )}
                </>
              )}
            </div>
          );
        })}
      </div>
    </div>
  );
};

export default Home;
