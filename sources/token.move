module token_utils::token {
    use std::option;
    use std::string;
    use std::string::{String};
    use std::vector;

    use aptos_std::string_utils;
    use aptos_std::type_info;
    use aptos_framework::coin;
    use aptos_framework::fungible_asset::Metadata;
    use aptos_framework::object::{Self, Object};
    use aptos_framework::primary_fungible_store;

    // Constants.

    const EMPTY_STR: vector<u8> = b"";

    // Structs.

    struct Null {}

    struct TokenBalance has copy, drop {
        coin_type: String,
        fa_address: String,
        /// The balance of the coin in the account.
        /// If user has not migrated the coin to FA, this will be the balance of the coin only, 
        /// not including the FA balance like coin::balance function.
        /// If user has migrated the coin to FA, coin_balance will be 0.
        coin_balance: u64,
        /// The balance of the FA in the account.
        fa_balance: u64,
    }

    // Functions.

    #[view]
    /// Get the balances of the given account for the given coins and FAs.
    ///
    /// # Type arguments
    ///
    /// - `T1` -> `T32` - The type of the coins. Use token::Null if don't want to get the balance of a coin.
    ///
    /// # Arguments
    ///
    /// - `account` - The account to get the balances for.
    /// - `fa_addresses` - The addresses of the FAs to get the balances for. These FAs should not be paired with any coin.
    ///     If a coin is paired with an FA, just provide the coin type in the type arguments.
    public fun get_token_balances<
        T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16,
        T17, T18, T19, T20, T21, T22, T23, T24, T25, T26, T27, T28, T29, T30, T31, T32,
    >(
        account: address,
        fa_addresses: vector<address>,
    ): vector<TokenBalance> {
        let balances = vector<TokenBalance>[];

        get_balance_of_coins<
            T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16,
            T17, T18, T19, T20, T21, T22, T23, T24, T25, T26, T27, T28, T29, T30, T31, T32,
        >(account, &mut balances);

        get_balance_of_fas(account, &fa_addresses, &mut balances);

        return balances
    }

    fun get_balance_of_coins<
        T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16,
        T17, T18, T19, T20, T21, T22, T23, T24, T25, T26, T27, T28, T29, T30, T31, T32,
    >(
        account: address,
        balances: &mut vector<TokenBalance>,
    ) {
        let null_type = type_info::type_of<Null>();

        if (type_info::type_of<T1>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T1>(account));
        };

        if (type_info::type_of<T2>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T2>(account));
        };

        if (type_info::type_of<T3>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T3>(account));
        };

        if (type_info::type_of<T4>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T4>(account));
        };

        if (type_info::type_of<T5>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T5>(account));
        };

        if (type_info::type_of<T6>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T6>(account));
        };

        if (type_info::type_of<T7>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T7>(account));
        };

        if (type_info::type_of<T8>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T8>(account));
        };

        if (type_info::type_of<T9>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T9>(account));
        };

        if (type_info::type_of<T10>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T10>(account));
        };

        if (type_info::type_of<T11>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T11>(account));
        };

        if (type_info::type_of<T12>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T12>(account));
        };

        if (type_info::type_of<T13>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T13>(account));
        };

        if (type_info::type_of<T14>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T14>(account));
        };

        if (type_info::type_of<T15>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T15>(account));
        };

        if (type_info::type_of<T16>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T16>(account));
        };

        if (type_info::type_of<T17>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T17>(account));
        };

        if (type_info::type_of<T18>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T18>(account));
        };

        if (type_info::type_of<T19>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T19>(account));
        };

        if (type_info::type_of<T20>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T20>(account));
        };

        if (type_info::type_of<T21>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T21>(account));
        };

        if (type_info::type_of<T22>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T22>(account));
        };

        if (type_info::type_of<T23>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T23>(account));
        };

        if (type_info::type_of<T24>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T24>(account));
        };

        if (type_info::type_of<T25>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T25>(account));
        };

        if (type_info::type_of<T26>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T26>(account));
        };

        if (type_info::type_of<T27>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T27>(account));
        };

        if (type_info::type_of<T28>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T28>(account));
        };

        if (type_info::type_of<T29>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T29>(account));
        };

        if (type_info::type_of<T30>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T30>(account));
        };

        if (type_info::type_of<T31>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T31>(account));
        };

        if (type_info::type_of<T32>() != null_type) {
            vector::push_back(balances, get_balance_of_coin<T32>(account));
        };
    }

    fun get_balance_of_coin<CoinType>(account: address): TokenBalance {
        let paired_metadata = coin::paired_metadata<CoinType>();
        let coin_balance = coin::balance<CoinType>(account);

        if (option::is_some(&paired_metadata)) {
            let metadata = option::destroy_some(paired_metadata);
            let fa_balance = primary_fungible_store::balance(account, *option::borrow(&paired_metadata));
            TokenBalance {
                coin_type: type_info::type_name<CoinType>(),
                fa_address: format_fa_address(metadata),
                coin_balance: coin_balance - fa_balance,
                fa_balance,
            }
        } else {
            TokenBalance {
                coin_type: type_info::type_name<CoinType>(),
                fa_address: string::utf8(EMPTY_STR),
                coin_balance,
                fa_balance: 0,
            }
        }
    }

    fun get_balance_of_fas(
        account: address,
        fa_addresses: &vector<address>,
        balances: &mut vector<TokenBalance>,
    ) {
        for (i in 0..vector::length(fa_addresses)) {
            let fa_address = *vector::borrow(fa_addresses, i);
            let metadata = object::address_to_object<Metadata>(fa_address);

            vector::push_back(balances, TokenBalance {
                coin_type: string::utf8(EMPTY_STR),
                fa_address: format_address(fa_address),
                coin_balance: 0,
                fa_balance: primary_fungible_store::balance(account, metadata),
            });
        };
    }

    fun format_fa_address(metadata: Object<Metadata>): String {
        format_address(object::object_address(&metadata))
    }

    fun format_address(addr: address): String {
        let address = string_utils::to_string(&addr);
        // remove '@' charactor in the head of the address string.
        address = string::sub_string(&address, 1, string::length(&address));

        address
    }

    // Tests.

    #[test_only]
    public fun new_token_balance(
        coin_type: String,
        fa_address: String,
        coin_balance: u64,
        fa_balance: u64,
    ): TokenBalance {
        TokenBalance {
            coin_type,
            fa_address,
            coin_balance,
            fa_balance,
        }
    }
}
