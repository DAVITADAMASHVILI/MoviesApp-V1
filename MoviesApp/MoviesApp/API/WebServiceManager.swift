//
//  WebServiceManager.swift
//  MoviesApp
//
//  Created by DATA on 10/12/20.
//  Copyright © 2020 SPACE. All rights reserved.
//

import Foundation

class WebServiceManager {
    
    public static let shared = WebServiceManager()
    public let apiKey = "00ee9c016ec6240c3b97acbfa80af4fe"
    private init() {}
    
    typealias CompletionBlock<T: Codable> = (Result<T, Error>) -> ()
    
    enum HTTPMethod {
        case GET
        case POST
    }
    
    func get<T: Codable>(url: String, completion: @escaping CompletionBlock<T>) {
        guard let url = URL(string: url) else {return}
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, res, err) in
            
            if let err = err {
                completion(.failure(err))
            }
            
            do {
                guard let data = data else {return}
                let decoder = JSONDecoder()
                let decoded = try decoder.decode(T.self, from: data)
                
                completion(.success(decoded))
            } catch let err {
                completion(.failure(err))
            }
            
        }.resume()
    }
}
