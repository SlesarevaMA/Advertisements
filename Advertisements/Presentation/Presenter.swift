//
//  Presenter.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 27.08.2023.
//

import Foundation

protocol Presenter {
    
}

final class PresenterImpl: Presenter {
    
    private let advertisementListService: AdvertisementListService
    private let dataSource: DataSource
    
    init(advertisementListService: AdvertisementListService, dataSource: DataSource) {
        self.advertisementListService = advertisementListService
        self.dataSource = dataSource
    }
    
    func requestAdvertisemets() {
        advertisementListService.requestAdvertismentList { adverisementArray in
//            let advertesementListCells = 
//            dataSource.advertesementListCells = adverisementArray
        }
    }

}
