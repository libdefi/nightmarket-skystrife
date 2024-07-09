import React from "react";
import { weiToEther } from "../utils/weiToEther";

interface TeamData {
  name: string;
  betAmount: string;
  odds: number;
  id: number;
}

interface BetTableProps {
  onBetClick: (name: string, id: number) => void;
  teamData: TeamData[];
  remainingTime: string; // 新しいプロップを追加
}

const BetTable: React.FC<BetTableProps> = ({ onBetClick, teamData, remainingTime }) => {
  return (
    <table className="w-full mb-8 text-white">
      <thead>
        <tr className="border-b border-gray-700">
          <th className="py-2 text-left">Team</th>
          <th className="py-2 text-left">Total Bet</th>
          <th className="py-2 text-left">Odds</th>
          <th className="py-2 text-left"></th>
        </tr>
      </thead>
      <tbody>
        {teamData.map((team, index) => (
          <tr key={index} className="border-b border-gray-800">
            <td className="py-2">{team.name}</td>
            <td className="py-2">{parseFloat(weiToEther(team.betAmount))} ETH</td>
            <td className="py-2">{team.odds.toFixed(2)}x</td>
            <td className="py-2">
              <button
                className={`px-4 py-2 rounded text-white ${
                  remainingTime === "00D 00H 00M" ? "bg-gray-600 cursor-not-allowed" : "bg-blue-600 hover:bg-blue-700"
                }`}
                onClick={() => onBetClick(team.name, team.id)}
                disabled={remainingTime === "00D 00H 00M"} // ボタンを無効にする条件
              >
                Bet
              </button>
            </td>
          </tr>
        ))}
      </tbody>
    </table>
  );
};

export default BetTable;
