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
        
        networkManager.sendRequest(request: advertisementListRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let advertisementsListModel = try self.decoder.decode(AdvertisementsModel.self, from: data)
                    completion(.success(advertisementsListModel.advertisements))
                } catch {
                    completion(.failure(.parsError))
                }
            case .failure:
                completion(.failure(.download))
            }
        }
    }
}
