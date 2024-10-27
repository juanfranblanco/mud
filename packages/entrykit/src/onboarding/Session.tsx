import { useSessionClient } from "../useSessionClient";
import { Button } from "../ui/Button";
import { useSetupSession } from "./useSetupSession";
import { useAccountModal } from "../useAccountModal";
import { ConnectedClient } from "../common";

export type Props = {
  isActive: boolean;
  isExpanded: boolean;
  userClient: ConnectedClient;
  registerSpender: boolean;
  registerDelegation: boolean;
};

export function Session({ isActive, isExpanded, userClient, registerSpender, registerDelegation }: Props) {
  const { closeAccountModal } = useAccountModal();
  const sessionClient = useSessionClient(userClient.account.address);
  const setup = useSetupSession();

  const isReady = !registerDelegation && !registerDelegation;

  return (
    <div className="flex flex-col gap-4">
      <div className="flex justify-between gap-4">
        <div>
          <div>Session</div>
          <div className="font-mono text-white">{isReady ? "Enabled" : "Set up"}</div>
        </div>
        {isReady ? (
          <Button variant={isActive ? "primary" : "secondary"} className="flex-shrink-0 text-sm p-1 w-28" disabled>
            {/* TODO: revoke */}
            Disable
          </Button>
        ) : (
          <Button
            variant={isActive ? "primary" : "secondary"}
            className="flex-shrink-0 text-sm p-1 w-28"
            pending={!sessionClient.data || setup.status === "pending"}
            onClick={
              sessionClient.data
                ? async () => {
                    await setup.mutateAsync({
                      userClient,
                      sessionAddress: sessionClient.data.account.address,
                      registerSpender,
                      registerDelegation,
                    });
                    closeAccountModal();
                  }
                : undefined
            }
          >
            Enable
          </Button>
        )}
      </div>
      {isExpanded ? (
        <p className="text-sm">You can perform actions in this app without interruptions for approvals.</p>
      ) : null}
    </div>
  );
}
