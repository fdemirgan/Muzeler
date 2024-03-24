//
//  MapViewController.swift
//  Muzeler
//
//  Created by Ferhat on 22.03.2024.
//

import UIKit
import MapKit
import CoreLocation

final class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = LocationManager.shared
    var museums: [MuseumData] = []
    var detailMuseum: MuseumData?

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        mapView.showsUserLocation = true
        addAnnotations()
        addAnnotation()
    }
    
    func addAnnotations(){

        for museum in museums{
            let selectedMuseum = CLLocationCoordinate2D(latitude: museum.latitude ?? 0, longitude: museum.longitude ?? 0)
            
            let annotation = MuseumAnnotation()
            annotation.coordinate = selectedMuseum
            annotation.title = museum.name
            annotation.image = "MuseumsAnnotationPin"
            mapView.addAnnotation(annotation)
            mapView.showAnnotations(mapView.annotations, animated: true)
        }
    }

    func addAnnotation(){

        guard let museum = detailMuseum else { return }
        let selectedMuseum = CLLocationCoordinate2D(latitude: museum.latitude ?? 0, longitude: museum.longitude ?? 0)
        let annotation = MuseumAnnotation()
        annotation.coordinate = selectedMuseum
        annotation.title = museum.name
        annotation.image = "MuseumAnnotationPin"
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: selectedMuseum, span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04))
        mapView.setRegion(region, animated: true)
    }
}


extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if let userLocation = mapView.userLocation.location?.coordinate {
            let region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015))
            mapView.setRegion(region, animated: true)
        }
    }
    // Harita görünümündeki herbir annotation'a, nasıl bir görünüm atanacağını belirler.
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
         // Annotation eklenecek konum kullanıcının konumuysa nil döndür.
        if annotation is MKUserLocation {
            return nil
        }
        var museumAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "MuseumAnnotationView")
        if museumAnnotationView == nil {
           museumAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "MuseumAnnotationView")
            museumAnnotationView?.canShowCallout = true
            
        }else {
            museumAnnotationView?.annotation = annotation
        }
        if let museumAnnotation = annotation as? MuseumAnnotation {
            museumAnnotationView?.image = UIImage(named: museumAnnotation.image)
        }
        return museumAnnotationView
    }
}


