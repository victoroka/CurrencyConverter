//
//  CurrencyListViewModelTests.swift
//  PayPayCurrencyConverterTests
//
//  Created by Victor Hideo Oka on 26/12/22.
//

import XCTest
@testable import PayPayCurrencyConverter

final class CurrencyListViewModelTests: XCTestCase {
    
    func testGetCurrencyKeys() {
        let mockRates = ["USD": 1.00, "BRL": 5.00, "EUR": 4.00, "JPY": 2.00]
        let viewModel = CurrencyListViewModel(amountFromInput: 100.00,
                                              currencyFromInput: "BRL",
                                              rates: mockRates,
                                              currencyKeys: ["USD", "BRL", "EUR", "JPY"])
        let currencyKeys = viewModel.getCurrencyKeys()
        
        XCTAssertEqual(currencyKeys, ["USD", "BRL", "EUR", "JPY"])
    }
    
    func testConvertRates() {
        let mockRates = ["USD": 1.00, "BRL": 5.00, "EUR": 4.00, "JPY": 2.00]
        let viewModel = CurrencyListViewModel(amountFromInput: 100.00,
                                              currencyFromInput: "BRL",
                                              rates: mockRates,
                                              currencyKeys: ["USD", "BRL", "EUR", "JPY"])
        viewModel.convertRates()
        let convertedRates = viewModel.getConvertedRates()
        
        XCTAssertEqual(convertedRates, ["USD": 20.0, "BRL": 100.0, "EUR": 80.0, "JPY": 40.0])
    }
    
    func testBuildCellViewModelArray() {
        let mockRates = ["USD": 1.00, "BRL": 5.00, "EUR": 4.00, "JPY": 2.00]
        let viewModel = CurrencyListViewModel(amountFromInput: 100.00,
                                              currencyFromInput: "BRL",
                                              rates: mockRates,
                                              currencyKeys: ["USD", "BRL", "EUR", "JPY"])
        viewModel.convertRates()
        viewModel.buildCellViewModelArray()
        let cellViewModels = viewModel.getCellViewModels()
        
        XCTAssertEqual(cellViewModels.count, 4)
    }
}
