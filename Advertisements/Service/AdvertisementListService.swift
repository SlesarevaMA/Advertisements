//
//  AdvertisementListService.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 25.08.2023.
//

import Foundation

protocol AdvertisementListService {
    func requestAdvertismentList(completion: @escaping (Result<[AdvertisementListModel], RequestError>) -> Void)
}

final class AdvertisementListServiceImpl: AdvertisementListService {
    private let networkManager: NetworkManager
    private let decoder: AdvertisementsDecoder
    
    init(networkManager: NetworkManager, decoder: AdvertisementsDecoder) {
        self.networkManager = networkManager
        self.decoder = decoder
    }
    
    func requestAdvertismentList(completion: @escaping (Result<[AdvertisementListModel], RequestError>) -> Void) {
        let advertisementListRequest = AdvertisementListRequest()
        
        networkManager.sendRequest(request: advertisementListRequest) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                completion(self.parseModel(for: data))
            case .failure:
                completion(.failure(.download))
            }
        }
    }
    
    private func parseModel(for data: Data) -> Result<[AdvertisementListModel], RequestError> {
        do {
            let advertisementsListModel = try decoder.decode(AdvertisementsModel.self, from: data)
            return .success(advertisementsListModel.advertisements)
        } catch {
            return .failure(.parse)
        }
    }
}
