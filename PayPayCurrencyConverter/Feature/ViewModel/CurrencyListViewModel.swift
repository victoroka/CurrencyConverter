//
//  CurrencyListViewModel.swift
//  PayPayCurrencyConverter
//
//  Created by Victor Hideo Oka on 24/12/22.
//

import Foundation

// MARK: - Currency List View Model
final class CurrencyListViewModel {
    
    // MARK: - Properties
    private let amountFromInput: Double
    private let currencyFromInput: String
    private let rates: [String: Double]
    private let currencyKeys: [String]
    
    private var convertedRates: [String: Double] = [:]
    private var cellViewModels: [CurrencyCellViewModel] = []
    
    // MARK: - Initializers
    init(amountFromInput: Double, currencyFromInput: String, rates: [String : Double], currencyKeys: [String]) {
        self.amountFromInput = amountFromInput
        self.currencyFromInput = currencyFromInput
        self.rates = rates
        self.currencyKeys = currencyKeys
    }
    
    // MARK: - Functions
    func getCurrencyKeys() -> [String] {
        currencyKeys
    }
    
    func getCellViewModels() -> [CurrencyCellViewModel] {
        cellViewModels
    }
    
    func getConvertedRates() -> [String: Double] {
        convertedRates
    }
    
    /// Convert all currencies based on USD latest rate.
    func convertRates() {
        var convertedRates: [String: Double] = [:]
        
        for key in currencyKeys {
            let rate = rates[currencyFromInput] ?? 1
            let dollarValue = amountFromInput/rate
            let finalValue = dollarValue * (rates[key] ?? 0)
            convertedRates[key] = finalValue
        }
        self.convertedRates = convertedRates
    }
    
    /// Build the array that contains the list of view models to present based on converted currencies.
    func buildCellViewModelArray() {
        for currencyKey in currencyKeys {
            let convertedRate = convertedRates[currencyKey] ?? 0
            let cellViewModel = CurrencyCellViewModel(currencyCode: currencyKey, convertedAmount: convertedRate)
            cellViewModels.append(cellViewModel)
        }
    }
}
