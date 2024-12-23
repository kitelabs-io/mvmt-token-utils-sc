# Movement Token Utils Smart contract

This repository contains utility smart contracts for working with token (Coin & FA) in Movement.

## Prerequisites

[Aptos CLI 3.5.0](https://github.com/aptos-labs/aptos-core/releases/tag/aptos-cli-v3.5.0) or [Movement CLI](https://docs.movementnetwork.xyz/devs/movementcli) is required.

### Initialize profile

We have to initialize a profile to interact with on-chain.

Run the command below to initialize a profile (please replace the appropriate values for `<profile-name>`).

```sh
aptos init --profile <profile-name> --network custom --rest-url {node-api-url} --skip-faucet
```

- After running the command, you will be asked to enter the `private key` of the account. Please enter the private key of the account you want to use to interact with the blockchain or let the cli generate a new key for you. If you let the cli generate a new key, please faucet $MOVE before submitting transactions.

**Example:** Here is the command to create a profile in `Porto testnet` with name `mvmt-token-utils`:

```sh
aptos init --profile mvmt-token-utils --network custom --rest-url https://aptos.testnet.porto.movementlabs.xyz/v1 --skip-faucet
```

## Build & test

- Run the command below to compile the contract:

```sh
aptos move compile --dev
```

### Test

- Run the command below to test the contract:

```sh
aptos move test
```

## Publish/upgrade packages

_Suppose we have initialized a profile with name `mvmt-token-utils` (can change this profile to whatever you want)._

### Publish

- Run the command below to deploy the contract:

```sh
aptos move publish --profile mvmt-token-utils --included-artifacts none
```

## Client side integration

Please check the [examples](./examples/) folder for more details.
