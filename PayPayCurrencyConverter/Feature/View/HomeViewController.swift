//
//  HomeViewController.swift
//  PayPayCurrencyConverter
//
//  Created by Victor Hideo Oka on 23/12/22.
//

import UIKit
import SnapKit

// MARK: - Home View Strings Enum
enum HomeViewControllerStrings: String {
    case inputPlaceholder = "Input the amount to convert"
    case convertButtonTitle = "Convert"
}

// MARK: - Home View Controller Class
final class HomeViewController: UIViewController {
    
    // MARK: - UI Components
    private lazy var pickerView: UIPickerView = .init()
    private lazy var spinner: UIActivityIndicatorView = .init(style: .large)
    private lazy var currencyListView: CurrencyListView = .init()
    
    private lazy var textField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = HomeViewControllerStrings.inputPlaceholder.rawValue
        textfield.font = UIFont.boldSystemFont(ofSize: 18)
        textfield.borderStyle = .roundedRect
        textfield.keyboardType = .numberPad
        textfield.returnKeyType = .done
        textfield.clearButtonMode = .whileEditing
        textfield.contentVerticalAlignment = .center
        textfield.textAlignment = .center
        return textfield
    }()
    
    private lazy var convertButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle(HomeViewControllerStrings.convertButtonTitle.rawValue, for: .normal)
        button.layer.borderColor = UIColor.systemBlue.withAlphaComponent(0.6).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = true
        return button
    }()
    
    // MARK: - Properties
    private let viewModel: HomeViewModelProtocol
    private var currenciesDataArray: [String: String] = [:]
    private var currenciesKeys: [String] = []
    private var rates: [String: Double] = [:]
    private var currencySelected: String = ""
    
    // MARK: - Life Cycle
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.initFatalErrorDefaultMessage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        setupView()
        viewModel.fetchCurrencies()
    }
    
    // MARK: - Private Functions
    private func bindUI() {
        viewModel.state.bind { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                self.spinner.startAnimating()
            case .initial, .loaded, .error:
                self.spinner.stopAnimating()
            }
        }
        
        viewModel.rates.bind { [weak self] rates in
            guard let self = self else { return }
            self.rates = rates
            self.updateCurrencyConversionList()
        }
        
        viewModel.currencies.bind { [weak self] currencies in
            guard let self = self else { return }
            self.currenciesDataArray = currencies
            self.pickerView.reloadAllComponents()
        }
        
        viewModel.currenciesKeys.bind { [weak self] currenciesKeys in
            guard let self = self else { return }
            self.currenciesKeys = currenciesKeys
        }
    }
    
    private func updateCurrencyConversionList() {
        let inputAsDouble = Double(textField.text ?? "0") ?? 0
        let currencyListViewModel = CurrencyListViewModel(amountFromInput: inputAsDouble, currencyFromInput: currencySelected, rates: rates, currencyKeys: currenciesKeys)
        currencyListView.reloadContent(with: currencyListViewModel)
    }
    
    // MARK: - Actions
    @objc private func myTextFieldDidChange(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
    }
    
    @objc private func convertButtonPressed() {
        hideKeyboard()
        viewModel.fetchLatestRates()
    }
}

// MARK: - Picker View Delegate & Data Source Protocols
extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        currenciesDataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let currentKey = currenciesKeys[row]
        return currenciesDataArray[currentKey]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencySelected = currenciesKeys[row]
    }
}

// MARK: - Code View Protocol
extension HomeViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(spinner)
        view.addSubview(textField)
        view.addSubview(pickerView)
        view.addSubview(convertButton)
        view.addSubview(currencyListView)
    }
    
    func setupConstraints() {
        spinner.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        pickerView.snp.makeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(120)
        }
        
        convertButton.snp.makeConstraints { (make) in
            make.top.equalTo(pickerView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        currencyListView.snp.makeConstraints { (make) in
            make.top.equalTo(convertButton.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
    
    func setupAdditionalConfigurarion() {
        view.backgroundColor = .white
        hideKeyboardWhenTappedAround()
        pickerView.dataSource = self
        pickerView.delegate = self
        textField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        convertButton.addTarget(self, action: #selector(convertButtonPressed), for: .touchUpInside)
    }
}
