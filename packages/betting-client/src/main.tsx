import "./polyfills";
import "@rainbow-me/rainbowkit/styles.css";
import React from "react";
import ReactDOM from "react-dom/client";
import { createBrowserRouter, RouterProvider } from "react-router-dom";
import { QueryClient } from "@tanstack/react-query";
import { Home } from "./pages/Home";
import MyPage from "./pages/MyPage";
import RoundPage from "./pages/Round/[roundId]";
import ResolutionPage from "./pages/Resolution/[roundId]";
import NotFound from "./pages/NotFound";
// import Test from "./pages/Test";
import RoundCreate from "./pages/RoundCreate";
import Header from "./components/Header";
import Footer from "./components/Footer";
import "./index.css";
import { Providers } from "./Providers";
import { LoadingScreen } from "./ui/LoadingScreen";
import { useStore } from "./useStore";
import { MountSkyStrife } from "./mount/MountSkyStrife";
import { MountBettingMarket } from "./mount/MountBettingMarket";

export const queryClient = new QueryClient();

const MUDSetup = ({ children }: { children: React.ReactNode }) => {
  const skystrife = useStore((state) => state.skystrife);
  const bettingMarket = useStore((state) => state.bettingMarket);

  return (
    <div className="w-screen h-screen relative bg-white">
      <LoadingScreen skystrife={skystrife} bettingMarket={bettingMarket} />

      <Layout>{children}</Layout>

      <MountSkyStrife />
      <MountBettingMarket />
    </div>
  );
};

const Layout = ({ children }: { children: React.ReactNode }) => {
  const { skystrife, bettingMarket } = useStore((state) => {
    return {
      skystrife: state.skystrife,
      bettingMarket: state.bettingMarket,
    };
  });

  if (!skystrife || !bettingMarket) return <></>;

  console.log("@@@bettingMarket=", bettingMarket);

  return (
    <div className="bg-gray-900">
      <Header />
      <main>{children}</main>
      <Footer />
    </div>
  );
};

const router = createBrowserRouter([
  {
    path: "/",
    element: (
      <MUDSetup>
        <Home />
      </MUDSetup>
    ),
  },
  {
    path: "/mypage",
    element: (
      <MUDSetup>
        <MyPage />
      </MUDSetup>
    ),
  },
  {
    path: "/resolution/:roundId",
    element: (
      <MUDSetup>
        <ResolutionPage />
      </MUDSetup>
    ),
  },
  {
    path: "/round/:roundId",
    element: (
      <MUDSetup>
        <RoundPage />
      </MUDSetup>
    ),
  },
  {
    path: "/create",
    element: (
      <MUDSetup>
        <RoundCreate />
      </MUDSetup>
    ),
  },
  // {
  //   path: "/test",
  //   element: (
  //     <Layout>
  //       <Test />
  //     </Layout>
  //   ),
  // },
  {
    path: "*",
    element: (
      <Layout>
        <NotFound />
      </Layout>
    ),
  },
]);

const rootElement = document.getElementById("react-root");
if (!rootElement) throw new Error("React root not found");
const root = ReactDOM.createRoot(rootElement);

root.render(
  <Providers>
    <RouterProvider router={router} />
  </Providers>,
);
