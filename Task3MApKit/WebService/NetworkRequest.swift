//
//  NetworkRequest.swift
//  Task3MapKit
//
//  Created by Rufan Abdurahmanov on 25.04.22.
//

import Alamofire


class NetworkRequest {
    
    static let shared = NetworkRequest()
    
    func requestAPI<T: Decodable>(type: T.Type, url: String, params: [String: Any] = [:], completion: @escaping(T)->()) {
        AF.request(url,
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.default,
                   headers: nil,
                   interceptor: nil,
                   requestModifier: nil).responseData { response in
            switch response.result {
            case .success(let value):
                self.parse(value: value) { response in
                    completion(response)
                }
            case .failure(let error):
                print("Network Error: \(error)")
            }
        }
    }
    
    func parse<T: Decodable>(value: Data, completion: @escaping(T)->()) {
        do {
            let jsonData = try JSONDecoder().decode(T.self, from: value)
            completion(jsonData)
        } catch {
            print("Parsing error: \(error)")
        }
    }
}
