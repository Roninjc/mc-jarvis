//
//  LocationManager.swift
//  mc-jarvis
//
//  Created by Jesus Castano Candela on 23/08/2024.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var lastKnownLocation: CLLocationCoordinate2D?
    private var manager = CLLocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
        checkLocationAuthorization()
    }
    
    private func checkLocationAuthorization() {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            
        case .restricted:
            print("Location restricted")
            
        case .denied:
            print("Location denied")
            
        case .authorizedAlways, .authorizedWhenInUse:
            startUpdatingLocation()
            print("Location authorized")
            
        @unknown default:
            print("Location service disabled")
        }
    }
    
    private func startUpdatingLocation() {
        manager.startUpdatingLocation()
        if let location = manager.location {
            lastKnownLocation = location.coordinate
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
