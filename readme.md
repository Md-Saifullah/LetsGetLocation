# LetsGetLocation

This is a sample on how you can ask for location permission on a iOS device.

* Step 1: Set up Class containing `CLLocationManager`.

* Step 2: Set up delegate objects confirming to `CLLocationManagerDelegate` protocol [(Apple Documentation)](https://developer.apple.com/documentation/corelocation/cllocationmanagerdelegate) that will receive updates from `CLLocationManager`.

* Step 3: Set up a `@Published` variable so that our SwiftUI view will update when the status changes in our Class

### See the code below for clearence

```swift

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

        locationManager.requestAlwaysAuthorization()
    }

    func requestLocationPermissionWhenInUse() {

        locationManager.requestWhenInUseAuthorization()
    }

    func requestLocation() {

        locationManager.requestLocation()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {

        // MARK: This section is executed every time the class is instantiated.

        authorizationStatus = manager.authorizationStatus

        switch manager.authorizationStatus {
        case .notDetermined:

            requestLocationPermissionWhenInUse()
            //requestLocationPermissionAlways()

        case .restricted, .denied: break

        case .authorizedAlways, .authorizedWhenInUse:

            requestLocation()

        @unknown default:

            print("Use your own way of handling unknown cases of future")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        // MARK: This section is executed every time the location is updated

        guard let location = locations.last else { return }

        coordinates = location.coordinate
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

        // MARK: Use your own way of handling Error

        print("error: \(error.localizedDescription)")
    }
}

/* MARK: This enums are created for better readability

  Because the authorizationStatus return raw INT32 value when printed
*/

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

```

### Note:
> The app's Info.plist must contain an `"NSLocationWhenInUseUsageDescription"` key with a string value for asking `when in use permission` and both `“NSLocationAlwaysAndWhenInUseUsageDescription”` and `“NSLocationWhenInUseUsageDescription”` for asking `always  in use permission` explaining to the user how the app uses this data.