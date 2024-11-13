//
//  eNDPOINT.swift
//  iCrypto-Pro
//
//  Created by Felipe Assis on 12/11/2024.
//

import Foundation

enum Endpoint {
    case fetchCoins(url: String = "/v1/cryptocurrency/listings/latest")
    case postCoin(url: String = "/v1/cryptocurrency/post")
    
    var request: URLRequest? {
        guard let url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.httpBody = self.httpBody
        request.addValues(for: self)
        return request
    }
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.SCHEME
        components.host = Constants.BASE_URL
        components.port = Constants.PORT
        components.path = self.path
        components.queryItems = self.queryItems
        return components.url
    }
    
    private var path: String {
        switch self {
        case .fetchCoins(let url),
                .postCoin(url: let url):
            return url
            
        }
    }
    
    private var httpMethod: String {
        switch self {
        case .fetchCoins:
            return HTTP.Method.get.rawValue
        case .postCoin:
            return HTTP.Method.post.rawValue
        }
    }
    
    private var queryItems: [URLQueryItem]? {
        switch self {
        case .fetchCoins:
            return [
                URLQueryItem(name: "limit", value: "150"),
                URLQueryItem(name: "sort", value: "market_cap"),
                URLQueryItem(name: "convert", value: "USD"),
                URLQueryItem(name: "aux", value: "cmc_rank,max_supply,circulating_supply,total_supply"),
            ]
        case .postCoin:
            return nil
        }
    }
    
    private var httpBody: Data? {
        switch self {
        case .fetchCoins:
            return nil
        case .postCoin:
            return nil
            //return try? JSONEncoder().encode(Coin(id: 1, name: "Test", maxSupply: 1, rank: 1, pricingData: PricingData(USD: USD(price: 10.0, market_cap: 10.0))))
          
            //return try? JSONSerialization.data(withJSONObject: ["name" : "Test"], options: [])
        }
    }
}

extension URLRequest {
    mutating func addValues(for endpoint: Endpoint) {
        switch endpoint {
        case .fetchCoins:
            self.setValue(HTTP.Header.Value.applicationJSON.rawValue, forHTTPHeaderField: HTTP.Header.Key.contentType.rawValue)
            self.setValue(Constants.API_KEY, forHTTPHeaderField: HTTP.Header.Key.apiKey.rawValue)
        case .postCoin:
            return
        }
    }
}
