//
//  AdvertisementListRequest.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 25.08.2023.
//

import Foundation

struct AdvertisementListRequest: Request {
    var urlRequest: URLRequest {
        var urlComponents = baseUrlComponents
        
        urlComponents.path += "main-page.json"
        
        guard let url = urlComponents.url else {
            fatalError("Unable to create advertisement list url")
        }
        
        return URLRequest(url: url)
    }
}
