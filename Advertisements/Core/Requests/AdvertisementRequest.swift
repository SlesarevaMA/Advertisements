//
//  AdvertisementRequest.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 25.08.2023.
//

import Foundation

struct AdvertisementRequest: Request {
    private let itemId: Int
    
    init(itemId: Int) {
        self.itemId = itemId
    }
    
    var urlRequest: URLRequest {
        var urlComponents = baseUrlComponents
        urlComponents.path += "/details"
        
        urlComponents.path += "/\(itemId).json"
        
        guard let url = urlComponents.url else {
            fatalError("Unable to create advertisment url")
        }
        
        return URLRequest(url: url)
    }
}
