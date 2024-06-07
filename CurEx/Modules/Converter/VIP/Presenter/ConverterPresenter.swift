//
//  ConverterPresenter.swift
//  CurEx
//
//  Created by Roman Bigun on 07.06.2024.
//

import Foundation

protocol ConverterPresenterDelegate: AnyObject {
    func displayResult(title: String)
    func changeDirectionButtonImage(name : String)
    func displayAlert(title: String, info: String)
    
}

final class ConverterPresenter {
    
    var interactor: ConverterInteractor
    
    weak var delegate: ConverterPresenterDelegate?
    
    private var data: ExchangeModel = ExchangeModel(sell: .none, get: .none, ammount: "0")
    private var convertDirection: ConvertDirection = .forward
    
    var dataSource: [String] = []
    
    init(interactor: ConverterInteractor) {
        self.interactor = interactor
        prepareDataSource()
    }
    
    func changeDirectionAndConvert() {
        if convertDirection == .forward {
            convertDirection = .backward
            delegate?.changeDirectionButtonImage(name: "arrow.uturn.left.square.fill")
        } else {
            convertDirection = .forward
            delegate?.changeDirectionButtonImage(name: "arrow.uturn.right.square.fill")
        }
        
        if convertDirection == .backward {
           let sell = data.get
            data.get = data.sell
            data.sell = sell
        } else {
            let sell = data.sell
             data.sell = data.get
             data.get = sell
        }
        convert()
    }
    
    private func prepareDataSource() {
        for value in Currency.allCases {
            dataSource.append(value.rawValue)
        }
    }
    
    func currencyChoosen(index: Int, tag: Int, amount: String) {
        switch tag {
        case 0:
            data.sell = Currency(rawValue: dataSource[index])!
        case 1:
            data.get = Currency(rawValue: dataSource[index])!
        default:
            print("error")
        }
        
        if convertDirection == .backward {
           let sell = data.get
            data.get = data.sell
            data.sell = sell
        }

        data.ammount = amount
        convert()
    }
    
    func convert() {
        if data.get == .none || data.sell == .none { return }
        
        if data.ammount.isEmpty {
            delegate?.displayAlert(title: "Converter", info: "Ammount cannot be empty")
            return
        }
        
        interactor.convert(data: data,
                           direction: convertDirection) { result in
            self.delegate?.displayResult(title: result)
        }
    }
    
}
