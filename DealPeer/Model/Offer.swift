//
//  File.swift
//  DealPeer
//
//  Created by Artem Katlenok on 27/05/2018.
//  Copyright © 2018 Artem Katlenok. All rights reserved.
//

import Foundation
import CoreLocation

enum Language {
    case russian(String)
    case english(String)
}

enum OfferType {
    case sale(String)
    case rent(String)
}

struct Offer {
    
    let identifier: String
    let name: [Language]
    let description: [Language]
    let category: String
    let offerType: OfferType
    let userIdentifier: String
    let properties: String
    let coordinates: CLLocationCoordinate2D
}


