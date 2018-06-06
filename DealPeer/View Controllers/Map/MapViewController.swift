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

    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManagerSetup()
        googleMapView.isMyLocationEnabled = true
        googleMapView.mapType = .normal
    }
}

extension MapViewController: OffersUpdatable {

    func storeUpdatedOffers(offers: [Offer]) {
        print("\(type(of: self)) recieved \(offers.count) offers")
        placeOffersOnMap(offers)
    }

    func storeFailedToUpdateOffers(error: Error) {
        print("\(type(of: self)) recieved offer update error")
        // Show UI with Error
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
    fileprivate func placeOffersOnMap(_ offers: [Offer]) {
        offers.forEach { offer in
            if let lat = offer.coordinates.first, let long = offer.coordinates.last {
                let coordinates =  CLLocationCoordinate2D(latitude: lat, longitude: long)
                let marker = GMSMarker()
                marker.position = coordinates
                marker.title = offer.description.first?.caption
                marker.map = googleMapView
            }
        }
    }

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
}

