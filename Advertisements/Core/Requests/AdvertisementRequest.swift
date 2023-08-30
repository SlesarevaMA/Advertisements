//
//  AdvertisementRequest.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 25.08.2023.
//

import Foundation

struct AdvertisementRequest: Request {
    var itemId: Int?
    
    var urlRequest: URLRequest {
        var urlComponents = baseUrlComponents
        urlComponents.path += "details"
        
        guard let itemId else {
            fatalError("Unable to get advertisment Id")
        }
        
        urlComponents.path += "\(itemId).json"
        
        guard let url = urlComponents.url else {
            fatalError("Unable to create advertisment url")
        }
        
        return URLRequest(url: url)
    }
}
