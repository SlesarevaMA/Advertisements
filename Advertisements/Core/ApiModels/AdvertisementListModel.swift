//
//  AdvertisementListModel.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 25.08.2023.
//

import Foundation

struct AdvertisementListModel: Decodable {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageUrl: URL
    let createdDate: String
}
