//
//  SearchModel.swift
//  Task3MapKit
//
//  Created by Rufan Abdurahmanov on 27.04.22.
//

import Foundation

// MARK: - WelcomeElement
struct SearchModel: Codable, CellProtocol{
    let placeID: String?
    let licence: String?
    let osmType: String?
    let osmID: String?
    let boundingbox: [String]?
    let lat, lon, displayName: String?
    let welcomeClass: String?
    let type: String?
    let importance: Double?
    let icon: String?
    
    
    var titleName: String {
        displayName ?? ""
    }

    enum CodingKeys: String, CodingKey {
        case placeID = "place_id"
        case licence
        case osmType = "osm_type"
        case osmID = "osm_id"
        case boundingbox, lat, lon
        case displayName = "display_name"
        case welcomeClass = "class"
        case type, importance, icon
    }
}



typealias SearchModels = [SearchModel]
