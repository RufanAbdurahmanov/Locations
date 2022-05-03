//
//  WebService.swift
//  Task3MapKit
//
//  Created by Rufan Abdurahmanov on 25.04.22.
//

import Foundation
protocol WebServiceProtocol {
    func getLists(tag: String, lat: Float, lon: Float, radius: Int, complete: @escaping([List])->())
    func getSearchItems(query: String, complete: @escaping(SearchModels)->())
}


class WebServices: WebServiceProtocol {
    
    static let shared = WebServices()
    
    func getLists(tag: String, lat: Float, lon: Float, radius: Int, complete: @escaping(Lists)->()) {
        let url = "\(baseURL.url.rawValue)\(Request.list.path)?key=\(ApiKey.key.rawValue)&lat=\(lat)&lon=\(lon)&radius=\(radius)&tag=\(tag)"
        
        NetworkRequest.shared.requestAPI(type: Lists.self, url: url) { response in
            complete(response)
        }
    }
    
    func getSearchItems(query: String, complete: @escaping([SearchModel])->()) {
        let url = "\(baseURL.url.rawValue)\(Request.search.path)?key=\(ApiKey.key.rawValue)&q=\(query)&format=json"
        
        NetworkRequest.shared.requestAPI(type: SearchModels.self, url: url) { response in
            complete(response)
        }
    }
}
