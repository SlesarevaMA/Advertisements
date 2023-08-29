//
//  RequestError.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 28.08.2023.
//

enum RequestError: Error {
    case download
    case parse
    
    var description: String {
        switch self {
        case .download:
            return "Download fail"
        case .parse:
            return "Parse fail"
        }
    }
}
