//
//  AdvertisementsRouter.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 30.08.2023.
//

import UIKit

protocol AdvertisementsRouter: AnyObject {
    func showAdvertisementListView()
    func showAdvertisementView(with id: Int)
}

final class AdvertisementsRouterImpl: AdvertisementsRouter {
    
    private let factory: AdvertisementViewControllerFactory
    private let navigationController: UINavigationController
    
    init(factory: AdvertisementViewControllerFactory, navigationController: UINavigationController) {
        self.factory = factory
        self.navigationController = navigationController
    }
    
    func showAdvertisementListView() {
        let view = factory.makeAdvetisementListViewController(router: self)
        navigationController.setViewControllers([view], animated: false)
    }
    
    func showAdvertisementView(with id: Int) {
        let (view, presenter) = factory.makeAdvetisementViewController()
        presenter.configure(with: id)
        navigationController.pushViewController(view, animated: true)
    }
    
    func showAlert() {
        
    }
}
