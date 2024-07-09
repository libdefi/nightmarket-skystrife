import React from "react";

const Footer: React.FC = () => {
  return (
    <footer className="bg-gray-800 text-white py-4">
      <div className="container mx-auto flex justify-between items-center">
        <div className="flex space-x-4">
          <a
            href="https://github.com/libdefi/skystrife"
            target="_blank"
            rel="noopener noreferrer"
            className="hover:text-gray-400"
          >
            <img src="/icons/github.svg" alt="GitHub" className="w-6 h-6 bg-white rounded-full p-1" />
          </a>
          <a
            href="https://x.com/0xNightMarket"
            target="_blank"
            rel="noopener noreferrer"
            className="hover:text-gray-400"
          >
            <img src="/icons/x.png" alt="Twitter" className="w-6 h-6 bg-white rounded-full p-1" />
          </a>
        </div>
        <p className="text-sm">© 2024 NightMarket. All rights reserved.</p>
      </div>
    </footer>
  );
};

export default Footer;
