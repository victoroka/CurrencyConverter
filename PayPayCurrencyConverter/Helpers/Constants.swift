//
//  Constants.swift
//  PayPayCurrencyConverter
//
//  Created by Victor Hideo Oka on 23/12/22.
//

import Foundation

struct Constants {
    
    static let initFatalErrorDefaultMessage = "init(coder:) has not been implemented"
    
    struct Request {
        
        static let scheme = "https"
        static let host = "openexchangerates.org"
        
        struct Path {
            static let getLatest = "/api/latest.json"
            static let getCurrencies = "/api/currencies.json"
        }
        
        struct Method {
            static let POST = "POST"
            static let GET = "GET"
        }
        
        struct Parameters {
            static let appId = "app_id"
            static let base = "base"
            static let symbols = "symbols"
            static let prettyprint = "prettyprint"
            static let showAlternative = "show_alternative"
        }
    }
}
