export function calculateOdds(teamBetAmount: bigint, totalBetAmount: bigint): number {
  if (totalBetAmount === 0n || teamBetAmount === 0n) return 0;
  return Number((totalBetAmount * 100n) / teamBetAmount) / 100;
}
