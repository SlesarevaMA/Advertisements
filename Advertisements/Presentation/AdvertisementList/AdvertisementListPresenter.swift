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
    
    private let inputDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter
    }()
    
    private let outputDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        formatter.locale = Locale(identifier: "ru_RUS")
        
        return formatter
    }()
    
    init(advertisementListService: AdvertisementListService, dataSource: AdvertisementListDataSource) {
        self.advertisementListService = advertisementListService
        self.dataSource = dataSource
    }
    
    private func setDataSource() {
        view?.setDataSource(dataSource)
    }
    
    private func requestAdvertisemets() {
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
            let date = self.convertedDate(string: model.createdDate)
            
            return AdvertesementListViewModel(
                id: Int(model.id) ?? -1,
                title: model.title,
                price: model.price,
                location: model.location,
                imageUrl: model.imageUrl,
                date: date
            )
        }
        
        DispatchQueue.main.async {
            self.dataSource.advertesementListViewModels = viewModels
            self.view?.reloadData()
        }
    }
    
    private func convertedDate(string: String) -> String {
        guard let date = self.inputDateFormatter.date(from: string) else {
            return ""
        }
        
        switch date {
        case Date():
            return "Сегодня"
        case Calendar.current.date(byAdding: .day, value: -1, to: Date()):
            return "Вчера"
        default:
            return outputDateFormatter.string(from: date)
        }
    }
    
    private func handleError(_ error: RequestError) {
        DispatchQueue.main.async {
            self.view?.showAlert(title: error.description, completion: {
                self.requestAdvertisemets()
            })
        }
    }
}

// MARK: - AdvertisementListViewOutput

extension AdvertisementListPresenter: AdvertisementListViewOutput {
    func viewDidLoad() {
        setDataSource()
        requestAdvertisemets()
    }
    
    func cellSelected(at index: Int) {
        let viewModel = dataSource.advertesementListViewModels[index]
        print(viewModel.title)
    }
    
}
