export function calculateRemainingTime(endTimestamp: bigint): string {
  const now = BigInt(Math.floor(Date.now() / 1000));
  let remainingSeconds = endTimestamp - now;

  if (remainingSeconds <= 0n) {
    return "00D 00H 00M";
  }

  const days = remainingSeconds / 86400n;
  remainingSeconds %= 86400n;
  const hours = remainingSeconds / 3600n;
  remainingSeconds %= 3600n;
  const minutes = remainingSeconds / 60n;

  return `${days.toString().padStart(2, "0")}D ${hours.toString().padStart(2, "0")}H ${minutes.toString().padStart(2, "0")}M`;
}
