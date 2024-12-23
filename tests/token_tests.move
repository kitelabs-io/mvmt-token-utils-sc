#[test_only]
module token_utils::token_tests {
    use std::option;
    use std::signer;
    use std::string;
    use aptos_std::type_info;
    use aptos_framework::account;
    use aptos_framework::aptos_account;
    use aptos_framework::aptos_coin;
    use aptos_framework::aptos_coin::AptosCoin;
    use aptos_framework::coin::{Self, MintCapability, BurnCapability, Coin};
    use aptos_framework::fungible_asset::{Self, MintRef, TransferRef, BurnRef};
    use aptos_framework::object;
    use aptos_framework::primary_fungible_store;
    use token_utils::token::Null;
    use token_utils::token;

    struct USDC {}

    struct USDT {}


    struct CoinCap<phantom CoinType> has key {
        mint_cap: MintCapability<CoinType>,
        burn_cap: BurnCapability<CoinType>,
    }

    #[resource_group_member(group = aptos_framework::object::ObjectGroup)]
    /// Hold refs to control the minting, transfer and burning of fungible assets.
    struct ManagedFungibleAsset has key {
        mint_ref: MintRef,
        transfer_ref: TransferRef,
        burn_ref: BurnRef,
    }

    const FA_1_SYMBOL: vector<u8> = b"FA1";

    #[test(user = @0x123)]
    fun test_get_token_balances(user: &signer) acquires ManagedFungibleAsset, CoinCap {
        setup_test();

        let user_addr = signer::address_of(user);
        account::create_account_for_test(user_addr);

        // AptosCoin: coin with FA, migrated fungible store
        // USDC: coin with FA, but not migrated fungible store
        // USDT: coin without FA

        coin::migrate_to_fungible_store<AptosCoin>(user);
        mint_coin_to_account<AptosCoin>(user_addr, 1_000_000);

        mint_coin_to_account<USDC>(user_addr, 2_000_000);
        primary_fungible_store::deposit(
            user_addr,
             coin::coin_to_fungible_asset(mint_coin<USDC>(3_000_000)),
        );

        mint_coin_to_account<USDT>(user_addr, 6_000_000);

        mint_fa_to_account(FA_1_SYMBOL, user_addr, 7_000_000);

        let token_balances = token::get_token_balances<
            AptosCoin,
            Null, Null, Null, Null, Null, Null, Null, Null, Null, Null,
            USDC,
            Null, Null, Null, Null, Null, Null, Null, Null, Null, Null,
            Null, Null, Null, Null, Null, Null, Null, Null, Null,
            USDT,
        >(
            user_addr,
            vector[get_fa_address(FA_1_SYMBOL)],
        );

        let expected_balances = vector[
            token::new_token_balance(
                type_info::type_name<AptosCoin>(),
                string::utf8(b"0xa"),
                0,
                1_000_000,
            ),
            token::new_token_balance(
                type_info::type_name<USDC>(),
                string::utf8(b"0x73fda93f3d53a3d152a9a6aefccaa035433a1f428b577f8a758631d800832f70"),
                2_000_000,
                3_000_000,
            ),
            token::new_token_balance(
                type_info::type_name<USDT>(),
                string::utf8(b""),
                6_000_000,
                0,
            ),
            token::new_token_balance(
                string::utf8(b""),
                string::utf8(b"0x7923c24e854e2c29b623f5a66e1b78f8be722a6c98b3eaaeb32f79f51aac3bd2"),
                0,
                7_000_000,
            ),
        ];
        assert!(expected_balances == token_balances, 42);
    }

    fun setup_test() {
        let owner = &account::create_account_for_test(@token_utils);

        let aptos_framework = &account::create_account_for_test(@aptos_framework);
        coin::create_coin_conversion_map(aptos_framework);
        let (burn_cap, mint_cap) = aptos_coin::initialize_for_test(aptos_framework);

        move_to(owner, CoinCap<AptosCoin> {
            mint_cap,
            burn_cap,
        });

        initialize_coin<USDC>(owner, b"USDC", b"USDC", 6);
        initialize_coin<USDT>(owner, b"USDT", b"USDT", 6);
        initialize_fa(owner, FA_1_SYMBOL, FA_1_SYMBOL, 8);
    }

    fun initialize_coin<CoinType>(owner: &signer, name: vector<u8>, symbol: vector<u8>, decimals: u8) {
        let (burn_cap, freeze_cap, mint_cap) = coin::initialize<CoinType>(
            owner,
            string::utf8(name),
            string::utf8(symbol),
            decimals,
            false
        );
        coin::destroy_freeze_cap(freeze_cap);

        move_to(owner, CoinCap<CoinType> {
            mint_cap,
            burn_cap,
        });
    }

    fun initialize_fa(owner: &signer, name: vector<u8>, symbol: vector<u8>, decimals: u8) {
        let constructor_ref = &object::create_named_object(owner, symbol);
        primary_fungible_store::create_primary_store_enabled_fungible_asset(
            constructor_ref,
            option::none(),
            string::utf8(name),
            string::utf8(symbol),
            decimals,
            string::utf8(b""),
            string::utf8(b""),
        );

        let mint_ref = fungible_asset::generate_mint_ref(constructor_ref);
        let burn_ref = fungible_asset::generate_burn_ref(constructor_ref);
        let transfer_ref = fungible_asset::generate_transfer_ref(constructor_ref);
        let metadata_object_signer = object::generate_signer(constructor_ref);
        move_to(
            &metadata_object_signer,
            ManagedFungibleAsset { mint_ref, transfer_ref, burn_ref }
        );
    }

    fun mint_coin_to_account<CoinType>(acc: address, amount: u64) acquires CoinCap {
        aptos_account::deposit_coins(acc, mint_coin<CoinType>(amount));
    }

    fun mint_coin<CoinType>(amount: u64): Coin<CoinType> acquires CoinCap {
        let coin_cap = borrow_global<CoinCap<CoinType>>(@token_utils);
        coin::mint(amount, &coin_cap.mint_cap)
    }

    fun mint_fa_to_account(fa_symbol: vector<u8>, acc: address, amount: u64) acquires ManagedFungibleAsset {
        let fa_address = object::create_object_address(&@token_utils, fa_symbol);
        let managed_fungible_asset = borrow_global<ManagedFungibleAsset>(fa_address);

        primary_fungible_store::deposit(acc, fungible_asset::mint(&managed_fungible_asset.mint_ref, amount));
    }

    fun get_fa_address(fa_symbol: vector<u8>): address {
       object::create_object_address(&@token_utils, fa_symbol)
    }
}
