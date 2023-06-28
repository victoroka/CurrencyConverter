//
//  ServiceLayerMock.swift
//  PayPayCurrencyConverterTests
//
//  Created by Victor Hideo Oka on 26/12/22.
//

import Foundation
@testable import PayPayCurrencyConverter

final class ServiceLayerMock: CurrencyConverterServiceProtocol {
    
    private let latestMockRates: LatestResponseModel = .init(disclaimer: "",
                                                             license: "",
                                                             timestamp: 0,
                                                             base: "",
                                                             rates: ["USD": 1.00, "BRL": 5.00, "EUR": 4.00, "JPY": 2.00])
    
    func request<T>(router: PayPayCurrencyConverter.Router, completion: @escaping (Result<T, Error>) -> ()) where T : Decodable, T : Encodable {
        switch router {
        case .getLatest( _):
            completion(.success(latestMockRates as! T))
        case .getCurrencies:
            completion(.success(["USD": "United States dollar", "BRL": "Brazilian real", "EUR": "Euro", "JPY": "Japanese ren"] as! T))
        }
    }
}
