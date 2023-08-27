//
//  NetworkManager.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 24.08.2023.
//

import Foundation

protocol NetworkManager {
    func sendRequest(request: Request, completion: @escaping (Result<Data, Error>) -> (Void))
}

final class NetworkManagerImpl: NetworkManager {
    func sendRequest(request: Request, completion: @escaping (Result<Data, Error>) -> (Void)) {
        let dataTask = URLSession.shared.dataTask(with: request.urlRequest) { data, response, error in
            if (response as? HTTPURLResponse)?.statusCode == 200 {
                if let data {
                    completion(.success(data))
                }
            } else if let error {
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
    }
}
