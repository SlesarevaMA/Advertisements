//
//  AdvertisementListPresenter.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 27.08.2023.
//

import Foundation

protocol AdvertisementListViewOutput: AnyObject {
    func viewDidLoad()
}

final class AdvertisementListPresenter {
    
    weak var view: AdvertisementListViewInput?
    
    private let advertisementListService: AdvertisementListService
    private let dataSource: AdvertisementListDataSource
    
    init(advertisementListService: AdvertisementListService, dataSource: AdvertisementListDataSource) {
        self.advertisementListService = advertisementListService
        self.dataSource = dataSource
    }
    
    private func setDataSource() {
        view?.setDataSource(dataSource)
    }
    
    private func requestAdvertisemets() {
        advertisementListService.requestAdvertismentList { adverisementArray in
            for adverisement in adverisementArray {
                guard let imageUrl = URL(string: adverisement.imageUrl) else {
                    continue
                }
                
                self.dataSource.advertesementListCells.append(
                    AdvertesementListViewModel(
                        title: adverisement.title,
                        price: adverisement.price,
                        location: adverisement.location,
                        imageUrl: imageUrl,
                        date: adverisement.createdDate
                    )
                )
            }
        }
    }
}

// MARK: - AdvertisementListViewOutput

extension AdvertisementListPresenter: AdvertisementListViewOutput {
    func viewDidLoad() {
        setDataSource()
        requestAdvertisemets()
    }
}
