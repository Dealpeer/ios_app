//
//  File.swift
//  DealPeer
//
//  Created by Artem Katlenok on 27/05/2018.
//  Copyright © 2018 Artem Katlenok. All rights reserved.
//

import Foundation
import CoreLocation

struct Language: Codable {
    let language: String
    let caption: String

    enum CodingKeys: String, CodingKey {
        case language
        case caption = "text"
    }
}

struct SearchResult: Codable {
    let state: Int
    let identifier: String
    let name: [Language]
    let properties: [String: AnyCodable]
    let coordinates: [Double]
    let price: Int
    let images: [String]
    
    enum CodingKeys: String, CodingKey {
        case state
        case identifier = "id"
        case name
        case properties
        case coordinates = "coords"
        case price
        case images
    }
}

struct Offer: Codable {
    let identifier: String
    let name: [Language]
    let description: [Language]
    let category: String
    let userIdentifier: String
    let properties: [String: AnyCodable]
    let coordinates: [Double]
    let images: [String]

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case description = "desc"
        case category
        case userIdentifier = "user_id"
        case properties
        case coordinates = "coords"
        case images
    }
}
