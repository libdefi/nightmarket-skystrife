import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import path from "path";
import dotenv from "dotenv";

// .env ファイルを読み込む
dotenv.config();

export default defineConfig({
  plugins: [react()],
  root: "src",
  server: {
    port: 3000,
    fs: {
      strict: false,
    },
  },
  preview: {
    port: 3000,
  },
  build: {
    outDir: "../dist",
    emptyOutDir: true,
    sourcemap: false,
    assetsInlineLimit: 0,
    target: "es2022",
    commonjsOptions: {
      transformMixedEsModules: true,
    },
    rollupOptions: {
      external: ["@safe-globalThis/safe-apps-provider", "@safe-globalThis/safe-apps-sdk"],
      output: {
        manualChunks: {
          react: ["react", "react-dom"],
          phaser: ["phaser"],
          mud: [
            "@latticexyz/common",
            "@latticexyz/dev-tools",
            "@latticexyz/react",
            "@latticexyz/recs",
            "@latticexyz/schema-type",
            "@latticexyz/store-sync",
            "@latticexyz/utils",
            "@latticexyz/world",
          ],
        },
      },
    },
  },
  define: {
    global: "globalThis",
    "import.meta.env": {
      VITE_CHAIN_ID: JSON.stringify(process.env.VITE_CHAIN_ID),
      VITE_COINPAPRIKA_API_KEY: JSON.stringify(process.env.VITE_COINPAPRIKA_API_KEY),
    },
  },
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
});
