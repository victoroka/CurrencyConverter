//
//  Router.swift
//  PayPayCurrencyConverter
//
//  Created by Victor Hideo Oka on 23/12/22.
//

import Foundation

enum Router {
    
    case getLatest([String])
    case getCurrencies
    
    var scheme: String {
        switch self {
        case .getLatest, .getCurrencies:
            return Constants.Request.scheme
        }
    }
    
    var host: String {
        switch self {
        case .getLatest, .getCurrencies:
            return Constants.Request.host
        }
    }
    
    var path: String {
        switch self {
        case .getLatest:
            return Constants.Request.Path.getLatest
        case .getCurrencies:
            return Constants.Request.Path.getCurrencies
        }
    }
    
    var method: String {
        switch self {
        case .getLatest, .getCurrencies:
            return Constants.Request.Method.GET
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getLatest(let currencyCodes):
            let joinedSymbols = currencyCodes.joined(separator: ",")
            let queryItems: [URLQueryItem] = [
                URLQueryItem(name: Constants.Request.Parameters.appId, value: "8e2f5d1d1752406eab5bfbd6670cba5e"),
                URLQueryItem(name: Constants.Request.Parameters.base, value: "USD"),
                URLQueryItem(name: Constants.Request.Parameters.symbols, value: joinedSymbols),
                URLQueryItem(name: Constants.Request.Parameters.prettyprint, value: "true"),
                URLQueryItem(name: Constants.Request.Parameters.showAlternative, value: "false")
            ]
            return queryItems
        case .getCurrencies:
            return []
        }
    }
}
