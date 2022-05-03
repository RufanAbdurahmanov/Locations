//
//  ListViewModel.swift
//  Task3MapKit
//
//  Created by Rufan Abdurahmanov on 26.04.22.
//

import Foundation
import MapKit
import CoreLocation

class ListViewModel {
    var categoryName = ""
    var items = [List]()
    var categories = [CategoryModel]()
    
    init() {}
    
    init(categoryName: String, categories: [CategoryModel]) {
        self.categoryName = categoryName
        self.categories = categories
    }
    
    let lat: Float = 40.4093
    let lon: Float = 49.8671
 
    let radius = 9000000
    func getLists(completion: @escaping()->()) {
        WebServices.shared.getLists(tag: categoryName.lowercased().replace(), lat: lat, lon: lon, radius: radius) { [unowned self] listt in
            self.items = listt
            completion()
        }
    }
    
    func numberOFItems() -> Int {
        return items.count
    }
    
    func itemAtCell(index: Int) -> List {
        return items[index]
    }
    
    func makeAnnotations() -> [MKPointAnnotation] {
        var anotations = [MKPointAnnotation]()
        anotations.removeAll()
        for item in items {
            let lat = Double(item.lat ?? "0") ?? 0.0
            let lon = Double(item.lon ?? "0") ?? 0.0
            let anotation = MKPointAnnotation()
            anotation.title = item.titleName
            anotation.subtitle = item.displayName
            anotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            anotations.append(anotation)
        }
        return anotations
    }
}
