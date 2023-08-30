//
//  AdvertisementPresenter.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 29.08.2023.
//

import Foundation

protocol AdvertisementViewOutput: AnyObject {
    func viewDidLoad()
}

final class AdvertisementPresenter {
    weak var view: AdvertisementViewInput?
    
    private let advertisementService: AdvertisementService
    private var advertisementId: Int?
    
    private var advertesementViewModels = [AdvertisementDetailModel]()
    
    init(advertisementService: AdvertisementService) {
        self.advertisementService = advertisementService
    }
    
    func configure(with id: Int) {
        advertisementId = id
    }
    
    private func requestAdvertisement() {
        advertisementService.requestAdvertisement(advertisementId: advertisementId) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let model):
                self.advertesementViewModels.append(model)
            case .failure(let error):
                self.handleError(error)
            }
        }
    }
    
    private func handleError(_ error: RequestError) {
        DispatchQueue.main.async {
            self.view?.showAlert(title: error.description, completion: {
                self.requestAdvertisement()
            })
        }
    }

}

// MARK: - AdvertisementViewOutput

extension AdvertisementPresenter: AdvertisementViewOutput {
    func viewDidLoad() {
        requestAdvertisement()
        getModel(for: advertisementId)
    }
    
    private func getModel(for id: Int?) {
        if let id {
            if id > advertesementViewModels.count {
                requestAdvertisement()
            } else {
                view?.setModel(advertesementViewModels[id])

            }
        }
    }
}
