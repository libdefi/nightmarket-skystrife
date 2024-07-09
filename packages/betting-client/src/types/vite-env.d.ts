interface ImportMetaEnv {
  readonly VITE_CHAIN_ID: string;
  readonly VITE_COINPAPRIKA_API_KEY: string;
}

interface ImportMeta {
  readonly env: ImportMetaEnv;
}
