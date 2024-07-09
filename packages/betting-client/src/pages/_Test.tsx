// src/pages/Test.tsx
import React from "react";
import { useStore } from "../useStore";
import { UIRoot } from "../ui/_UIRoot";
import { LoadingScreen } from "../ui/LoadingScreen";
import { MountSkyStrife } from "../mount/MountSkyStrife";
import { MountBettingMarket } from "../mount/MountBettingMarket";

const Test: React.FC = () => {
  const skystrife = useStore((state) => state.skystrife);
  const bettingMarket = useStore((state) => state.bettingMarket);

  return (
    <div className="w-screen h-screen relative bg-white">
      <LoadingScreen skystrife={skystrife} bettingMarket={bettingMarket} />

      <UIRoot />

      <MountSkyStrife />
      <MountBettingMarket />
    </div>
  );
};

export default Test;
