//
//  LocationManager.swift
//  Muzeler
//
//  Created by Ferhat on 24.02.2024.
//

import Foundation
import CoreLocation
// AynObject yazmamın sebebi yazdığım protokolün sadece class larda kullanılabilir bir protocol olmasını istiyorum. AnyObject yerine class da yazabilirdim ama böyle hem swift standartlarına hem de objective-C ile uyumludur.
protocol LocationManagerDelegate: AnyObject {
    func didUpdateLocation(latitude: Double, longitude: Double)
}

// locationManager ı NSObject sınıfından türettim. Sebebi, CLLocationManagerDelegate bir protoldür ve NSObjectProtocol den türetilmiştir. Dolayısıyla LocationManager sınıfını NSObject sınıfından türeterek CLLocationManagerDelegate protokolünü uygulama yeteneği kazandım.
class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager() // singleton instance
    private var locationManager = CLLocationManager()
    weak var locationDelegate: LocationManagerDelegate?
    
    private override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first?.coordinate {
            print("Latitude: \(location.latitude), Longitude: \(location.longitude)")
            let latitude = location.latitude
            let longitude = location.longitude
            
            locationDelegate?.didUpdateLocation(latitude: latitude, longitude: longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}


