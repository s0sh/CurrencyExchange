//
//  ConverterCervice.swift
//  CurEx
//
//  Created by Roman Bigun on 06.06.2024.
//

import Foundation
import Combine

struct ResultModel: Decodable {
    let amount: String
    let currency: String
}

enum ConverterError: String, Error {
    case damagedUrl = "Something is wrong with the url provided (Format)"
    case wrongCurrency = "Currency is not supported"
}

protocol ConverterSeerviceProtocol {
    func convert(data: ExchangeModel,
                 completion: @escaping (ResultModel?, ConverterError?) -> Void )
}

final class ConverterService: ConverterSeerviceProtocol {
    
    private var basePath = "http://api.evp.lt/currency/commercial/exchange/"
    private var storage = Set<AnyCancellable>()
    private let session = URLSession.shared
    
    func convert(data: ExchangeModel,
                 completion: @escaping (ResultModel?, ConverterError?) -> Void) {
        
        var result: ResultModel?
        
        guard let url = URL(string: basePath + "\(data.ammount)-\(data.sell.rawValue)/\(data.get.rawValue)/latest") else {
            completion(nil, .damagedUrl)
            return
        }
        
        let request = URLRequest(url: url)
        
        session.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: ResultModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { print($0) },
             receiveValue: {
                print($0)
                result = $0
                completion(result, nil)
            }).store(in: &storage)
    }
   
}
