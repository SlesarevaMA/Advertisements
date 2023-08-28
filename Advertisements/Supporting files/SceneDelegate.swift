//
//  SceneDelegate.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 24.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let networkManager = NetworkManagerImpl()
        let decoder = AdvertisementsDecoder()
        let service = AdvertisementListServiceImpl(networkManager: networkManager, decoder: decoder)
        
        let dataSource = AdvertisementListDataSourceImpl()
        let presenter = AdvertisementListPresenter(advertisementListService: service, dataSource: dataSource)
        let view = AdvertisementListViewController(output: presenter)
        presenter.view = view
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = view
        window?.makeKeyAndVisible()
    }
}
