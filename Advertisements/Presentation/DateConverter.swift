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
    private let inputDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter
    }()
    
    private let outputDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        formatter.locale = Locale(identifier: "ru_RUS")
        
        return formatter
    }()
    
    func convertedDate(string: String) -> String {
        guard let date = self.inputDateFormatter.date(from: string) else {
            return ""
        }
        
        switch date {
        case Date():
            return "Сегодня"
        case Calendar.current.date(byAdding: .day, value: -1, to: Date()):
            return "Вчера"
        default:
            return outputDateFormatter.string(from: date)
        }
    }
}
