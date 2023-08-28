//
//  DataSource.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 27.08.2023.
//

import UIKit

protocol DataSource: UICollectionViewDataSource {
    var advertesementListCells: [AdvertesementListViewModel] { get set }
}

final class DataSourceImpl: NSObject {
    var advertesementListCells = [AdvertesementListViewModel]()
}

// MARK: - DataSource

extension DataSourceImpl: DataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return advertesementListCells.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: AdretisementsListCell = collectionView.dequeReusableCell(for: indexPath)
        let model = advertesementListCells[indexPath.item]
        
        cell.configure(with: model)
        
        return cell
    }
}
