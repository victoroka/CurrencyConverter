//
//  CodeView.swift
//  PayPayCurrencyConverter
//
//  Created by Victor Hideo Oka on 23/12/22.
//

import Foundation
import SnapKit

protocol CodeView {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfigurarion()
    func setupView()
}

extension CodeView {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfigurarion()
    }
}
