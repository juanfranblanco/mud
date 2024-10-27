// TODO: move to external exports once we're ready
export type { EntryKitConfig } from "../config";
export type { ConnectedClient, SessionClient } from "../common";
export { EntryKitProvider } from "../EntryKitProvider";
export { useEntryKitConfig } from "../EntryKitConfigProvider";
export { AccountButton } from "../AccountButton";
export { useAccountModal } from "../useAccountModal";
export { usePreparedSessionClient as useSessionClient } from "../usePreparedSessionClient";
export { createWagmiConfig, type CreateWagmiConfigOptions } from "../createWagmiConfig";

// And some additional internal things
export * from "../passkey/passkeyWallet";
export * from "../passkey/passkeyConnector";
export * from "../smart-account/toCoinbaseSmartAccount";
export * from "../smart-account/isCoinbaseSmartAccount";
export * from "../wiresaw";
export * from "../getConnectors";
export * from "../getWallets";