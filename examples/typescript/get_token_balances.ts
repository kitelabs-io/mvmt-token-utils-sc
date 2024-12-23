import { Account, Aptos, AptosConfig, Network } from "@aptos-labs/ts-sdk";

const example = async () => {
  // Setup the Aptos client
  const config = new AptosConfig({
    network: Network.CUSTOM,
    fullnode: "https://aptos.testnet.porto.movementlabs.xyz/v1",
  });
  const aptos = new Aptos(config);

  // Prepare function parameters
  const TOKEN_UTILS_CONTRACT_ADDRESS =
    "0xdaf7e32fb5abef979b385cf1cac0dcd0fd266c3a415d2a883fa329a5edaa07f6";

  // The address for which we want to get the balances
  const accountAddressGetBalances =
    "0xdaf7e32fb5abef979b385cf1cac0dcd0fd266c3a415d2a883fa329a5edaa07f6";

  // These are examples, you should replace them with the actual FA addresses you want to get the balances for
  let coinTypes = [
    "0x1::aptos_coin::AptosCoin",
    // ... other coin types
  ];
  // Fill in the remaining types (if any) with null values to reach 32 argument types for the get_token_balances function.
  coinTypes = coinTypes.concat(
    new Array(32 - coinTypes.length).fill(
      `${TOKEN_UTILS_CONTRACT_ADDRESS}::token::Null`
    )
  );

  // These are examples, you should replace them with the actual FA addresses you want to get the balances for
  const faAddresses = [
    "0x1e74c3312b1a7a08eb7cf61310787597ea6609d6d99ce86c0e48399144ea4ce9",
    // Other FA addresses
  ];

  // Call the view function
  const result: {
    coin_type: string;
    coin_balance: string;
    fa_address: string;
    fa_balance: string;
  }[][] = await aptos.view({
    payload: {
      function: `${TOKEN_UTILS_CONTRACT_ADDRESS}::token::get_token_balances`,
      typeArguments: coinTypes,
      functionArguments: [accountAddressGetBalances, faAddresses],
    },
  });

  // TODO: Handle the result
  console.log(result); // just log the result for now
};

example();
