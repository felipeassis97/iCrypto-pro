//
//  Double+.swift
//  iCrypto-Pro
//
//  Created by Felipe Assis on 13/11/2024.
//

import Foundation

extension Double {
    func toDollarCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.locale = Locale(identifier: "en_US")

        return formatter.string(from: NSNumber(value: self)) ?? "$0.00"
    }
}
