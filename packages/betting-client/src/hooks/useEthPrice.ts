import { useState, useEffect } from "react";

const useEthPrice = () => {
  const [ethPrice, setEthPrice] = useState<number | null>(null);

  useEffect(() => {
    const fetchEthPrice = async () => {
      try {
        const response = await fetch("https://api.coinpaprika.com/v1/tickers/eth-ethereum");

        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }

        const data = await response.json();
        setEthPrice(data.quotes.USD.price);
      } catch (error) {
        console.error("Failed to fetch ETH price:", error);
      }
    };

    fetchEthPrice();
  }, []);

  return ethPrice;
};

export default useEthPrice;
