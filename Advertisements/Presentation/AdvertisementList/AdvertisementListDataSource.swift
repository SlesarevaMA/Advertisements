//
//  AdvertisementListDataSource.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 27.08.2023.
//

import UIKit

protocol AdvertisementListDataSource: UICollectionViewDataSource {
    var advertesementListViewModels: [AdvertesementListViewModel] { get set }
}

final class AdvertisementListDataSourceImpl: NSObject {
    var advertesementListViewModels = [AdvertesementListViewModel]()
}

// MARK: - DataSource

extension AdvertisementListDataSourceImpl: AdvertisementListDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return advertesementListViewModels.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: AdretisementsListCell = collectionView.dequeReusableCell(for: indexPath)
        let model = advertesementListViewModels[indexPath.item]
        
        cell.configure(with: model)
        
        return cell
    }
}
