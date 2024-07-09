# NightMarket * SkyStrife
NightMarket is an esports market for fully onchain games.  It aims to enhance the excitement and engagement of SkyStrife gameplay by integrating a betting feature to the game.

![Night-Market-Sky-Strife (2)](https://github.com/libdefi/nightmarket-skystrife/assets/8872443/a50d8212-7115-4467-8028-a4d10425ec33)



## Making Your First Bet

1. **Choose a Market**: Select a market for a specific SkyStrife match.
2. **Pick Your Winner**: Choose the player or team you believe will win.
3. **Place Your Bet**: Enter the amount of ETH you want to bet and click "Bet" to confirm.

Check your bets in the "MyPosition" section.

### Deposit ETH on Redstone Chain

NightMarket is deployed on [Redstone Chain](https://x.com/redstonexyz).

You can bridge ETH from the official Redstone website: https://redstone.xyz/deposit

### Claiming your winnings

1. **Resolve the Market**: After the match, go to the market page and click the red 'Resolve' button to execute the resolution..
2. **Claim Winnings**: If you bet on the winning option, click "Claim" to receive your winnings.

### How does the odds work?

The cash back value for a player is calculated as:

**(Total pool amount) x {(Amount the player bet on the correct choice) / (Total amount bet on the correct choice)}**

*A 0.5% fee applies to all bets

## Creating Your First Market

1. **Click Create Tab**: Fill out the market details, including title, betting period, and players' wallet addresses.
2. **Create Market**: Click "Create Market" to finalize.
3. **Earnings**: Market creators earn 0.5% of all bets made on their markets.

**Notes:**

- The betting period must be in epoch timestamp format. Refer to [this link](https://www.epochconverter.com/) for more information.
- Use players' wallets connected to SkyStrife, not session wallets.

### What if I added wrong information or the match didn’t happen?

Users can withdraw their full bet amount if the market resolution has not been executed and 30 days have passed since the betting deadline.

### How do the fees work?

Market creators earn 0.5% of all bets. This fee is transferred to the creator’s wallet when the market is resolved.

## Resolution method

Execute 2 Arguments from Frontend:

1. **_roundId:** Identifies which market resolution to perform in NightMarket
2. **matchEntity:** Specifies the SkyStrife match for executing the resolution
    
    (A fully on-chain search is computationally expensive and potentially infeasible)


## How to build in local

### foundry

set your env under packages>betting-client
```
VITE_CHAIN_ID=31337
```

terminal1
```
pnpm i
anvil
```

terminal2 (contract deploy)
```
pnpm betting-market:build-contracts
pnpm betting-market:contracts-dev
```

terminal3 (contract deploy)
```
pnpm betting-market:client-build
pnpm betting-market:client-dev
```


### Garnet (Testnet) or Redstone 

The contract has already been deployed and can be used as is.

terminal1
```
pnpm i
anvil
```

terminal2 
```
pnpm betting-market:client-build
pnpm betting-market:client-dev
```


## Contributer
[Core]
Kohei: https://github.com/kohhnagata
LIB: https://github.com/libdefi

[Supporter]
Kooshaba: https://github.com/Kooshaba


## Reference
https://github.com/latticexyz/skystrife-public


