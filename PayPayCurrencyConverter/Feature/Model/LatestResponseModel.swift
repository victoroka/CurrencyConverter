//
//  LatestResponseModel.swift
//  PayPayCurrencyConverter
//
//  Created by Victor Hideo Oka on 23/12/22.
//

import Foundation

struct LatestResponseModel: Codable {
    let disclaimer: String
    let license: String
    let timestamp: Int
    let base: String
    let rates: [String: Double]
}
