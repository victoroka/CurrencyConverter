//
//  String+Extension.swift
//  PayPayCurrencyConverter
//
//  Created by Victor Hideo Oka on 23/12/22.
//

import Foundation

extension String {
    
    /// Format a string to currency style with desired fraction digits.
    /// - Parameters:
    ///     - fractionDigits: The maximum desired number of fraction digits (2 by default).
    /// - Returns: Formatted number as string with the desired number of fraction digits.
    func currencyInputFormatting(with fractionDigits: Int = 2) -> String {
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = fractionDigits
        formatter.minimumFractionDigits = fractionDigits
    
        var amountWithPrefix = self
    
        // Removing characters: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        // Converting to double value
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / pow(10, Double(fractionDigits))))
    
        // Checking clear input
        guard number != 0 as NSNumber else { return "" }
        
        return formatter.string(from: number)!
    }
}
