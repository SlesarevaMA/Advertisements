//
//  Request.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 24.08.2023.
//

import Foundation

protocol Request {
    var urlRequest: URLRequest { get }
}

extension Request {
    var baseUrlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.avito.st"
        urlComponents.path = "s"
        urlComponents.path += "interns-ios"
        
        return urlComponents
    }
}
