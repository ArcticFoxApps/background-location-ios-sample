//
//  LocationManager.swift
//  LocationSample
//
//  Created by Hank Wang on 2023/05/15.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate  {
    
    private let locationManager = CLLocationManager()
    
    @Published var authorisationStatus: CLAuthorizationStatus?
    @Published var location: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.distanceFilter = 5
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.activityType = .other
        locationManager.startUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(manager.authorizationStatus.rawValue)
        switch manager.authorizationStatus {
        case .authorizedAlways:
            authorisationStatus = .authorizedAlways
            manager.requestLocation()
            break
        case .authorizedWhenInUse:
            authorisationStatus = .authorizedWhenInUse
            manager.requestLocation()
            manager.requestAlwaysAuthorization()
            break
        case .restricted:
            authorisationStatus = .restricted
            break
        case .denied:
            authorisationStatus = .denied
            break
        case .notDetermined:
            manager.requestAlwaysAuthorization()
            break
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        print("\(location.coordinate.latitude), \(location.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("locationManager: \(error.localizedDescription)")
    }
    
    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        print("pause")
    }

    func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        print("resume")
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.activityType = .other
        locationManager.startUpdatingLocation()
    }
}

