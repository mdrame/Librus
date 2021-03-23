//
//  MapViewController.swift
//  Librus
//
//  Created by Mohammed Drame on 3/22/21.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    var destinationCordinate: CLLocationCoordinate2D!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapKitView.delegate = self
        mapKitView.showsUserLocation = true
        // Do any additional setup after loading the view.
        checkLocationService()
        
        let testCord = CLLocationCoordinate2D(latitude: 53.0761693, longitude: -0.8092339)
        var sourceCordinate = (locationManager.location?.coordinate)!
        mapit(fromCordinate: sourceCordinate, toCordinate: destinationCordinate )
    }
    
    
    
    @IBOutlet weak var mapKitView: MKMapView!
   
    
    private func checkLocationService() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            switch locationManager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                print("Allowed")
            case .denied, .notDetermined, .restricted:
                print("No access to location service")
            default:
                print("Unhandled case")
            }
            switch locationManager.accuracyAuthorization {
            case .reducedAccuracy:
                print("Low access")
            case .fullAccuracy:
                print("Full access")
            default:
                print("This shouldn't happen!")
            }        } else {
                // Show alert telling user that location service is off
                print("location service off")
            }
    }
    
    private func setupLocationManager() {
        //        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
    
    func mapit(fromCordinate sorce: CLLocationCoordinate2D, toCordinate destination: CLLocationCoordinate2D ) {
        let soucePlaceMark = MKPlacemark(coordinate: sorce)
        let destPlaceMark = MKPlacemark(coordinate: destination)
        
        let sourceItem = MKMapItem(placemark: soucePlaceMark)
        let destItem = MKMapItem(placemark: destPlaceMark)
        
        let destinationRequest = MKDirections.Request()
        destinationRequest.source = sourceItem
        destinationRequest.destination = destItem
        destinationRequest.transportType = .automobile
        destinationRequest.requestsAlternateRoutes = true
        
        let directions = MKDirections(request: destinationRequest)
        directions.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("Something is wrong :(")
                }
                return
            }
            
          let route = response.routes[0]
          self.mapKitView.addOverlay(route.polyline)
          self.mapKitView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
    }
    }
    

    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .blue
        return render
    }
   
    
    
}
    
    
    
