//
//  LocationManager.swift
//  Weadinator
//
//  Created by 조성하 on 25/10/2024.
//

import Foundation
import CoreLocation
//import SwiftUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    @Published var location: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var locationName: String? = "Unknown"
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        self.location = newLocation
        updateLocationName(from: newLocation)
    }
    
    private func updateLocationName(from location: CLLocation) {
            geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
                guard let self = self, error == nil, let placemark = placemarks?.first else { return }
                self.locationName = placemark.locality ?? "Unknown"
            }
        }
        
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.authorizationStatus = manager.authorizationStatus
        if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways {
            self.locationManager.startUpdatingLocation()
        } else {
            self.locationManager.stopUpdatingLocation()
        }
    }
}
