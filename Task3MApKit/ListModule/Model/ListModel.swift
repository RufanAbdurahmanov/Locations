//
//  ListModel.swift
//  Task3MapKit
//
//  Created by Rufan Abdurahmanov on 26.04.22.
//


import Foundation

// MARK: - List
struct List: Codable, CellProtocol {
    let placeID: String?
    let osmType: String?
    let osmID, lat, lon: String?
    let listClass: String?
    let type, tagType: String?
    let name, displayName: String?
    let address: Address?
    let boundingbox: [String]?
    let distance: Int?
    
    var titleName: String {
        name ?? ""
    }

    enum CodingKeys: String, CodingKey {
        case placeID = "place_id"
        case osmType = "osm_type"
        case osmID = "osm_id"
        case lat, lon
        case listClass = "class"
        case type
        case tagType = "tag_type"
        case name
        case displayName = "display_name"
        case address, boundingbox, distance
    }
}

// MARK: - Address
struct Address: Codable {
    let name, road: String?
    let city, state: String?
    let postcode: String?
    let country: String?
    let countryCode: String?

    enum CodingKeys: String, CodingKey {
        case name, road, city, state, postcode, country
        case countryCode = "country_code"
    }
}

typealias Lists = [List]
