# Betting Market Client

This mounts two instances of MUD. One is connected to Sky Strife, the other is connected to the Betting Market.

High level walkthrough:

- `mud` directory contains all generic MUD setup. If you want to add client components, do that here. Otherwise you shouldn't have to edit this.
- `UIRoot.tsx` is where you can add all new UI components you create.
- `LoadingScreen.tsx` makes sure both the Sky Strife and Betting Market instance are up to date before displaying the client.
- `index.tsx` is the main entry point for the client. It mounts the `UIRoot` and `LoadingScreen`.
