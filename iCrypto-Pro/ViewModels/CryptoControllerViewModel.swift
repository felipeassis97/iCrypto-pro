//
//  ViewModelCryptoController.swift
//  iCrypto-Pro
//
//  Created by Felipe Assis on 11/11/2024.
//

import UIKit

class CryptoControllerViewModel {
    var onImageLoaded: ((UIImage?) -> Void)?
    
    // MARK: - Variables
    let coin: Coin
    
    // MARK: - Initializer
    init(_ coin: Coin) {
        self.coin = coin
        loadImage()
    }
    
    private func loadImage() {
        DispatchQueue.global().async {
            if let logoURL = self.coin.logoURL,
               let imageData = try? Data(contentsOf: logoURL),
               let logoImage = UIImage(data: imageData){
                self.onImageLoaded?(logoImage)
            }
        }
    }
    
    // MARK: - Computed properties
    var rankLabel: String {
        return "Rank: \(self.coin.cmc_rank)"
    }
    
    var priceLabel: String {
        return "Price: $\(self.coin.quote.USD.price) USD"
    }
    
    var marketCapLabel: String {
        return "Market Cap: $\(self.coin.quote.USD.market_cap) USD"
    }
    
    var maxSupplyLabel: String {
        if let maxSupply = self.coin.max_supply {
            return "Max Supply: \(maxSupply)"
        } else {
            return "123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n"
        }
    }
    
    
}
