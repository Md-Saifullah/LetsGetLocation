//
//  LocationManager.swift
//  LetsGetLocation
//
//  Created by Md. Saifullah on 21/7/23.
//
import CoreLocation
import Foundation

class LocationPermissionManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var coordinates: CLLocationCoordinate2D?

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
    }

    // MARK: this three function are created to manually simulate asking location permission and location

    func requestLocationPermissionAlways() {
        print("requestLocationPermissionAlways")

        locationManager.requestAlwaysAuthorization()
    }

    func requestLocationPermissionWhenInUse() {
        print("requestLocationPermissionWhenInUse")

        locationManager.requestWhenInUseAuthorization()
    }

    func requestLocation() {
        print("requestLocation")

        locationManager.requestLocation()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("locationManagerDidChangeAuthorization")

        authorizationStatus = manager.authorizationStatus

        switch manager.authorizationStatus {
        case .notDetermined:

            // MARK: this section is executed every time the class is instantiated.

            locationManager.requestWhenInUseAuthorization()
//            locationManager.requestAlwaysAuthorization()

        case .restricted, .denied: break

        case .authorizedAlways, .authorizedWhenInUse:
            requestLocation()

        @unknown default:
            print("Use your own way of handling unknown cases of future")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // MARK: this section is executed every time the location is updated

        print("locationManager1")

        guard let location = locations.last else { return }

        coordinates = location.coordinate
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
}

// MARK: this enums are created for better readability

/// because the authorizationStatus return raw INT32 value when printed

enum AuthorizationStatus: String {
    case notDetermined
    case restricted
    case denied
    case authorizedAlways
    case authorizedWhenInUse
}

extension CLAuthorizationStatus {
    var getStatus: AuthorizationStatus {
        switch self {
        case .notDetermined:
            return .notDetermined
        case .restricted:
            return .restricted
        case .denied:
            return .denied
        case .authorizedAlways:
            return .authorizedAlways
        case .authorizedWhenInUse:
            return .authorizedWhenInUse
        @unknown default:
            return .notDetermined
        }
    }
}
