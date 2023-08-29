//
//  AdvertisementPresenter.swift
//  Advertisements
//
//  Created by Margarita Slesareva on 29.08.2023.
//

import Foundation

protocol AdvertisementViewOutput: AnyObject {
    
}

final class AdvertisementPresenter {
    
    weak var view: AdvertisementViewInput?
}
