//
//  AdvertisementModel.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 25.08.2023.
//

struct AdvertisementModel: Decodable {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageUrl: String
    let createdDate: String
}
