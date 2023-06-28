//
//  UIViewController+Extension.swift
//  PayPayCurrencyConverter
//
//  Created by Victor Hideo Oka on 25/12/22.
//

import UIKit

extension UIViewController {
    
    /// Register a gesture recognizer for hiding the keyboard when tapped out.
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    /// Hide the keyboard.
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
