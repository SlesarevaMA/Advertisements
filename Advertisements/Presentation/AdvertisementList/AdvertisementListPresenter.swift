//
//  AdvertisementListPresenter.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 27.08.2023.
//

import Foundation

protocol AdvertisementListViewOutput: AnyObject {
    func viewDidLoad()
    func cellSelected(at index: Int)
}

final class AdvertisementListPresenter {
    
    weak var view: AdvertisementListViewInput?
    
    private let advertisementListService: AdvertisementListService
    private let dataSource: AdvertisementListDataSource
    private let router: AdvertisementsRouter
    private let dateConverter: DateConverter
        
    init(
        advertisementListService: AdvertisementListService,
        dataSource: AdvertisementListDataSource,
        router: AdvertisementsRouter,
        dateConverter: DateConverter
    ) {
        self.advertisementListService = advertisementListService
        self.dataSource = dataSource
        self.router = router
        self.dateConverter = dateConverter
    }
    
    private func setDataSource() {
        view?.setDataSource(dataSource)
    }
    
    private func requestAdvertisements() {
        advertisementListService.requestAdvertismentList { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let adverisements):
                self.processAdverisements(adverisements)
            case .failure(let error):
                self.handleError(error)
            }
        }
    }
    
    private func processAdverisements(_ adverisements: [AdvertisementListModel]) {
        let viewModels = adverisements.map { model in
            let date = self.dateConverter.convertedDate(string: model.createdDate)
            
            return AdvertisementListModel(
                id: model.id,
                title: model.title,
                price: model.price,
                location: model.location,
                imageUrl: model.imageUrl,
                createdDate: date
            )
        }
        
        DispatchQueue.main.async {
            self.dataSource.advertesementListViewModels = viewModels
            self.view?.reloadData()
        }
    }
    
    private func handleError(_ error: RequestError) {
        DispatchQueue.main.async {
            self.router.showAlert(title: error.description, completion: {
                self.requestAdvertisements()
            })
        }
    }
}

// MARK: - AdvertisementListViewOutput

extension AdvertisementListPresenter: AdvertisementListViewOutput {
    func viewDidLoad() {
        setDataSource()
        requestAdvertisements()
    }
    
    func cellSelected(at index: Int) {
        let viewModel = dataSource.advertesementListViewModels[index]
        router.showAdvertisementView(with: Int(viewModel.id) ?? -1)
    }
}
