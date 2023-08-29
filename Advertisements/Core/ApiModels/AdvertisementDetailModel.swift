//
//  AdvertisementDetailModel.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 29.08.2023.
//

struct AdvertisementDetailModel: Decodable {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageUrl: String
    let createdDate: String
    let description: String
    let email: String
    let phoneNumber: String
    let address: String
}
