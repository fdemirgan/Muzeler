//
//  MapViewController.swift
//  Muzeler
//
//  Created by Ferhat on 22.03.2024.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.shared.locationDelegate = self
        mapView.delegate = self
        mapView.showsUserLocation = true
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
}

extension MapViewController: LocationManagerDelegate {
    func didUpdateLocation(latitude: Double, longitude: Double) {
        print( "Kullanıcı anlık konumu: \(latitude) - \(longitude)")
    }
    
    
}
