import React, { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import { useMUD } from "@/ui/useMUD";
import { MatchList } from "../../ui/MatchList";
import { useAccount } from "wagmi";
import { ConnectButton } from "@rainbow-me/rainbowkit";
import { toast, Toaster } from "react-hot-toast";

const ResolutionPage: React.FC = () => {
  const { roundId } = useParams<{ roundId: string }>();
  const [selectedMatch, setSelectedMatch] = useState<string>("");
  const { isConnected, address } = useAccount();

  const {
    externalWorldContract,
  } = useMUD();

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
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          <div className="lg:col-span-1">
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
          </div>
        </div>
      </div>
    </div>
  );
};

export default ResolutionPage;
