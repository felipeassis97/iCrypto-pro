//
//  Coin.swift
//  iCrypto-Pro
//
//  Created by Felipe Assis on 11/11/2024.
//

import Foundation

struct CoinArray: Decodable {
    let data: [Coin]
}

struct Coin: Decodable {
    let id: Int
    let name: String
    let maxSupply: Double?
    let rank: Int
    let pricingData: PricingData
    var logoURL: URL? {
        return URL(string: "https://s2.coinmarketcap.com/static/img/coins/200x200/\(id).png")
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id",
             name = "name",
             rank = "cmc_rank",
             maxSupply = "max_supply",
             pricingData = "quote"
    }
}

struct PricingData: Decodable {
    let USD: USD
}

struct USD: Decodable {
    let price: Double
    let marketCap: Double
    
    enum CodingKeys: String, CodingKey {
        case price = "price",
             marketCap = "market_cap"
    }
}
