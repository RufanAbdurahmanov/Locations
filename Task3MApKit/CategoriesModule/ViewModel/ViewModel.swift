//
//  ViewModel.swift
//  Task3MapKit
//
//  Created by Rufan Abdurahmanov on 25.04.22.
//

import UIKit

class CategoryViewModel {
    private var items = [CategoryModel]()
    
    func configureItems() {
        items = [CategoryModel(title: "All", image: "all"),
                 CategoryModel(title: "Airport", image: "airport"),
                 CategoryModel(title: "Restaurant", image: "restaurant"),
                 CategoryModel(title: "Bank", image: "bank"),
                 CategoryModel(title: "ATM", image: "atm"),
                 CategoryModel(title: "Hotel", image: "hotel"),
                 CategoryModel(title: "Pub", image: "pub"),
                 CategoryModel(title: "Bus Station", image: "busstation"),
                 CategoryModel(title: "Railway Station", image: "railwaystation"),
                 CategoryModel(title: "Cinema", image: "cinema"),
                 CategoryModel(title: "Hospital", image: "hospital"),
                 CategoryModel(title: "College", image: "college"),
                 CategoryModel(title: "School", image: "school"),
                 CategoryModel(title: "Pharmacy", image: "pharmacy"),
                 CategoryModel(title: "Supermarket", image: "supermarket"),
                 CategoryModel(title: "Fuel", image: "fuel"),
                 CategoryModel(title: "Gym", image: "gym"),
                 CategoryModel(title: "Place of Worship", image: "worship"),
                 CategoryModel(title: "Toilet", image: "toilet"),
                 CategoryModel(title: "Park", image: "park"),
                 CategoryModel(title: "Stadium", image: "stadium"),
                 CategoryModel(title: "Parking", image: "parking"),
                 CategoryModel(title: "Cardealer", image: "cardealer") ]
    }
    
    func getItems() -> [CategoryModel] {
        items
    }
    
    func numberOfItems() -> Int{
        return items.count
    }
    
    func itemAtCell(index: Int) -> CategoryModel {
        items[index]
    }
}
