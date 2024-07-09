import { useState, useEffect, useMemo } from "react";
import { Has, HasValue, Not, getComponentValue, runQuery } from "@latticexyz/recs";
import { useEntityQuery } from "@latticexyz/react";
import { useMUD } from "./useMUD";
import { DateTime } from "luxon";
import { Entity } from "@latticexyz/recs";

interface MatchListProps {
  selectedMatch: string;
  onSelectMatch: (matchEntity: string) => void;
}

export function MatchList({ selectedMatch, onSelectMatch }: MatchListProps) {
  const {
    components: { MatchConfig, MatchFinished, MatchJoinable, MatchReady, MatchName },
    utils: { getLevelSpawns },
  } = useMUD().skystrife.networkLayer;

  const [historicalMatchesUpdate, setHistoricalMatchesUpdate] = useState(0);
  const [historicalMatches, setHistoricalMatches] = useState<Entity[]>([]);

  useEffect(() => {
    setHistoricalMatches([...runQuery([Has(MatchConfig), Has(MatchFinished)])]);
  }, [historicalMatchesUpdate]);

  useEffect(() => {
    const interval = setInterval(() => {
      setHistoricalMatchesUpdate((prev) => prev + 1);
    }, 5_000);
    return () => clearInterval(interval);
  }, []);

  historicalMatches.sort((a, b) => {
    const aTime = getComponentValue(MatchConfig, a)?.startTime ?? 0n;
    const bTime = getComponentValue(MatchConfig, b)?.startTime ?? 0n;
    return Number(bTime - aTime);
  });

  console.log("@@@selectedMatch=", selectedMatch);

  return (
    <div className="mb-4">
      <select
        id="matchSelect"
        className="bg-gray-800 text-white p-2 rounded w-full"
        value={selectedMatch}
        onChange={(e) => onSelectMatch(e.target.value)}
      >
        {historicalMatches.map((matchEntity) => {
          const matchName = getComponentValue(MatchName, matchEntity as Entity)?.value ?? "Unnamed Match";
          return (
            <option key={matchEntity} value={matchEntity}>
              {matchName}
            </option>
          );
        })}
      </select>
      <div className="mt-2 text-sm text-gray-500">Sum: {historicalMatches.length}</div>
    </div>
  );
}
