//
//  ServiceLayer.swift
//  PayPayCurrencyConverter
//
//  Created by Victor Hideo Oka on 23/12/22.
//

import Foundation

protocol CurrencyConverterServiceProtocol {
    func request<T: Codable>(router: Router, completion: @escaping (Result<T, Error>) -> ())
}

final class ServiceLayer: CurrencyConverterServiceProtocol {
    
    static let shared = ServiceLayer()
    
    private init() {}
    
    func request<T: Codable>(router: Router, completion: @escaping (Result<T, Error>) -> ()) {
        
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters
        
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            if let err = error {
                completion(.failure(err))
                print(err.localizedDescription)
                return
            }
            
            guard response != nil, let data = data else {
                return
            }
            
            let responseObject = try! JSONDecoder().decode(T.self, from: data)
            DispatchQueue.main.async {
                completion(.success(responseObject))
            }
        }
        dataTask.resume()
    }
    
}
