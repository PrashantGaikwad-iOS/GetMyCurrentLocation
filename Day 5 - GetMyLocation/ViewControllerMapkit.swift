//
//  ViewControllerMapkit.swift
//  Day 5 - GetMyLocation
//
//  Created by Prashant Gaikwad on 1/6/18.
//  Copyright © 2018 Prashant Gaikwad. All rights reserved.
//

import UIKit
import MapKit

class ViewControllerMapkit: UIViewController , CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.isZoomEnabled = true
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        var region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        region.center = mapView.userLocation.coordinate
        mapView.setRegion(region, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


