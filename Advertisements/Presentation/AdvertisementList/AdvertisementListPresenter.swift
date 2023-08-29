//
//  AdvertisementListPresenter.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 27.08.2023.
//

import Foundation

protocol AdvertisementListViewOutput: AnyObject {
    func viewDidLoad()
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
        advertisementListService.requestAdvertismentList { result in
            switch result {
            case .success(let adverisements):
                for adverisement in adverisements {
                    guard let imageUrl = URL(string: adverisement.imageUrl) else {
                        continue
                    }
                    
                    let date = self.convertedDate(string: adverisement.createdDate)
            
                    self.dataSource.advertesementListCells.append(
                        AdvertesementListViewModel(
                            title: adverisement.title,
                            price: adverisement.price,
                            location: adverisement.location,
                            imageUrl: imageUrl,
                            date: date
                        )
                    )
                }
            case .failure(let error):
                self.handleError(error)
            }
        }
    }
    
    private func convertedDate(string: String) -> String{
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
        view?.showAlert(title: error.title, completion: {
            self.requestAdvertisemets()
        })
    }
}

// MARK: - AdvertisementListViewOutput

extension AdvertisementListPresenter: AdvertisementListViewOutput {
    func viewDidLoad() {
        setDataSource()
        requestAdvertisemets()
    }
}
