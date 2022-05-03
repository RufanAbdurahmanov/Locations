//
//  DetailsViewController.swift
//  Task3MapKit
//
//  Created by Rufan Abdurahmanov on 28.04.22.
//

import UIKit
import MapKit
import CoreLocation

class DetailsViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    let locationManager = CLLocationManager()
    
    var viewModel = DetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        updateMap()
    }
    override func viewWillLayoutSubviews() {
        view.backgroundColor =  UIColor(displayP3Red: 229/255, green: 229/255, blue: 234/255, alpha: 1)
        addressLabel.backgroundColor = .white
        categoryLabel.backgroundColor = .white
        addressLabel.clipsToBounds = true
        categoryLabel.clipsToBounds = true
        addressLabel.layer.cornerRadius = 9
        categoryLabel.layer.cornerRadius = 8
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
        let region = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(region, animated: true )
    }
    
    fileprivate func updateMap() {
        mapView.addAnnotations(viewModel.makeAnnotations())
        addressLabel.text = "Address: \(viewModel.item?.displayName ?? "")"
        categoryLabel.text = "Category: \(viewModel.item?.type?.capitalized ?? "")"
    }
    
    @IBAction func routeButton(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: "Alert Action", message: "Choose for Direction", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Here", style: .default, handler: { _ in
            self.getAdressHere()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Go Maps", style: .default, handler: { _ in
            self.getAdressOnMaps()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true)
    }
    
    func getAdressHere() {
        let sourceLocation = CLLocationCoordinate2D(latitude: self.viewModel.sourceLat, longitude: self.viewModel.sourceLon)
        let destinationLocation = CLLocationCoordinate2D(latitude: Double(self.viewModel.item?.lat ?? "") ?? 0.0, longitude: Double(self.viewModel.item?.lon ?? "") ?? 0.0)
        routeHere(sourceLocation: sourceLocation, destinationLocation: destinationLocation)
    }
    
    func getAdressOnMaps() {
        let requestLocation = CLLocation(latitude: Double(self.viewModel.item?.lat ?? "") ?? 0.0, longitude: Double(self.viewModel.item?.lon ?? "") ?? 0.0)
        
        CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
            if let placemark = placemarks {
                if placemark.count > 0 {
                    let newPlacemark = MKPlacemark(placemark: placemark[0])
                    let item = MKMapItem(placemark: newPlacemark)
                    item.name = self.viewModel.item?.titleName
                    let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                    item.openInMaps(launchOptions: launchOptions)
                }
            }
        }
    }
    
    
    func routeHere(sourceLocation: CLLocationCoordinate2D, destinationLocation: CLLocationCoordinate2D) {
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "My Location"
        //sourceAnnotation.subtitle = "Hotel"
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = self.viewModel.item?.titleName
        //destinationAnnotation.subtitle = "Hotel"
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        self.mapView.showAnnotations([sourceAnnotation, destinationAnnotation], animated: true)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        let direction = MKDirections(request: directionRequest)
        
        direction.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
}

extension DetailsViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 5
        renderer.strokeColor = .blue
        return renderer
    }
    
    
}





