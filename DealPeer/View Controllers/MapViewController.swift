//
//  ViewController.swift
//  DealPeer
//
//  Created by Artem Katlenok on 19/05/2018.
//  Copyright © 2018 Artem Katlenok. All rights reserved.
//

import UIKit
import GoogleMaps
import FacebookCore
import FacebookLogin

class MapViewController: UIViewController {

    @IBOutlet weak var googleMapView: GMSMapView!
    @IBOutlet weak var loginButton: UIButton!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManagerSetup()
        interfaceSetup()
        
        if AccessToken.current != nil {
            print("FACEBOOK IS LOGGED IN")
        } else {
            print("FACEBOOK IS NOT LOGGED IN")
        }
        
        googleMapView.isMyLocationEnabled = true
        googleMapView.mapType = .normal
        
        Server.provideAllOffers { (result) in
            print(result)
            
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let camera = GMSCameraPosition(target: locValue, zoom: 10.0, bearing: 0, viewingAngle: 0.0)
        googleMapView.camera = camera
    }
    
}

// Helpers

extension MapViewController {
    
    fileprivate func locationManagerSetup() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    fileprivate func interfaceSetup() {
        
        loginButton.layer.cornerRadius = 10.0
    }
}

