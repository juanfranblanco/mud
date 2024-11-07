// Forked from https://github.com/wevm/viem/blob/main/src/account-abstraction/accounts/implementations/toCoinbaseSmartAccount.ts
// to match our forked contracts (upgrade to v0.7 entrypoint)
import {
  Client,
  OneOf,
  LocalAccount,
  Prettify,
  Assign,
  pad,
  encodeFunctionData,
  hashMessage,
  TypedDataDefinition,
  hashTypedData,
  Hash,
  encodeAbiParameters,
  stringToHex,
  size,
  encodePacked,
  parseSignature,
  Address,
  TypedData,
  BaseError,
} from "viem";
import {
  WebAuthnAccount,
  SmartAccount,
  SmartAccountImplementation,
  entryPoint07Abi,
  entryPoint07Address,
  getUserOperationHash,
  UserOperation,
  toSmartAccount,
} from "viem/account-abstraction";
import { readContract } from "viem/actions";
import { type WebAuthnData, parseSignature as parseP256Signature, Hex } from "webauthn-p256";

export type ToCoinbaseSmartAccountParameters = {
  address?: Address | undefined;
  client: Client;
  owners: readonly OneOf<LocalAccount | WebAuthnAccount>[];
  nonce?: bigint | undefined;
  signer?: OneOf<LocalAccount | WebAuthnAccount>;
};

export type ToCoinbaseSmartAccountReturnType = Prettify<SmartAccount<CoinbaseSmartAccountImplementation>>;

export type CoinbaseSmartAccountImplementation = Assign<
  SmartAccountImplementation<
    typeof entryPoint07Abi,
    "0.7",
    {
      __isCoinbaseSmartAccount: true;
      abi: typeof abi;
      factory: { abi: typeof factoryAbi; address: Address };
      signer: OneOf<LocalAccount | WebAuthnAccount>;
    }
  >,
  {
    sign: NonNullable<SmartAccountImplementation["sign"]>;
    // TODO: should this be inside `extend` of `SmartAccountImplementation`?
    isOwner: (account: LocalAccount | WebAuthnAccount) => Promise<boolean>;
  }
>;

/**
 * @description Create a Coinbase Smart Account.
 *
 * @param parameters - {@link ToCoinbaseSmartAccountParameters}
 * @returns Coinbase Smart Account. {@link ToCoinbaseSmartAccountReturnType}
 *
 * @example
 * import { toCoinbaseSmartAccount } from 'viem/account-abstraction'
 * import { privateKeyToAccount } from 'viem/accounts'
 * import { client } from './client.js'
 *
 * const account = toCoinbaseSmartAccount({
 *   client,
 *   owners: [privateKeyToAccount('0x...')],
 * })
 */
export async function toCoinbaseSmartAccount(
  parameters: ToCoinbaseSmartAccountParameters,
): Promise<ToCoinbaseSmartAccountReturnType> {
  const { client, owners, nonce = 0n } = parameters;

  let address = parameters.address;

  const entryPoint = {
    abi: entryPoint07Abi,
    address: entryPoint07Address,
    version: "0.7",
  } as const;
  const factory = {
    abi: factoryAbi,
    // TODO: make configurable?
    address: "0x356336adA1619BeC1Ae4E6D94Dd9c0490DA414a8",
  } as const;

  if (!owners.length) {
    throw new Error("`owners` must have at least one account.");
  }

  function accountToBytes(account: LocalAccount | WebAuthnAccount) {
    return account.type === "webAuthn" ? account.publicKey : pad(account.address);
  }

  const owner = parameters.signer ?? owners[0];
  const ownerIndex = owners.indexOf(owner);
  if (ownerIndex === -1) {
    throw new Error("`signer` must be one of `owners`.");
  }

  let counter = 0n;

  return toSmartAccount({
    client,
    entryPoint,

    extend: {
      __isCoinbaseSmartAccount: true as const,
      abi,
      factory,
      signer: owner,
    },

    async encodeCalls(calls) {
      if (calls.length === 1)
        return encodeFunctionData({
          abi,
          functionName: "execute",
          args: [calls[0].to, calls[0].value ?? 0n, calls[0].data ?? "0x"],
        });
      return encodeFunctionData({
        abi,
        functionName: "executeBatch",
        args: [
          calls.map((call) => ({
            data: call.data ?? "0x",
            target: call.to,
            value: call.value ?? 0n,
          })),
        ],
      });
    },

    async getAddress() {
      address ??= await readContract(client, {
        ...factory,
        functionName: "getAddress",
        args: [owners.map(accountToBytes), nonce],
      });
      return address;
    },

    async getNonce() {
      // allows for 256 nonces per ms
      const counterBits = 8n;
      counter = (counter + 1n) % (1n << counterBits);

      const timestamp = BigInt(Date.now());
      const nonce = ((timestamp << counterBits) + counter) << 64n;

      return nonce;
    },

    async getFactoryArgs() {
      const factoryData = encodeFunctionData({
        abi: factory.abi,
        functionName: "createAccount",
        args: [owners.map(accountToBytes), nonce],
      });
      return { factory: factory.address, factoryData };
    },

    async getStubSignature() {
      if (owner.type === "webAuthn")
        // eslint-disable-next-line max-len
        return "0x0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000c0000000000000000000000000000000000000000000000000000000000000012000000000000000000000000000000000000000000000000000000000000000170000000000000000000000000000000000000000000000000000000000000001949fc7c88032b9fcb5f6efc7a7b8c63668eae9871b765e23123bb473ff57aa831a7c0d9276168ebcc29f2875a0239cffdf2a9cd1c2007c5c77c071db9264df1d000000000000000000000000000000000000000000000000000000000000002549960de5880e8c687434170f6476605b8fe4aeb9a28632c7995cf3ba831d97630500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008a7b2274797065223a22776562617574686e2e676574222c226368616c6c656e6765223a2273496a396e6164474850596759334b7156384f7a4a666c726275504b474f716d59576f4d57516869467773222c226f726967696e223a2268747470733a2f2f7369676e2e636f696e626173652e636f6d222c2263726f73734f726967696e223a66616c73657d00000000000000000000000000000000000000000000";
      return wrapSignature({
        signature:
          "0xfffffffffffffffffffffffffffffff0000000000000000000000000000000007aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa1c",
        ownerIndex,
      });
    },

    async sign(parameters) {
      const address = await this.getAddress();

      const hash = toReplaySafeHash({
        address,
        chainId: client.chain!.id,
        hash: parameters.hash,
      });

      const signature = await sign({ hash, owner });

      return wrapSignature({ signature, ownerIndex });
    },

    async signMessage(parameters) {
      const { message } = parameters;
      const address = await this.getAddress();

      const hash = toReplaySafeHash({
        address,
        chainId: client.chain!.id,
        hash: hashMessage(message),
      });

      const signature = await sign({ hash, owner });

      return wrapSignature({ signature, ownerIndex });
    },

    async signTypedData(parameters) {
      const { domain, types, primaryType, message } = parameters as TypedDataDefinition<TypedData, string>;
      const address = await this.getAddress();

      const hash = toReplaySafeHash({
        address,
        chainId: client.chain!.id,
        hash: hashTypedData({
          domain,
          message,
          primaryType,
          types,
        }),
      });

      const signature = await sign({ hash, owner });

      return wrapSignature({ signature, ownerIndex });
    },

    async signUserOperation(parameters) {
      const { chainId = client.chain!.id, ...userOperation } = parameters;

      const address = await this.getAddress();
      const hash = getUserOperationHash({
        chainId,
        entryPointAddress: entryPoint.address,
        entryPointVersion: entryPoint.version,
        userOperation: {
          ...(userOperation as unknown as UserOperation),
          sender: address,
        },
      });

      const signature = await sign({ hash, owner });

      return wrapSignature({ signature, ownerIndex });
    },

    userOperation: {
      async estimateGas(userOperation) {
        if (owner.type !== "webAuthn") return;

        // Accounts with WebAuthn owner require a minimum verification gas limit of 800,000.
        return {
          verificationGasLimit: BigInt(Math.max(Number(userOperation.verificationGasLimit ?? 0n), 800_000)),
        };
      },
    },

    async isOwner(account: LocalAccount | WebAuthnAccount) {
      return await readContract(client, {
        abi,
        address: await this.getAddress(),
        functionName: "isOwnerBytes",
        args: [accountToBytes(account)],
      });
    },
  });
}

/////////////////////////////////////////////////////////////////////////////////////////////
// Utilities
/////////////////////////////////////////////////////////////////////////////////////////////

/** @internal */
export async function sign({ hash, owner }: { hash: Hash; owner: OneOf<LocalAccount | WebAuthnAccount> }) {
  // WebAuthn Account (Passkey)
  if (owner.type === "webAuthn") {
    const { signature, webauthn } = await owner.sign({
      hash,
    });
    return toWebAuthnSignature({ signature, webauthn });
  }

  if (owner.sign) return owner.sign({ hash });

  throw new BaseError("`owner` does not support raw sign.");
}

/** @internal */
export function toReplaySafeHash({ address, chainId, hash }: { address: Address; chainId: number; hash: Hash }) {
  return hashTypedData({
    domain: {
      chainId,
      name: "Coinbase Smart Wallet",
      verifyingContract: address,
      version: "1",
    },
    types: {
      CoinbaseSmartWalletMessage: [
        {
          name: "hash",
          type: "bytes32",
        },
      ],
    },
    primaryType: "CoinbaseSmartWalletMessage",
    message: {
      hash,
    },
  });
}

/** @internal */
export function toWebAuthnSignature({ webauthn, signature }: { webauthn: WebAuthnData; signature: Hex }) {
  const { r, s } = parseP256Signature(signature);
  return encodeAbiParameters(
    [
      {
        components: [
          {
            name: "authenticatorData",
            type: "bytes",
          },
          { name: "clientDataJSON", type: "bytes" },
          { name: "challengeIndex", type: "uint256" },
          { name: "typeIndex", type: "uint256" },
          {
            name: "r",
            type: "uint256",
          },
          {
            name: "s",
            type: "uint256",
          },
        ],
        type: "tuple",
      },
    ],
    [
      {
        authenticatorData: webauthn.authenticatorData,
        clientDataJSON: stringToHex(webauthn.clientDataJSON),
        challengeIndex: BigInt(webauthn.challengeIndex),
        typeIndex: BigInt(webauthn.typeIndex),
        r,
        s,
      },
    ],
  );
}

/** @internal */
export function wrapSignature(parameters: { ownerIndex: number; signature: Hex }) {
  const { ownerIndex } = parameters;
  const signatureData = (() => {
    if (size(parameters.signature) !== 65) return parameters.signature;
    const signature = parseSignature(parameters.signature);
    return encodePacked(["bytes32", "bytes32", "uint8"], [signature.r, signature.s, signature.yParity === 0 ? 27 : 28]);
  })();
  return encodeAbiParameters(
    [
      {
        components: [
          {
            name: "ownerIndex",
            type: "uint8",
          },
          {
            name: "signatureData",
            type: "bytes",
          },
        ],
        type: "tuple",
      },
    ],
    [
      {
        ownerIndex,
        signatureData,
      },
    ],
  );
}

/////////////////////////////////////////////////////////////////////////////////////////////
// Constants
/////////////////////////////////////////////////////////////////////////////////////////////

export const abi = [
  { inputs: [], stateMutability: "nonpayable", type: "constructor" },
  {
    inputs: [{ name: "owner", type: "bytes" }],
    name: "AlreadyOwner",
    type: "error",
  },
  { inputs: [], name: "Initialized", type: "error" },
  {
    inputs: [{ name: "owner", type: "bytes" }],
    name: "InvalidEthereumAddressOwner",
    type: "error",
  },
  {
    inputs: [{ name: "key", type: "uint256" }],
    name: "InvalidNonceKey",
    type: "error",
  },
  {
    inputs: [{ name: "owner", type: "bytes" }],
    name: "InvalidOwnerBytesLength",
    type: "error",
  },
  { inputs: [], name: "LastOwner", type: "error" },
  {
    inputs: [{ name: "index", type: "uint256" }],
    name: "NoOwnerAtIndex",
    type: "error",
  },
  {
    inputs: [{ name: "ownersRemaining", type: "uint256" }],
    name: "NotLastOwner",
    type: "error",
  },
  {
    inputs: [{ name: "selector", type: "bytes4" }],
    name: "SelectorNotAllowed",
    type: "error",
  },
  { inputs: [], name: "Unauthorized", type: "error" },
  { inputs: [], name: "UnauthorizedCallContext", type: "error" },
  { inputs: [], name: "UpgradeFailed", type: "error" },
  {
    inputs: [
      { name: "index", type: "uint256" },
      { name: "expectedOwner", type: "bytes" },
      { name: "actualOwner", type: "bytes" },
    ],
    name: "WrongOwnerAtIndex",
    type: "error",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,

        name: "index",
        type: "uint256",
      },
      { indexed: false, name: "owner", type: "bytes" },
    ],
    name: "AddOwner",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,

        name: "index",
        type: "uint256",
      },
      { indexed: false, name: "owner", type: "bytes" },
    ],
    name: "RemoveOwner",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,

        name: "implementation",
        type: "address",
      },
    ],
    name: "Upgraded",
    type: "event",
  },
  { stateMutability: "payable", type: "fallback" },
  {
    inputs: [],
    name: "REPLAYABLE_NONCE_KEY",
    outputs: [{ name: "", type: "uint256" }],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [{ name: "owner", type: "address" }],
    name: "addOwnerAddress",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      { name: "x", type: "bytes32" },
      { name: "y", type: "bytes32" },
    ],
    name: "addOwnerPublicKey",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [{ name: "functionSelector", type: "bytes4" }],
    name: "canSkipChainIdValidation",
    outputs: [{ name: "", type: "bool" }],
    stateMutability: "pure",
    type: "function",
  },
  {
    inputs: [],
    name: "domainSeparator",
    outputs: [{ name: "", type: "bytes32" }],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "eip712Domain",
    outputs: [
      { name: "fields", type: "bytes1" },
      { name: "name", type: "string" },
      { name: "version", type: "string" },
      { name: "chainId", type: "uint256" },
      { name: "verifyingContract", type: "address" },
      { name: "salt", type: "bytes32" },
      { name: "extensions", type: "uint256[]" },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "entryPoint",
    outputs: [{ name: "", type: "address" }],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      { name: "target", type: "address" },
      { name: "value", type: "uint256" },
      { name: "data", type: "bytes" },
    ],
    name: "execute",
    outputs: [],
    stateMutability: "payable",
    type: "function",
  },
  {
    inputs: [
      {
        components: [
          { name: "target", type: "address" },
          { name: "value", type: "uint256" },
          { name: "data", type: "bytes" },
        ],

        name: "calls",
        type: "tuple[]",
      },
    ],
    name: "executeBatch",
    outputs: [],
    stateMutability: "payable",
    type: "function",
  },
  {
    inputs: [{ name: "calls", type: "bytes[]" }],
    name: "executeWithoutChainIdValidation",
    outputs: [],
    stateMutability: "payable",
    type: "function",
  },
  {
    inputs: [
      {
        components: [
          { name: "sender", type: "address" },
          { name: "nonce", type: "uint256" },
          { name: "initCode", type: "bytes" },
          { name: "callData", type: "bytes" },
          { name: "callGasLimit", type: "uint256" },
          {
            name: "verificationGasLimit",
            type: "uint256",
          },
          {
            name: "preVerificationGas",
            type: "uint256",
          },
          { name: "maxFeePerGas", type: "uint256" },
          {
            name: "maxPriorityFeePerGas",
            type: "uint256",
          },
          { name: "paymasterAndData", type: "bytes" },
          { name: "signature", type: "bytes" },
        ],

        name: "userOp",
        type: "tuple",
      },
    ],
    name: "getUserOpHashWithoutChainId",
    outputs: [{ name: "", type: "bytes32" }],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "implementation",
    outputs: [{ name: "$", type: "address" }],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [{ name: "owners", type: "bytes[]" }],
    name: "initialize",
    outputs: [],
    stateMutability: "payable",
    type: "function",
  },
  {
    inputs: [{ name: "account", type: "address" }],
    name: "isOwnerAddress",
    outputs: [{ name: "", type: "bool" }],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [{ name: "account", type: "bytes" }],
    name: "isOwnerBytes",
    outputs: [{ name: "", type: "bool" }],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      { name: "x", type: "bytes32" },
      { name: "y", type: "bytes32" },
    ],
    name: "isOwnerPublicKey",
    outputs: [{ name: "", type: "bool" }],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      { name: "hash", type: "bytes32" },
      { name: "signature", type: "bytes" },
    ],
    name: "isValidSignature",
    outputs: [{ name: "result", type: "bytes4" }],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "nextOwnerIndex",
    outputs: [{ name: "", type: "uint256" }],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [{ name: "index", type: "uint256" }],
    name: "ownerAtIndex",
    outputs: [{ name: "", type: "bytes" }],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "ownerCount",
    outputs: [{ name: "", type: "uint256" }],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "proxiableUUID",
    outputs: [{ name: "", type: "bytes32" }],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      { name: "index", type: "uint256" },
      { name: "owner", type: "bytes" },
    ],
    name: "removeLastOwner",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      { name: "index", type: "uint256" },
      { name: "owner", type: "bytes" },
    ],
    name: "removeOwnerAtIndex",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "removedOwnersCount",
    outputs: [{ name: "", type: "uint256" }],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [{ name: "hash", type: "bytes32" }],
    name: "replaySafeHash",
    outputs: [{ name: "", type: "bytes32" }],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      { name: "newImplementation", type: "address" },
      { name: "data", type: "bytes" },
    ],
    name: "upgradeToAndCall",
    outputs: [],
    stateMutability: "payable",
    type: "function",
  },
  {
    inputs: [
      {
        components: [
          { name: "sender", type: "address" },
          { name: "nonce", type: "uint256" },
          { name: "initCode", type: "bytes" },
          { name: "callData", type: "bytes" },
          { name: "callGasLimit", type: "uint256" },
          {
            name: "verificationGasLimit",
            type: "uint256",
          },
          {
            name: "preVerificationGas",
            type: "uint256",
          },
          { name: "maxFeePerGas", type: "uint256" },
          {
            name: "maxPriorityFeePerGas",
            type: "uint256",
          },
          { name: "paymasterAndData", type: "bytes" },
          { name: "signature", type: "bytes" },
        ],

        name: "userOp",
        type: "tuple",
      },
      { name: "userOpHash", type: "bytes32" },
      { name: "missingAccountFunds", type: "uint256" },
    ],
    name: "validateUserOp",
    outputs: [{ name: "validationData", type: "uint256" }],
    stateMutability: "nonpayable",
    type: "function",
  },
  { stateMutability: "payable", type: "receive" },
] as const;

const factoryAbi = [
  {
    inputs: [{ name: "implementation_", type: "address" }],
    stateMutability: "payable",
    type: "constructor",
  },
  { inputs: [], name: "OwnerRequired", type: "error" },
  {
    inputs: [
      { name: "owners", type: "bytes[]" },
      { name: "nonce", type: "uint256" },
    ],
    name: "createAccount",
    outputs: [
      {
        name: "account",
        type: "address",
      },
    ],
    stateMutability: "payable",
    type: "function",
  },
  {
    inputs: [
      { name: "owners", type: "bytes[]" },
      { name: "nonce", type: "uint256" },
    ],
    name: "getAddress",
    outputs: [{ name: "", type: "address" }],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "implementation",
    outputs: [{ name: "", type: "address" }],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "initCodeHash",
    outputs: [{ name: "", type: "bytes32" }],
    stateMutability: "view",
    type: "function",
  },
] as const;