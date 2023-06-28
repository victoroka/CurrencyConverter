//
//  CurrencyListView.swift
//  PayPayCurrencyConverter
//
//  Created by Victor Hideo Oka on 24/12/22.
//

import UIKit
import SnapKit

// MARK: - Currency List View Class
final class CurrencyListView: UIView {
    
    // MARK: - UI Components & Properties
    private lazy var tableView: UITableView = .init()
    private var viewModel: CurrencyListViewModel?
    
    // MARK: - Life Cycle
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.initFatalErrorDefaultMessage)
    }
    
    // MARK: - Functions
    func reloadContent(with viewModel: CurrencyListViewModel) {
        self.viewModel = viewModel
        viewModel.convertRates()
        viewModel.buildCellViewModelArray()
        tableView.reloadData()
    }
}

// MARK: - Table View Delegate & Data Source Protocols
extension CurrencyListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.getCurrencyKeys().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModels = viewModel?.getCellViewModels() else { return UITableViewCell() }
        let cell = tableView.dequeue(cell: CurrencyTableViewCell.self, indexPath: indexPath)
        cell.setupContent(with: cellViewModels[indexPath.row])
        return cell
    }
}

// MARK: - Code View Protocol
extension CurrencyListView: CodeView {
    func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    
    func setupAdditionalConfigurarion() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(cellType: CurrencyTableViewCell.self)
    }
}
