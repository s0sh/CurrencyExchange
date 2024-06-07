//
//  ConverterInteractor.swift
//  CurEx
//
//  Created by Roman Bigun on 07.06.2024.
//

import Foundation

final class ConverterInteractor {
    
    let converter: ConverterSeerviceProtocol
    
    init(converter: ConverterSeerviceProtocol) {
        self.converter = converter
    }
    
    func convert(data: ExchangeModel, direction: ConvertDirection, completion: @escaping (String, Error?) -> Void) {
        
        converter.convert(data: data, completion: { result, error in
            
            if let error = error {
                completion("", error)
            }
            
            if let res = result {
                completion("\(res.amount) \(res.currency)", nil)
            }
        })
    }
}
