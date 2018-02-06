//
//  ViewController.swift
//  Day 5 - GetMyLocation
//
//  Created by Prashant Gaikwad on 1/5/18.
//  Copyright © 2018 Prashant Gaikwad. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    fileprivate var annotation: MKAnnotation!
    fileprivate var locationManager: CLLocationManager!
    fileprivate var isCurrentLocation: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.mapType = .standard
        
    }
    
    @IBAction func getCurrentLocationAction(_ sender: Any) {
        if (CLLocationManager.locationServicesEnabled()) {
            if locationManager == nil {
                locationManager = CLLocationManager()
            }
            locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
   
}

extension ViewController : CLLocationManagerDelegate{
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
        
        if self.mapView.annotations.count != 0 {
            annotation = self.mapView.annotations[0]
            self.mapView.removeAnnotation(annotation)
        }
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = location!.coordinate
        pointAnnotation.title = ""
        mapView.addAnnotation(pointAnnotation)
    }
    
}

