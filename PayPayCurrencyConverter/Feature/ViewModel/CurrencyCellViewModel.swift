//
//  CurrencyCellViewModel.swift
//  PayPayCurrencyConverter
//
//  Created by Victor Hideo Oka on 24/12/22.
//

import Foundation

// MARK: - Currency Cell View Model
final class CurrencyCellViewModel {
    
    // MARK: - Properties
    private let currencyCode: String
    private let convertedAmount: Double
    
    // MARK: - Initializers
    init(currencyCode: String, convertedAmount: Double) {
        self.currencyCode = currencyCode
        self.convertedAmount = convertedAmount
    }
    
    // MARK: - Functions
    func getCurrencyCode() -> String {
        currencyCode
    }
    
    /// Format converted amount from double value.
    /// - Returns: Formated string with 2 fraction digits.
    func getConvertedAmount() -> String {
        String(format: "%.2f", convertedAmount)
    }
}
