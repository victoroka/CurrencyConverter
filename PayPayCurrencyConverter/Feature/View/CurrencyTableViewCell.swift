//
//  CurrencyTableViewCell.swift
//  PayPayCurrencyConverter
//
//  Created by Victor Hideo Oka on 24/12/22.
//

import UIKit
import SnapKit

// MARK: - Currency Table View Cell Class
final class CurrencyTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    private lazy var currencyNameLabel: UILabel = .init()
    private lazy var convertedAmountLabel: UILabel = .init()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.initFatalErrorDefaultMessage)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Functions
    func setupContent(with viewModel: CurrencyCellViewModel) {
        currencyNameLabel.text = viewModel.getCurrencyCode()
        convertedAmountLabel.text = viewModel.getConvertedAmount()
    }
}

// MARK: - Code View Protocol
extension CurrencyTableViewCell: CodeView {
    func buildViewHierarchy() {
        addSubview(currencyNameLabel)
        addSubview(convertedAmountLabel)
    }
    
    func setupConstraints() {
        currencyNameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        convertedAmountLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    func setupAdditionalConfigurarion() {
        backgroundColor = .white
    }
}
