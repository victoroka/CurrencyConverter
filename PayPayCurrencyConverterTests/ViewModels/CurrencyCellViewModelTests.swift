//
//  CurrencyCellViewModelTests.swift
//  PayPayCurrencyConverterTests
//
//  Created by Victor Hideo Oka on 26/12/22.
//

import XCTest
@testable import PayPayCurrencyConverter

final class CurrencyCellViewModelTests: XCTestCase {
    
    func testGetCurrencyCode() {
        let viewModel = CurrencyCellViewModel(currencyCode: "JPY", convertedAmount: 123.45)
        let currencyCode = viewModel.getCurrencyCode()
        XCTAssertEqual(currencyCode, "JPY")
    }
    
    func testGetConvertedAmount() {
        let viewModel = CurrencyCellViewModel(currencyCode: "JPY", convertedAmount: 123.5)
        let convertedAmount = viewModel.getConvertedAmount()
        XCTAssertEqual(convertedAmount, "123.50")
    }
}
