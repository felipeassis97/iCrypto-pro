//
//  ViewModelCryptoController.swift
//  iCrypto-Pro
//
//  Created by Felipe Assis on 11/11/2024.
//

import UIKit

class CryptoControllerViewModel {
    
    // MARK: - Variables
    let coin: Coin
    
    // MARK: - Initializer
    init(_ coin: Coin) {
        self.coin = coin
    }
    
    // MARK: - Computed properties
    var rankLabel: String {
        return "Rank: \(self.coin.rank)°"
    }
    
    var priceLabel: String {
        return "Price: \(self.coin.pricingData.USD.price.toDollarCurrency()) USD"
    }
    
    var marketCapLabel: String {
        return "Market Cap: \(self.coin.pricingData.USD.marketCap.toDollarCurrency()) USD"
    }
    
    var maxSupplyLabel: String {
        return  self.coin.maxSupply?.description ?? ""
    }
}
