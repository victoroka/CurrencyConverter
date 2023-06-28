//
//  Dynamic.swift
//  PayPayCurrencyConverter
//
//  Created by Victor Hideo Oka on 23/12/22.
//

import Foundation

final class Dynamic<T> {
    
    typealias BindType = ((T) -> Void)
    
    private var binds: [BindType] = []
    var value: T {
        didSet {
            executeBinds()
        }
    }
    
    init(_ val: T) {
        value = val
    }
    
    /// Binds desired actions based on value changes.
    func bind(skip: Bool = false, _ bind: @escaping BindType) {
        binds.append(bind)
        if skip {
            return
        }
        bind(value)
    }
    
    /// Executes binds when set a value.
    private func executeBinds() {
        binds.forEach { [unowned self] bind in
            bind(self.value)
        }
    }
}
