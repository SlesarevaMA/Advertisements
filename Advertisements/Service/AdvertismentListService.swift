//
//  AdvertismentListService.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 25.08.2023.
//

import Foundation

protocol AdvertismentListService {
    func requestAdvertismentList(completion: @escaping ([AdvertisementModel]) -> Void)
}

final class AdvertismentListServiceImpl: AdvertismentListService {
    private let networkManager: NetworkManager
    private let decoder: AdvertisementsDecoder
    
    init(networkManager: NetworkManager, decoder: AdvertisementsDecoder) {
        self.networkManager = networkManager
        self.decoder = decoder
    }
    
    func requestAdvertismentList(completion: @escaping ([AdvertisementModel]) -> Void) {
        let advertisementListRequest = AdvertisementListRequest()
        
        networkManager.sendRequest(request: advertisementListRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let advertisementsListModel = try self.decoder.decode(AdvertisementsListModel.self, from: data)
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
