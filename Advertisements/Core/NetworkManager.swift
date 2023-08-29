//
//  NetworkManager.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 24.08.2023.
//

import Foundation

protocol NetworkManager {
    func sendRequest(request: Request, completion: @escaping (Result<Data, RequestError>) -> (Void))
}

final class NetworkManagerImpl: NetworkManager {
    func sendRequest(request: Request, completion: @escaping (Result<Data, RequestError>) -> (Void)) {
        let dataTask = URLSession.shared.dataTask(with: request.urlRequest) { data, response, error in
            if (response as? HTTPURLResponse)?.statusCode == 200, let data {
                completion(.success(data))
            } else {
                completion(.failure(.download))
            }
        }
        
        dataTask.resume()
    }
}
