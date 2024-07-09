import React from "react";
import { useEntityQuery } from "@latticexyz/react";
import { useMUD } from "@/ui/useMUD";
import { Has, getComponentValue } from "@latticexyz/recs";
import { useAccount } from "wagmi";
import { weiToEther } from "../utils/weiToEther";
import { ConnectButton } from "@rainbow-me/rainbowkit";
import { toast, Toaster } from "react-hot-toast";

const MyPage: React.FC = () => {
  const {
    bettingMarket: {
      components: { Bets },
    },
    externalWorldContract,
  } = useMUD();
  const { isConnected, address } = useAccount();
  const betsIds = useEntityQuery([Has(Bets)]);

  if (!address || !isConnected) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <ConnectButton />
      </div>
    );
  }

  // Delete '0x' and convert to lower case
  const targetAddress = address.slice(2).toLowerCase();
  // Filtering betsIds
  const filteredBetIds = betsIds.filter((betId) => betId.toLowerCase().endsWith(targetAddress));
  const betData = filteredBetIds
    .map((bet) => getComponentValue(Bets, bet))
    .filter((bet): bet is NonNullable<typeof bet> => bet !== undefined);

  const claim = async (roundId: `0x${string}`, teamId: number) => {
    try {
      if (!address || !externalWorldContract || !roundId || !teamId) {
        console.error("Missing required data for claim");
        console.log("address:", address);
        console.log("externalWorldContract:", externalWorldContract);
        console.log("roundId:", roundId);
        console.log("teamId:", teamId);
        toast.error("Missing required data for claim");
        return;
      }

      const claimPromise = externalWorldContract.write.winnerWithdraw([roundId, teamId], {
        account: address,
      });

      await toast.promise(claimPromise, {
        loading: "Claiming winnings...",
        success: "Winnings claimed successfully!",
        error: (err) => `Failed to claim winnings: ${err.message}`,
      });

      console.log("Winnings claimed successfully");
    } catch (error) {
      console.error("Failed to claim winnings:", error);
      toast.error("Failed to claim winnings");
    }
  };

  console.log("@@@filteredBetIds=", filteredBetIds);

  return (
    <div className="container py-8 bg-gray-900 text-white min-h-screen">
      <Toaster position="bottom-right" />
      <h1 className="text-2xl font-bold mb-6">My Page</h1>
      <div className="grid grid-cols-3 gap-4 mb-2 px-6">
        <div className="font-semibold">Market</div>
        <div className="font-semibold">Position</div>
        <div className="font-semibold">Bet Amount</div>
      </div>
      {betData.map((bet, index) => {
        const betId = filteredBetIds[index];
        const roundId = `0x${betId.slice(2, 66)}` as `0x${string}`;
        const teamId = parseInt(betId.slice(66, 130), 16);
        console.log("roundId:", roundId);
        console.log("teamId:", teamId);
        return (
          <div
            key={index}
            className="flex justify-between items-center bg-gray-800 p-4 rounded shadow-md mb-4 border border-gray-600"
          >
            <div className="flex flex-col flex-1">
              <span className="font-medium">{bet.roundTitle}</span>
            </div>
            <div className="flex-1 text-left font-semibold">{bet.teamName}</div>
            <div className="flex-1 text-left font-semibold">
              <span>{weiToEther(bet.amount)} ETH </span>
            </div>
            <div className="ml-4">
              <button
                onClick={() => claim(roundId, teamId)}
                className={`px-4 py-2 border rounded ${
                  bet.winnerAmount > 0
                    ? "border-green-500 text-green-500 hover:bg-green-100"
                    : "border-gray-500 text-gray-500 hover:bg-gray-100"
                }`}
              >
                Claim
              </button>
            </div>
          </div>
        );
      })}
    </div>
  );
};

export default MyPage;
