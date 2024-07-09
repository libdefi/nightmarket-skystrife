import { MatchList } from "./_MatchList";
import { useMUD } from "./useMUD";

export const UIRoot = () => {
  const { skystrife, bettingMarket } = useMUD();

  if (!skystrife || !bettingMarket) return <></>;

  return (
    <div>
      <h1>Sky Strife Betting Market</h1>
      <MatchList />
    </div>
  );
};
