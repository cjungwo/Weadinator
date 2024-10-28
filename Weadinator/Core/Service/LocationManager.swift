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
    @Published var locationName: String = "Failed data loading"
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func updateLocationName(from location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self, error == nil else {
                print("ERROR: \(error?.localizedDescription ?? "Unknown error in self, error")")
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("ERROR: Plackemark is nil. \(error?.localizedDescription ?? "Unknown error in plackmark")")
                return
            }
            
            guard let locationName = placemark.locality else {
                print("ERROR: Location Name is nil. \(error?.localizedDescription ?? "Unknown error in locationName")")
                return
            }
            
            self.locationName = locationName
        }
    }
    
    //MARK: - Setting CLLocationManager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        self.location = newLocation
        updateLocationName(from: newLocation)
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
