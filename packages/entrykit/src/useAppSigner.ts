import { useStore } from "zustand";
import { store } from "./store";
import { Address } from "viem/accounts";
import { getAppSigner } from "./getSessionSigner";
import { useMemo } from "react";

export function useAppSigner(userAddress: Address) {
  const state = useStore(store, (state) => state.appSigners[userAddress]);
  return useMemo(() => {
    // trigger hook to reevaluate when underlying app signers change
    state;
    return getAppSigner(userAddress);
  }, [userAddress, state]);
}
