//
//  UICollectionView+.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 27.08.2023.
//

import UIKit

extension UICollectionView {
    func register<T: Identifiable>(cell: T.Type) {
        register(T.self as? AnyClass, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeReusableCell<T: Identifiable>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(T.self) for indexPath: \(indexPath)")
        }
        
        return cell
    }
}
