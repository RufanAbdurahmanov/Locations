//
//  NetworkManager.swift
//  Task3MapKit
//
//  Created by Rufan Abdurahmanov on 26.04.22.
//

import Foundation

private enum Endpoints: String {
    case lists = "/v1/nearby.php"
    case search = "/v1/search.php"
    case details = ""
}

enum baseURL: String {
    case url = "https://us1.locationiq.com"
}
enum ApiKey: String {
    case key = "pk.1c5ee2336b80c798134be677a74f0034"
}

enum Request {
    
    case list
    case search
    case details
    
    var path: String {
        switch self {
        case .list:
            return Endpoints.lists.rawValue
        case .search:
            return Endpoints.search.rawValue
        case .details:
            return Endpoints.details.rawValue
        }
    }
    
}
