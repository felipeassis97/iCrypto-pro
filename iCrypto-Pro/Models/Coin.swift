//
//  Coin.swift
//  iCrypto-Pro
//
//  Created by Felipe Assis on 11/11/2024.
//

import Foundation

struct Coin {
    let id: Int
    let name: String
    let max_supply: Int?
    let cmc_rank: Int
    let quote: Quote
    
    var logoURL: URL? {
        return URL(string: "https://s2.coinmarketcap.com/static/img/coins/200x200/1.png")
    }
    
    struct Quote {
        let USD: USD
        
        struct USD {
            let price: Double
            let market_cap: Double
        }
    }
}


extension Coin {
    public static func getMock() -> [Coin] {
        return [
            Coin(id: 1, name: "Bitcoin", max_supply: 2000, cmc_rank: 1, quote: Quote(USD: Quote.USD(price: 5000, market_cap: 1_000_000))),
            Coin(id: 1, name: "Ethereum", max_supply: 500, cmc_rank: 1, quote: Quote(USD: Quote.USD(price: 3000, market_cap: 500_000))),
            Coin(id: 1, name: "Solana", max_supply: nil, cmc_rank: 1, quote: Quote(USD: Quote.USD(price: 1000, market_cap: 300_000))),
            Coin(id: 1, name: "Aevo", max_supply: nil, cmc_rank: 1, quote: Quote(USD: Quote.USD(price: 40, market_cap: 4_000))),
        ]
    }
}
