/**
 * Converts wei to ether
 * @param {string | number | bigint} wei - The amount in wei
 * @returns {string} - The amount in ether as a string
 */
export function weiToEther(wei: string | number | bigint): string {
  const weiBigInt = BigInt(wei);
  const etherBigInt = weiBigInt / 10n ** 18n;
  const etherDecimal = weiBigInt % 10n ** 18n;
  const etherString = etherBigInt.toString() + "." + etherDecimal.toString().padStart(18, "0");

  // Parse to float and round to 3 decimal places
  const etherFloat = parseFloat(etherString);
  const roundedEtherFloat = Math.round(etherFloat * 1000) / 1000;

  return roundedEtherFloat.toString();
}
