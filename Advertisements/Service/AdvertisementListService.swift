//
//  AdvertisementListService.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 25.08.2023.
//

import Foundation

protocol AdvertisementListService {
    func requestAdvertismentList(completion: @escaping ([AdvertisementListModel]) -> Void)
}

final class AdvertisementListServiceImpl: AdvertisementListService {
    private let networkManager: NetworkManager
    private let decoder: AdvertisementsDecoder
    
    init(networkManager: NetworkManager, decoder: AdvertisementsDecoder) {
        self.networkManager = networkManager
        self.decoder = decoder
    }
    
    func requestAdvertismentList(completion: @escaping ([AdvertisementListModel]) -> Void) {
        let advertisementListRequest = AdvertisementListRequest()
        
        networkManager.sendRequest(request: advertisementListRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let advertisementsListModel = try self.decoder.decode(AdvertisementsModel.self, from: data)
                    completion(advertisementsListModel.advertisements)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
