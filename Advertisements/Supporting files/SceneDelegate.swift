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
        
        let dataSource = Adver
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = AdvertisementListViewController()
        window?.makeKeyAndVisible()
    }
}
