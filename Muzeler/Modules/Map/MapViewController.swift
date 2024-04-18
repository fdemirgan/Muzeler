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

    @IBOutlet weak var mapTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var mapView: MKMapView!
    private let locationManager = LocationManager.shared
    // mapView da mapType metodu yakın zamanda kaldırılacağından dolayı kodun geleceğe yönelik olması için...
    private var currentMapType: MKMapType = .standard
     var museums: [MuseumData] = []
    public var detailMuseum: MuseumData?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapTypeSegmentedControl.addTarget(self, action: #selector(mapTypeChanged), for: .valueChanged)
        addAnnotations()
        addAnnotation()
    }
    
    @objc func mapTypeChanged(_ segmentedControl: UISegmentedControl){
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            currentMapType = .standard
        case 1:
            currentMapType = .satellite
        case 2:
            currentMapType = .hybrid
        default:
            break
        }
        mapView.mapType = currentMapType
    }
    
    func addAnnotations(){

        for museum in museums{
            let selectedMuseum = CLLocationCoordinate2D(latitude: museum.latitude ?? 0, longitude: museum.longitude ?? 0)
            
            let annotation = MuseumAnnotation()
            annotation.coordinate = selectedMuseum
            annotation.title = museum.name
            annotation.image = "MuseumsAnnotationPin"
            mapView.addAnnotation(annotation)
//            mapView.showAnnotations(mapView.annotations, animated: true)
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
    // Harita görünümündeki herbir annotation'a, nasıl bir görünüm atanacağını belirler. Ben burada custom annotation oluşturacağım.
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
         // Annotation eklenecek konum kullanıcının konumuysa nil döndür.
        if annotation is MKUserLocation {
            return nil
        }
        
        let identifier = "MuseumAnnotationView"
        var museumAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if museumAnnotationView == nil {
           museumAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            museumAnnotationView?.canShowCallout = true
            let calloutView = CustomCalloutView.instanceFromNib()
            
            calloutView.onCancelTapped = {
                
                if let selectedAnnotation = mapView.selectedAnnotations.first {
                        mapView.deselectAnnotation(selectedAnnotation, animated: true)
                    }
            }
            // Navigasyona git butonuna basıldığında navigasyona yönlendirme işlemini gerçekleştirir.
            calloutView.onNavigateTapped = {
                // Seçili annotation ı belirler.
                guard let selectedAnnotation = mapView.selectedAnnotations.first else { return }
                // Gidilecek yerin koordinatını oluşturur.
                let destinationPlacemark = MKPlacemark(coordinate: selectedAnnotation.coordinate)
                // Gidilecek yerin harita öğesini oluşturur.
                let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
                destinationMapItem.name = selectedAnnotation.title ?? "Destination"
                // Geçerli konumu ve harita öğesini oluşturur.
                let currentPlacemark = MKPlacemark(coordinate: mapView.userLocation.coordinate)
                let currentMapItem = MKMapItem(placemark: currentPlacemark)
                // Yönlendirme seçeneğini belirler.
                let directionMode = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                // Yönlendirme uygulamasını açar.
                MKMapItem.openMaps(with: [currentMapItem, destinationMapItem], launchOptions: directionMode)
            }
            museumAnnotationView?.detailCalloutAccessoryView = calloutView
        }else {
            museumAnnotationView?.annotation = annotation
        }

        if let museumAnnotation = annotation as? MuseumAnnotation {
            museumAnnotationView?.image = UIImage(named: museumAnnotation.image)
        }
        return museumAnnotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.setCenter(view.annotation!.coordinate, animated: true)
    }
}


