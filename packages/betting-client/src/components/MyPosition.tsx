import React from "react";

const MyPosition: React.FC = () => {
  return (
    <div className="bg-gray-800 p-6 rounded ">
      <h2 className="text-xl font-bold mb-4">My Position</h2>
      <table className="w-full text-white">
        <thead>
          <tr className="border-b border-gray-700">
            <th className="py-2 text-left">Outcome</th>
            <th className="py-2 text-left">Bet Amount</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td className="py-2">WASD</td>
            <td className="py-2">0.01 eth ($37)</td>
          </tr>
        </tbody>
      </table>
    </div>
  );
};

export default MyPosition;
