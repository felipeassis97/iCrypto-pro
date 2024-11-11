//
//  Constants.swift
//  iCrypto-Pro
//
//  Created by Felipe Assis on 11/11/2024.
//

import Foundation

struct Constants {
    static let SCHEME = "https"
    static let PORT: Int? = nil
    static let BASE_URL = "api.pro.coinbase.com"
    static let FULL_URL = "https://api.pro.coinbase.com"
    static let API_KEY: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("API Key not found in Info.plist")
        }
        return apiKey
    }()
}
