//
//  AdvertisementViewControllerFactory.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 29.08.2023.
//

import UIKit

protocol AdvertisementViewControllerFactory: AnyObject {
    func makeAdvetisementListViewController(router: AdvertisementsRouter) -> UIViewController
    func makeAdvetisementViewController() -> (UIViewController, AdvertisementPresenter)
}

final class AdvertisementViewControllerFactoryImpl: AdvertisementViewControllerFactory {
    private let networkManager: NetworkManager = NetworkManagerImpl()
    private let decoder = AdvertisementsDecoder()
    
    func makeAdvetisementListViewController(router: AdvertisementsRouter) -> UIViewController {
        let service: AdvertisementListService = AdvertisementListServiceImpl(
            networkManager: networkManager,
            decoder: decoder
        )
        let dataSource: AdvertisementListDataSource = AdvertisementListDataSourceImpl()
        let presenter = AdvertisementListPresenter(
            advertisementListService: service,
            dataSource: dataSource,
            router: router
        )
        let masterViewController = AdvertisementListViewController(output: presenter)
        presenter.view = masterViewController
        
        return masterViewController
    }
    
    func makeAdvetisementViewController() -> (UIViewController, AdvertisementPresenter) {
        let service: AdvertisementService = AdvertisementServiceImpl(networkManager: networkManager, decoder: decoder)
        let presenter = AdvertisementPresenter(advertisementService: service)
        let advetisementViewController = AdvertisementViewController(output: presenter)
        presenter.view = advetisementViewController
        
        return (advetisementViewController, presenter)
    }
}
