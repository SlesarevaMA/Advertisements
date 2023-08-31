//
//  DateConverter.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 31.08.2023.
//

import Foundation

protocol DateConverter {
    func convertedDate(string: String) -> String
}

final class DateConverterImpl: DateConverter {
    private let inputDateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = .withFullDate
        
        return formatter
    }()
    
    private let outputDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.doesRelativeDateFormatting = true
        formatter.locale = Locale(identifier: "ru_RU")
        
        return formatter
    }()
    
    func convertedDate(string: String) -> String {
        guard let date = inputDateFormatter.date(from: string) else {
            return ""
        }
        
        return outputDateFormatter.string(from: date)
    }
}
