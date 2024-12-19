# Mosaic Token Utils Smart contract

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

**Example:** Here is the command to create a profile in `Porto testnet` with name `deployer`:

```sh
aptos init --profile deployer --network custom --rest-url https://aptos.testnet.porto.movementlabs.xyz/v1 --skip-faucet
```

## Development

We use object to deploy our contract. Check out more details at [Object Code Deployment](https://aptos.dev/en/build/smart-contracts/deployment).

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

*Suppose we have initialized a profile with name `deployer` (can change this profile to whatever you want).*

### Publish

- Run the command below to deploy the contract:

```sh
aptos move create-object-and-publish-package --address-name token_utils --profile deployer --included-artifacts none
```

### upgrade

- Run the command below to deploy the contract, replace the appropriate values for `{deployed-contract-address}`:

```sh
aptos move upgrade-object-package --object-address {deployed-contract-address} --named-addresses token_utils={deployed-contract-address} --profile deployer --included-artifacts none
```

### Published package

- **Porto**: `0x8b354b93bbc846aa9b9419f41eb63327abfa3cd30520390d6dfc61d02fa093b8`

