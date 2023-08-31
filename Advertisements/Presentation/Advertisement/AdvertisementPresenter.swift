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
    private let router: AdvertisementsRouter
    private let dateConverter: DateConverter
    
    private var advertesementViewModel: AdvertisementDetailModel?
    
    init(advertisementService: AdvertisementService, router: AdvertisementsRouter, dateConverter: DateConverter) {
        self.advertisementService = advertisementService
        self.router = router
        self.dateConverter = dateConverter
    }
    
    func configure(with id: Int) {
        advertisementId = id
    }
    
    private func requestAdvertisement() {
        guard let advertisementId else { return }
        
        advertisementService.requestAdvertisement(advertisementId: advertisementId) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let model):
                self.processAdverisement(model)
            case .failure(let error):
                self.handleError(error)
            }
        }
    }
    
    private func processAdverisement(_ adverisement: AdvertisementDetailModel) {
        let date = dateConverter.convertedDate(string: adverisement.createdDate)
        advertesementViewModel = AdvertisementDetailModel(
            id: adverisement.id,
            title: adverisement.title,
            price: adverisement.price,
            location: adverisement.location,
            imageUrl: adverisement.imageUrl,
            createdDate: date,
            description: adverisement.description,
            email: adverisement.email,
            phoneNumber: adverisement.phoneNumber,
            address: adverisement.address
        )
        
        getModel()
    }
        
    private func handleError(_ error: RequestError) {
        DispatchQueue.main.async {
            self.router.showAlert(title: error.description, completion: {
                self.requestAdvertisement()
            })
        }
    }
}

// MARK: - AdvertisementViewOutput

extension AdvertisementPresenter: AdvertisementViewOutput {
    func viewDidLoad() {
        requestAdvertisement()
    }
    
    private func getModel() {
        if let advertesementViewModel {
            DispatchQueue.main.async {
                self.view?.setModel(advertesementViewModel)
            }
        }
    }
}
