//
//  String+ExtensionTests.swift
//  PayPayCurrencyConverterTests
//
//  Created by Victor Hideo Oka on 26/12/22.
//

import XCTest
@testable import PayPayCurrencyConverter

final class StringExtensionTests: XCTestCase {
    
    func testCurrencyInputFormattingValid() {
        let validInput = "12350"
        let formattedValidInput = validInput.currencyInputFormatting()
        XCTAssertEqual(formattedValidInput, "123.50")
    }
    
    func testCurrencyInputFormattingInvalid() {
        let invalidInput = "abc"
        let formattedInvalidInput = invalidInput.currencyInputFormatting()
        XCTAssertEqual(formattedInvalidInput, "")
    }
}

