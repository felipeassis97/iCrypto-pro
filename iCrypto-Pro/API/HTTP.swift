//
//  HTTP.swift
//  iCrypto-Pro
//
//  Created by Felipe Assis on 12/11/2024.
//

import Foundation

enum HTTP {
    enum Method: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum Header {
        enum Key: String {
            case contentType = "Content-Type"
            case apiKey = "X-CMC_PRO_API_KEY"
        }
        
        enum Value: String {
            case applicationJSON = "application/json"
        }
    }
}
