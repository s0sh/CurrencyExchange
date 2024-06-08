//
//  CCViewController.swift
//  CurEx
//
//  Created by Roman Bigun on 06.06.2024.
//

import UIKit

final class CCViewController: BaseController {
    
    var presenter: ConverterPresenter?
    
    private lazy var spinner = SpinnerViewController()
   
    // MARK: - UI components
    private let sellCurrencyMenu: MenuView = MenuView()
    private let getCurrencyMenu: MenuView = MenuView()
   
    private let textViewPlaceholder: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.9
        view.layer.borderColor = R.Colors.active.cgColor
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
   
    private let changeDirectionButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.red, for: .normal)
        button.tintColor = .green
        button.setBackgroundImage(UIImage(systemName: "arrow.down"), for: .normal)
        button.addTarget(self, action: #selector(changeDirection), for: .touchUpInside)
        return button
    }()
    
    private let quantityTextView: UITextField = {
        let textView = UITextField()
        textView.keyboardType = .decimalPad
        textView.returnKeyType = .go
        textView.placeholder = "0.0"
        textView.textColor = .black
        textView.font = Resources.Fonts.helveticaBold(with: 30)
        return textView
    }()
    
    private let totalsLabel: UILabel = {
       let label = UILabel()
        label.font = Resources.Fonts.helveticaBold(with: 27)
        label.textAlignment = .center
        label.textColor = .darkGray
        label.layer.borderWidth = 1.2
        label.layer.borderColor = Resources.Colors.active.cgColor
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.text = "0.0"
        label.numberOfLines = 0
       return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        layoutViews()
        configure()
        setupMenues()
        setupDalegates()
        addDoneButtonOnKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        quantityTextView.becomeFirstResponder()
    }
    
    // MARK: - Initial setup
    private func setupDalegates() {
        presenter?.delegate = self
        quantityTextView.delegate = self
    }
   
    private func setupMenues() {
        sellCurrencyMenu.tag = 0
        getCurrencyMenu.tag = 1
        
        sellCurrencyMenu.dataSource = presenter?.dataSource ?? []
        getCurrencyMenu.dataSource = presenter?.dataSource ?? []
       
        sellCurrencyMenu.delegate = self
        getCurrencyMenu.delegate = self
    }
    
    private func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
    }
    // MARK: - Actions
    @objc
    private func changeDirection() {
        presenter?.changeDirectionAndConvert()
    }
    
    private func showAlert(title: String, info: String) {
        let alertController = UIAlertController(title: title,
                                                message: info,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            alertController.dismiss(animated: true)
        }

        alertController.addAction(okAction)

        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
    
    @objc private func doneButtonAction(){
        if let amount = quantityTextView.text {
            presenter?.changeAmount(value: amount)
            presenter?.convert()
        }
        quantityTextView.resignFirstResponder()
    }
    
}

// MARK: - TextFieldDelegate
extension CCViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let amount = textField.text {
            presenter?.changeAmount(value: amount)
            presenter?.convert()
        }
        return true
    }
}

// MARK: - BaseController overrides extension
extension CCViewController {
    override func addViews() {
        super.addViews()
        view.addView(changeDirectionButton)
        view.addView(textViewPlaceholder)
        view.addView(totalsLabel)
        textViewPlaceholder.addView(quantityTextView)
        view.addView(sellCurrencyMenu)
        view.addView(getCurrencyMenu)
        
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            textViewPlaceholder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            textViewPlaceholder.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textViewPlaceholder.widthAnchor.constraint(equalToConstant: 100),
            textViewPlaceholder.heightAnchor.constraint(equalToConstant: 100),
            
            quantityTextView.leadingAnchor.constraint(equalTo: textViewPlaceholder.leadingAnchor, constant: 10),
            quantityTextView.trailingAnchor.constraint(equalTo: textViewPlaceholder.trailingAnchor, constant: -5),
            quantityTextView.topAnchor.constraint(equalTo: textViewPlaceholder.topAnchor, constant: 5),
            quantityTextView.bottomAnchor.constraint(equalTo: textViewPlaceholder.bottomAnchor, constant: -5),
            
            sellCurrencyMenu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            sellCurrencyMenu.leadingAnchor.constraint(equalTo: textViewPlaceholder.leadingAnchor, constant: 110),
            sellCurrencyMenu.widthAnchor.constraint(equalToConstant: 130),
            
            getCurrencyMenu.topAnchor.constraint(equalTo: sellCurrencyMenu.bottomAnchor, constant: 20),
            getCurrencyMenu.leadingAnchor.constraint(equalTo: textViewPlaceholder.leadingAnchor, constant: 110),
            getCurrencyMenu.widthAnchor.constraint(equalToConstant: 130),
            
            changeDirectionButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            changeDirectionButton.leadingAnchor.constraint(equalTo: getCurrencyMenu.leadingAnchor, constant: 150),
            changeDirectionButton.widthAnchor.constraint(equalToConstant: 60),
            changeDirectionButton.heightAnchor.constraint(equalToConstant: 100),
   
            totalsLabel.topAnchor.constraint(equalTo: quantityTextView.bottomAnchor, constant: 20),
            totalsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            totalsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            totalsLabel.heightAnchor.constraint(equalToConstant: 100)
            
        ])
    }
    
    override func configure() {
        super.configure()
        title = "Converter"
        navigationController?.tabBarItem.title = "Converter"
    }
}

// MARK: - DropDownButtonDelegate
extension CCViewController: DropDownButtonDelegate {
    
    func didSelect(_ index: Int, tag: Int) {
        guard let amount = quantityTextView.text else {
            showAlert(title: "Data processing", info: "Enter ammount!")
            return
        }
        
        if let source = presenter?.dataSource, let code = Currency(rawValue: source[index])?.rawValue {
            if tag == 0 {
                self.sellCurrencyMenu.title = countryFlag(countryCode: code)
            } else {
                self.getCurrencyMenu.title = countryFlag(countryCode: code)
            }
        }
        
        presenter?.currencyChoosen(index: index, tag: tag, amount: amount)
    }
}

// MARK: - ConverterPresenterDelegate
extension CCViewController: ConverterPresenterDelegate {
    func displayResult(title: String, error: Error?) {
        DispatchQueue.main.async {
            if let error = error {
                self.showAlert(title: "Network error", info: error.localizedDescription)
                return
            }
            self.totalsLabel.text = title
        }
    }
    
    func changeDirectionButtonImage(name: String) {
        changeDirectionButton.setBackgroundImage(UIImage(systemName: name), for: .normal)
    }
    
    func displayAlert(title: String, info: String) {
        showAlert(title: title, info: info)
    }
    
    func startLoading() {
        DispatchQueue.main.async {
            self.addChild(self.spinner)
            self.spinner.view.frame = self.totalsLabel.frame
            self.view.addSubview(self.spinner.view)
            self.spinner.didMove(toParent: self)
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.spinner.willMove(toParent: nil)
            self.spinner.view.removeFromSuperview()
            self.spinner.removeFromParent()
        }
    }
}
