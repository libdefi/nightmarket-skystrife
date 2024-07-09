import React, { useState } from "react";
import { useAccount } from "wagmi";
import { ConnectButton } from "@rainbow-me/rainbowkit";
import { useMUD } from "@/ui/useMUD";
import { toast, Toaster } from "react-hot-toast";

const isValidAddress = (address: string): boolean => /^0x[a-fA-F0-9]{40}$/.test(address);

const RoundCreate: React.FC = () => {
  const { externalWorldContract } = useMUD();

  const [betPeriod, setBetPeriod] = useState<number>(0);
  const [playerAddresses, setPlayerAddresses] = useState("");
  const [names, setNames] = useState("");
  const [title, setTitle] = useState("");
  const [errorMessage, setErrorMessage] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(false);

  const [playerAddressesArray, setPlayerAddressesArray] = useState<readonly `0x${string}`[]>([]);
  const [namesArray, setNamesArray] = useState<string[]>([]);
  const [teamIds, setTeamIds] = useState<number[]>([]);
  const { isConnected, address } = useAccount();

  const submit = async () => {
    setErrorMessage(null);
    setIsLoading(true);

    try {
      if (!address) {
        throw new Error("Wallet not connected");
      }
      if (!externalWorldContract) {
        throw new Error("Contract not initialized");
      }

      const createRoundPromise = externalWorldContract.write.createRound(
        [BigInt(betPeriod), playerAddressesArray, namesArray.map((name) => name.trim()), teamIds, title.trim()],
        {
          account: address,
        },
      );

      await toast.promise(createRoundPromise, {
        loading: "Creating betting market...",
        success: "Betting market created successfully!",
        error: (err) => `Failed to create betting market: ${err.message}`,
      });
    } catch (error) {
      console.error("Failed to write contract:", error);
      setErrorMessage(error instanceof Error ? error.message : "An unknown error occurred");
    } finally {
      setIsLoading(false);
    }
  };

  const handleAddPlayer = () => {
    if (!isValidAddress(playerAddresses.trim())) {
      return;
    }

    const newTeamIds = [...teamIds];
    const newNamesArray = [...namesArray, names.trim()];

    const teamIdMap = new Map<string, number>();
    newNamesArray.forEach((name, index) => {
      if (!teamIdMap.has(name)) {
        teamIdMap.set(name, teamIdMap.size + 1);
      }
      newTeamIds[index] = teamIdMap.get(name)!;
    });

    setPlayerAddressesArray((prev) => [...prev, `${playerAddresses.trim()}` as `0x${string}`]);
    setNamesArray(newNamesArray);
    setTeamIds(newTeamIds);
    setPlayerAddresses("");
    setNames("");
  };

  const isCreateRoundDisabled =
    playerAddressesArray.length < 2 || betPeriod <= Math.floor(Date.now() / 1000) || title.length > 40;

  const isBetPeriodInPast = betPeriod <= Math.floor(Date.now() / 1000);
  const isTitleTooLong = title.length > 40;

  return (
    <div className="container py-8 bg-gray-900 text-white min-h-screen">
      <Toaster position="bottom-right" />
      <h2 className="text-xl font-bold mb-4">Create a Betting Market</h2>

      <div className="mb-16">
        <label className="block mb-2">
          Title:
          <input
            type="text"
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            className="block w-full mt-1 p-2 bg-gray-800"
          />
          {isTitleTooLong && (
            <p className="text-red-500 mt-2">Title is too long. Please limit it to 40 characters or fewer.</p>
          )}
        </label>
        <label className="block mb-4">
          Bet Period (in seconds):
          <p className="text-sm text-gray-400 mb-2">
            Please use an Epoch timestamp for the bet period. For more information on how to calculate Epoch timestamps,
            refer to
            <a
              href="https://www.epochconverter.com/"
              target="_blank"
              rel="noopener noreferrer"
              className="text-blue-400 hover:underline"
            >
              {" "}
              this guide
            </a>
            .
          </p>
          <input
            type="number"
            value={betPeriod}
            onChange={(e) => setBetPeriod(parseInt(e.target.value) || 0)}
            className="block w-full mt-1 p-2 bg-gray-800"
          />
          {isBetPeriodInPast && (
            <p className="text-red-500 mt-2">Bet Period is in the past. Please select a future time.</p>
          )}
        </label>
      </div>
      <div className="mb-4">
        <label className="block mb-2">
          Player's wallet address:
          <input
            type="text"
            value={playerAddresses}
            onChange={(e) => setPlayerAddresses(e.target.value)}
            className="block w-full mt-1 p-2 bg-gray-800"
          />
        </label>
        <label className="block mb-2">
          Player's Name:
          <p className="text-red-500 text-sm mb-4">
            If you hold 2vs2, use players's team name. Please ensure that the team name matches exactly, including
            capitalization, if registering under the same team.
          </p>
          <input
            type="text"
            value={names}
            onChange={(e) => setNames(e.target.value)}
            className="block w-full mt-1 p-2 bg-gray-800"
          />
        </label>

        <button
          type="button"
          onClick={handleAddPlayer}
          className="mt-2 mb-4 p-2 bg-blue-500 hover:bg-blue-700 transition duration-300"
        >
          Add Player
        </button>
      </div>
      <div>
        <h3 className="font-bold mt-4 mb-4">Players List:</h3>
        {playerAddressesArray.map((address, index) => (
          <div key={index}>
            {address} - {namesArray[index]} - Team ID: {teamIds[index]}
          </div>
        ))}
      </div>

      {errorMessage && <p className="text-red-500">{errorMessage}</p>}

      <div className="my-16">
        {isConnected ? (
          <button
            onClick={submit}
            className={`p-2 bg-green-500 hover:bg-green-700 transition duration-300 w-full rounded-xl h-12 ${isCreateRoundDisabled || isLoading ? "opacity-50 cursor-not-allowed" : ""}`}
            disabled={isCreateRoundDisabled || isLoading}
          >
            {isLoading ? "Creating..." : "Create Market"}
          </button>
        ) : (
          <ConnectButton />
        )}
      </div>
    </div>
  );
};

export default RoundCreate;
