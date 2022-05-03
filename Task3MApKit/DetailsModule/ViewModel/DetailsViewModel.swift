//
//  DetailsViewModel.swift
//  Task3MapKit
//
//  Created by Rufan Abdurahmanov on 28.04.22.
//

import Foundation
import MapKit

class DetailsViewModel {
    var lat = ""
    var lon = ""
    var item: SearchModel?
    
    let sourceLat: Double = 40.4093
    let sourceLon: Double = 49.8671
    
    init() {}
    
    init(item: SearchModel) {
        self.item = item
        configureLatLon()
    }
    
    func configureLatLon() {
        lat = item?.lat ?? ""
        lon = item?.lon ?? ""
    }
    
    func makeAnnotations() -> [MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        let annotation = MKPointAnnotation()
        let lat = Double(item?.lat ?? "") ?? 0.0
        let lon = Double(item?.lon ?? "") ?? 0.0
        annotation.title = item?.titleName ?? ""
        annotation.subtitle = item?.displayName ?? ""
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        annotations.append(annotation)
        return annotations
    }

}
