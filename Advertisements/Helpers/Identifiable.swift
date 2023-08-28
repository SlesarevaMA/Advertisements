//
//  Identifiable.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 27.08.2023.
//

protocol Identifiable {
    static var reuseIdentifier: String { get }
}

extension Identifiable {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
