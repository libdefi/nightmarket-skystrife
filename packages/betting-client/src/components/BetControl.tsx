import React, { useState } from "react";
import { ConnectButton } from "@rainbow-me/rainbowkit";
import { useAccount } from "wagmi";
import { useMUD } from "@/ui/useMUD";
import { Entity } from "@latticexyz/recs";
import useEthPrice from "../hooks/useEthPrice";
import { toast, Toaster } from "react-hot-toast";

interface BetControlProps {
  selectedOutcome: string;
  selectedTeamIndex: number;
  roundId: Entity | undefined;
  remainingTime: string;
}

const BetControl: React.FC<BetControlProps> = ({ selectedOutcome, selectedTeamIndex, roundId, remainingTime }) => {
  const [amount, setAmount] = useState(0.001);
  const { isConnected, address } = useAccount();
  const { externalWorldContract } = useMUD();
  const ethPrice = useEthPrice();

  const handleDecrease = () => {
    setAmount((prevAmount) => Math.max(0, prevAmount - 0.001));
  };

  const handleIncrease = () => {
    setAmount((prevAmount) => prevAmount + 0.001);
  };

  const bet = async () => {
    try {
      if (!address || !externalWorldContract || !roundId) {
        console.error("Missing required data for betting");
        toast.error("Missing required data for betting");
        return;
      }

      const amountInWei = BigInt(Math.floor(amount * 1e18));
      const roundIdValue = roundId.toString() as `0x${string}`;
      const selectedTeamValue = selectedTeamIndex;

      console.log("Placing bet with:", {
        roundId: roundIdValue,
        selectedTeam: selectedTeamValue,
        amountInWei: amountInWei.toString(),
        account: address,
      });

      const betPromise = externalWorldContract.write.placeBet([roundIdValue, selectedTeamValue, amountInWei], {
        account: address,
        value: amountInWei,
      });

      await toast.promise(betPromise, {
        loading: "Placing bet...",
        success: "Bet placed successfully!",
        error: "Failed to place bet",
      });

      console.log("Bet placed successfully");
    } catch (error) {
      console.error("Failed to place bet:", error);
      toast.error("Failed to place bet");
    }
  };

  return (
    <div className="bg-gray-800 p-6 rounded">
      <Toaster position="bottom-right" />
      <h2 className="text-xl font-bold mb-4">{selectedOutcome}</h2>
      <div className="mb-4">
        <span>Amount</span>
        <div className="flex items-center w-full mt-2 justify-between">
          <button className="px-4 py-2 bg-gray-700 rounded-l" onClick={handleDecrease}>
            -
          </button>
          <input
            type="text"
            className="py-2 bg-gray-900 text-white text-center flex-grow"
            value={`${amount.toFixed(3)} eth`}
            readOnly
          />
          <button className="px-4 py-2 bg-gray-700 rounded-r" onClick={handleIncrease}>
            +
          </button>
        </div>
      </div>
      <p className="text-right mb-4">${ethPrice !== null ? (amount * ethPrice).toFixed(2) : "Loading..."}</p>
      {isConnected ? (
        <button
          onClick={bet}
          className={`bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded m-1 w-full ${
            remainingTime === "00D 00H 00M" ? "opacity-50 cursor-not-allowed" : ""
          }`}
          disabled={remainingTime === "00D 00H 00M"} // ボタンを無効にする条件
        >
          Bet
        </button>
      ) : (
        <div className="flex justify-center">
          <ConnectButton />
        </div>
      )}
    </div>
  );
};

export default BetControl;
