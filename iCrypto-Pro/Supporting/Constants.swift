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
    static let BASE_URL = "pro-api.coinmarketcap.com"
    static let FULL_URL = "https://pro-api.coinmarketcap.com"
    static let API_KEY = Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""
}
