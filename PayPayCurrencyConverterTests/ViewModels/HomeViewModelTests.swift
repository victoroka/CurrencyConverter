//
//  HomeViewModelTests.swift
//  PayPayCurrencyConverterTests
//
//  Created by Victor Hideo Oka on 26/12/22.
//

import XCTest
@testable import PayPayCurrencyConverter

final class HomeViewModelTests: XCTestCase {
    
    func testFetchLatestRates() {
        UserDefaultsMock.standard.setValue(nil, forKey: LocalCacheKeys.cachedRates.rawValue)
        let viewModel = HomeViewModel(serviceLayer: ServiceLayerMock())
        viewModel.fetchLatestRates()
        let latestFetchedRates = viewModel.rates.value
        
        XCTAssertEqual(latestFetchedRates, ["USD": 1.00, "BRL": 5.00, "EUR": 4.00, "JPY": 2.00])
    }
    
    func testFetchCurrencies() {
        UserDefaultsMock.standard.setValue(nil, forKey: LocalCacheKeys.cachedCurrencies.rawValue)
        let viewModel = HomeViewModel(serviceLayer: ServiceLayerMock())
        viewModel.fetchCurrencies()
        let latestFetchedCurrencies = viewModel.currencies.value
        let latestFetchedCurrenciesKeys = viewModel.currenciesKeys.value
        
        XCTAssertEqual(latestFetchedCurrencies, ["BRL": "Brazilian real", "USD": "United States dollar", "JPY": "Japanese ren", "EUR": "Euro"])
        XCTAssertEqual(latestFetchedCurrenciesKeys, ["BRL", "EUR", "JPY", "USD"])
    }
    
    func testIsRequestTimeValidFalse() {
        let viewModel = HomeViewModel(serviceLayer: ServiceLayerMock())
        let isRequestTimeValid = viewModel.isRequestTimeValid(for: Date())
        XCTAssertEqual(isRequestTimeValid, false)
    }
    
    func testIsRequestTimeValidTrue() {
        let viewModel = HomeViewModel(serviceLayer: ServiceLayerMock())
        let dayBeforeDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let isRequestTimeValid = viewModel.isRequestTimeValid(for: dayBeforeDate)
        XCTAssertEqual(isRequestTimeValid, true)
    }
}
