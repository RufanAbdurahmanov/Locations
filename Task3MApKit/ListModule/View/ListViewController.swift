//
//  ListViewController.swift
//  Task3MapKit
//
//  Created by Rufan Abdurahmanov on 26.04.22.
//

import UIKit
import MapKit
import CoreLocation

class ListViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    var viewModel = ListViewModel()
    let cellID = "\(ListCollectionViewCell.self)"
    var category = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = viewModel.categoryName.capitalized
        collectionView.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        viewModel.getLists {
            self.collectionView.reloadData()
        }
    }
    
//    private var windowInterfaceOrientation: UIInterfaceOrientation? {
//        return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
//    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        coordinator.animate(alongsideTransition: { (context) in
//            guard let windowInterfaceOrientation = self.windowInterfaceOrientation else { return }
//
//            if windowInterfaceOrientation.isLandscape {
//                // activate landscape changes
//            } else {
//                // activate portrait changes
//            }
            
            self.collectionView.reloadData()
        })
    }
    
    fileprivate func updateMap() {
        updateLocation(lat: viewModel.lat, lon: viewModel.lon)
        mapView.addAnnotations(viewModel.makeAnnotations())
    }
    
    @IBAction func changeSegment(_ sender: Any) {
        if segmentedController.selectedSegmentIndex == 0 {
            mapView.isHidden = true
            collectionView.isHidden = false
        } else {
            collectionView.isHidden = true
            mapView.isHidden = false
            updateMap()
        }
    }
    
    func updateLocation(lat: Float, lon: Float) {
        let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true )
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ListCollectionViewCell
        cell.configure(data: viewModel.itemAtCell(index: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width * 0.92, height: 50)
    }
}
