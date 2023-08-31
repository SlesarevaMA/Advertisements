//
//  AdvertisementService.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 29.08.2023.
//

import Foundation

protocol AdvertisementService {
    func requestAdvertisement(
        advertisementId: Int,
        completion: @escaping (Result<AdvertisementDetailModel, RequestError>) -> Void
    )
}

final class AdvertisementServiceImpl: AdvertisementService {
    private let networkManager: NetworkManager
    private let decoder: AdvertisementsDecoder
    
    init(networkManager: NetworkManager, decoder: AdvertisementsDecoder) {
        self.networkManager = networkManager
        self.decoder = decoder
    }
    
    func requestAdvertisement(
        advertisementId: Int,
        completion: @escaping (Result<AdvertisementDetailModel, RequestError>) -> Void
    ) {
        let request = AdvertisementRequest(itemId: advertisementId)
        networkManager.sendRequest(request: request) { [weak self] result in
            
            guard let self else { return }
            
            switch result {
            case .success(let data):
                completion(self.parseModel(for: data))
            case .failure:
                completion(.failure(.download))
            }
        }
    }
    
    private func parseModel(for data: Data) -> Result<AdvertisementDetailModel, RequestError> {
        do {
            let advertisementDetailModel = try decoder.decode(AdvertisementDetailModel.self, from: data)
            
            return .success(advertisementDetailModel)
        } catch {
            return .failure(.parse)
        }
    }
}
