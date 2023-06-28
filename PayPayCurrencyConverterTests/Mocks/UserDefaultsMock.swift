//
//  UserDefaultsMock.swift
//  PayPayCurrencyConverterTests
//
//  Created by Victor Hideo Oka on 26/12/22.
//

import Foundation

final class UserDefaultsMock: UserDefaults {
    
    convenience init() {
        self.init(suiteName: "UserDefaultsMock")!
    }
    
    override init?(suiteName suitename: String?) {
        UserDefaults().removePersistentDomain(forName: suitename!)
        super.init(suiteName: suitename)
        
    }
}
