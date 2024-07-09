import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { ConnectButton } from "@rainbow-me/rainbowkit";
import { useAccount } from "wagmi";

const Header: React.FC = () => {
  const { isConnected } = useAccount();
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const navigate = useNavigate();

  const toggleMenu = () => {
    setIsMenuOpen(!isMenuOpen);
  };

  const handleNavigation = (path: string) => {
    navigate(path);
  };

  return (
    <header className="bg-gray-900 shadow-md">
      <div className="container mx-auto flex justify-between items-center py-4 px-6">
        <div className="flex items-center">
          <button onClick={() => handleNavigation("/")} className="flex items-center space-x-2 focus:outline-none">
            <img src="/svg/titleLogo.svg" alt="Logo" className="w-44 h-auto" />
            <span className="text-white text-2xl font-bold">×</span>
            <img src="/skystrife-logo.png" alt="Logo" className="w-32 h-auto" />
          </button>
        </div>
        <div className="block lg:hidden">
          <button onClick={toggleMenu} className="text-white focus:outline-none">
            <svg
              className="w-6 h-6"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M4 6h16M4 12h16m0 6h16"></path>
            </svg>
          </button>
        </div>
        <nav
          className={`${
            isMenuOpen ? "block" : "hidden"
          } lg:flex flex-col lg:flex-row lg:items-center space-y-2 lg:space-y-0 lg:space-x-6 absolute lg:static bg-gray-900 lg:bg-transparent w-full lg:w-auto left-0 top-16 lg:top-auto z-50 lg:z-auto p-4 lg:p-0`}
        >
          <a
            href="https://kohei-eth.notion.site/WIP-Wiki-NightMarket-x-SkyStrife-690058bca5c34079bb48fd934e1222d5?pvs=4/"
            target="_blank"
            rel="noopener noreferrer"
            className="text-white hover:text-gray-400"
          >
            Docs
          </a>
          <a
            href="https://skystrife.xyz/"
            target="_blank"
            rel="noopener noreferrer"
            className="text-white hover:text-gray-400"
          >
            Play SkyStrife
          </a>
          <button onClick={() => handleNavigation("/create")} className="text-white hover:text-gray-400">
            Create
          </button>
          {isConnected && (
            <button onClick={() => handleNavigation("/mypage")} className="text-white hover:text-gray-400">
              MyPosition
            </button>
          )}
          <ConnectButton />
        </nav>
      </div>
    </header>
  );
};

export default Header;
