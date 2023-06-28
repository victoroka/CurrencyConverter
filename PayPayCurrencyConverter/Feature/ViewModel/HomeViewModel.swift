//
//  HomeViewModel.swift
//  PayPayCurrencyConverter
//
//  Created by Victor Hideo Oka on 23/12/22.
//

import Foundation

// MARK: - Home View State Enum
enum HomeViewState {
    case initial
    case loading
    case loaded
    case error
}

// MARK: - Local Cache Keys Enum
enum LocalCacheKeys: String {
    case cachedRates
    case ratesLastFetched
    case cachedCurrencies
    case currenciesLastFetched
}

// MARK: - Home View Model Protocol
protocol HomeViewModelProtocol {
    var rates: Dynamic<[String: Double]> { get set }
    var currencies: Dynamic<[String: String]> { get set }
    var currenciesKeys: Dynamic<[String]> { get set }
    var state: Dynamic<HomeViewState> { get set }
    var serviceLayer: CurrencyConverterServiceProtocol { get }
    
    func fetchLatestRates()
    func fetchCurrencies()
}

// MARK: - Home View Model Class
final class HomeViewModel: HomeViewModelProtocol {
    
    // MARK: - Properties
    var rates: Dynamic<[String: Double]> = .init([:])
    var currencies: Dynamic<[String: String]> = .init([:])
    var currenciesKeys: Dynamic<[String]> = .init([])
    var state: Dynamic<HomeViewState> = .init(.initial)
    var serviceLayer: CurrencyConverterServiceProtocol
    
    // MARK: - Initializers
    init(serviceLayer: CurrencyConverterServiceProtocol = ServiceLayer.shared) {
        self.serviceLayer = serviceLayer
    }
    // MARK: - Functions
    /// Fetch the latest rates for all currencies (remotely if necessary).
    func fetchLatestRates() {
        state.value = .loading
        
        let hasRatesCache = UserDefaults.standard.object(forKey: LocalCacheKeys.cachedRates.rawValue) != nil
        let dateFetched = UserDefaults.standard.object(forKey: LocalCacheKeys.ratesLastFetched.rawValue) as? Date
        
        if !hasRatesCache || isRequestTimeValid(for: dateFetched) {
            UserDefaults.standard.set(Date(), forKey: LocalCacheKeys.ratesLastFetched.rawValue)
            serviceLayer.request(router: .getLatest(currenciesKeys.value)) { (result: Result<LatestResponseModel, Error>) in
                switch result {
                case .success(let latestRates):
                    self.rates.value = latestRates.rates
                    UserDefaults.standard.set(latestRates.rates, forKey: LocalCacheKeys.cachedRates.rawValue)
                    self.state.value = .loaded
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                    self.state.value = .loaded
                }
            }
        } else {
            self.rates.value = UserDefaults.standard.object(forKey: LocalCacheKeys.cachedRates.rawValue) as? [String : Double] ?? [:]
            self.state.value = .loaded
        }
    }
    
    /// Fetch all currency codes (remotely if necessary).
    func fetchCurrencies() {
        state.value = .loading
        
        let hasCurrenciesCache = UserDefaults.standard.object(forKey: LocalCacheKeys.cachedCurrencies.rawValue) != nil
        let dateFetched = UserDefaults.standard.object(forKey: LocalCacheKeys.currenciesLastFetched.rawValue) as? Date
        
        if !hasCurrenciesCache || isRequestTimeValid(for: dateFetched) {
            serviceLayer.request(router: .getCurrencies) { (result: Result<[String: String], Error>) in
                switch result {
                case .success(let currencies):
                    self.currencies.value = currencies
                    self.currenciesKeys.value = Array(currencies.keys).sorted()
                    UserDefaults.standard.set(currencies, forKey: LocalCacheKeys.cachedCurrencies.rawValue)
                    self.state.value = .loaded
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                    self.state.value = .loaded
                }
            }
        } else {
            let cachedCurrencies = UserDefaults.standard.object(forKey: LocalCacheKeys.cachedCurrencies.rawValue) as? [String : String] ?? [:]
            self.currencies.value = cachedCurrencies
            self.currenciesKeys.value = Array(cachedCurrencies.keys).sorted()
            self.state.value = .loaded
        }
    }
    
    /// Check if it has passed more than 30 minutes since last request.
    /// - Returns: Boolean flag allowing (true) or not allowing (false) to fetch remotely.
    func isRequestTimeValid(for dateFetched: Date?) -> Bool {
        if let date = dateFetched {
            let dateToFetch = Calendar.current.date(byAdding: .minute, value: 30, to: date) ?? Date()
            if dateToFetch < Date() {
                return true
            }
        }
        return false
    }
}
