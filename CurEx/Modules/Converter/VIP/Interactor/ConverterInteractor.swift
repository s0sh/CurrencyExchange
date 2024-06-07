//
//  ConverterInteractor.swift
//  CurEx
//
//  Created by Roman Bigun on 07.06.2024.
//

import Foundation

struct ExchangeModel {
    var sell: Currency
    var get: Currency
    var ammount: String
}

enum ConvertDirection {
    case forward
    case backward
}

final class ConverterInteractor {
    
    let converter: ConverterSeerviceProtocol
    
    init(converter: ConverterSeerviceProtocol) {
        self.converter = converter
    }
    
    func convert(data: ExchangeModel, direction: ConvertDirection, completion: @escaping (String) -> Void) {
        
        converter.convert(data: data, completion: { result, error in
            
            if let error = error {
                completion("Network error: \(error.localizedDescription)")
            }
            
            if let res = result {
                completion("\(res.amount) \(res.currency)")
            }
        })
    }
}
