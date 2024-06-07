//
//  ConverterCervice.swift
//  CurEx
//
//  Created by Roman Bigun on 06.06.2024.
//

import Foundation
import Combine

fileprivate var basePath = "http://api.evp.lt/currency/commercial/exchange/"

struct ResultModel: Decodable {
    let amount: String
    let currency: String
}

enum ConverterError: String, Error {
    case invalidURL = "Something is wrong with the url provided (Format)"
    case requestFailed = "Request failed"
}

protocol ConverterSeerviceProtocol {
    func convert(data: ExchangeModel,
                 completion: @escaping (ResultModel?, Error?) -> Void )
}

final class ConverterService: ConverterSeerviceProtocol {
    
    
    private var storage = Set<AnyCancellable>()
    private let session = URLSession.shared
    
    func convert(data: ExchangeModel,
                 completion: @escaping (ResultModel?, Error?) -> Void) {
        
        var result: ResultModel?
        
        guard let url = URL(string: basePath + "\(data.ammount)-\(data.sell.rawValue)/\(data.get.rawValue)/latest") else {
            completion(nil, "Invalid URL" as! Error)
            return
        }
        
        let request = URLRequest(url: url)
        
        session.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: ResultModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: {
                switch $0 {
                case .failure(let error):
                    completion(nil, error)
                case .finished:
                    print("Network: Completed with success")
                }
            },
             receiveValue: {
                print($0)
                result = $0
                completion(result, nil)
            }).store(in: &storage)
    }
   
}
