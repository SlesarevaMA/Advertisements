//
//  SceneDelegate.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 24.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private var router: AdvertisementsRouter?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let factory = AdvertisementViewControllerFactoryImpl()
        let navigationController = UINavigationController()
        let router = AdvertisementsRouterImpl(factory: factory, navigationController: navigationController)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        router.showAdvertisementListView()
    }
}
