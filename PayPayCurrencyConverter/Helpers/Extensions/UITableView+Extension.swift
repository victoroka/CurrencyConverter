//
//  UITableView+Extension.swift
//  PayPayCurrencyConverter
//
//  Created by Victor Hideo Oka on 24/12/22.
//

import UIKit

extension UITableView {
    
    /// Register a cell with it's type as a reuse identifier.
    func register<T: UITableViewCell>(cellType: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: cellType))
    }
    
    /// Dequeue a cell based on it's type.
    func dequeue<T: UITableViewCell>(cell: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: cell), for: indexPath) as! T
    }
    
}
