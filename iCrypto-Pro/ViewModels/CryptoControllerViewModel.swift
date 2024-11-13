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
        //        return "Rank: \(self.coin.rank)"
        return "Rank: "
    }
    
    var priceLabel: String {
        return "Price: $\(self.coin.pricingData.CAD.price) CAD"
    }
    
    var marketCapLabel: String {
        return "Market Cap: $\(self.coin.pricingData.CAD.marketCap) CAD"
    }
    
    var maxSupplyLabel: String {
        if let maxSupply = self.coin.maxSupply {
            return "Max Supply: \(maxSupply)"
        } else {
            return "123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n"
        }
    }
    
    
}
