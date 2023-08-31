//
//  AdvertisementViewControllerFactory.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 29.08.2023.
//

import UIKit

protocol AdvertisementViewControllerFactory: AnyObject {
    func makeAdvetisementListViewController(router: AdvertisementsRouter) -> UIViewController
    func makeAdvetisementViewController(router: AdvertisementsRouter) -> (UIViewController, AdvertisementPresenter)
}

final class AdvertisementViewControllerFactoryImpl: AdvertisementViewControllerFactory {
    private let networkManager: NetworkManager = NetworkManagerImpl()
    private let decoder = AdvertisementsDecoder()
    private let dateConverter: DateConverter = DateConverterImpl()
    
    func makeAdvetisementListViewController(router: AdvertisementsRouter) -> UIViewController {
        let service: AdvertisementListService = AdvertisementListServiceImpl(
            networkManager: networkManager,
            decoder: decoder
        )
        let dataSource: AdvertisementListDataSource = AdvertisementListDataSourceImpl()
        let presenter = AdvertisementListPresenter(
            advertisementListService: service,
            dataSource: dataSource,
            router: router,
            dateConverter: dateConverter
        )
        let advertisementListViewController = AdvertisementListViewController(output: presenter)
        presenter.view = advertisementListViewController
        
        return advertisementListViewController
    }
    
    func makeAdvetisementViewController(router: AdvertisementsRouter) -> (UIViewController, AdvertisementPresenter) {
        let service: AdvertisementService = AdvertisementServiceImpl(networkManager: networkManager, decoder: decoder)
        let presenter = AdvertisementPresenter(
            advertisementService: service,
            router: router,
            dateConverter: dateConverter
        )
        let advetisementViewController = AdvertisementViewController(output: presenter)
        presenter.view = advetisementViewController
        
        return (advetisementViewController, presenter)
    }
}
