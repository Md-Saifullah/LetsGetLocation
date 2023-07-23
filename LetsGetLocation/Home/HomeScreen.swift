//
//  HomeScreen.swift
//  LetsGetLocation
//
//  Created by Md. Saifullah on 21/7/23.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject private var locationDataManager = LocationPermissionManager()
    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                Text("latitude: \(locationDataManager.coordinates?.latitude ?? 0)")
                Text("latitude: \(locationDataManager.coordinates?.longitude ?? 0)")

                Text("auth status: \(locationDataManager.authorizationStatus.getStatus.rawValue)")

                Button("requestLocation") {
                    locationDataManager.requestLocation()
                }

                Button("ask for requestLocationPermissionWhenInUse") {
                    locationDataManager.requestLocationPermissionWhenInUse()
                }

                Button("ask for requestLocationPermissionAlways") {
                    locationDataManager.requestLocationPermissionAlways()
                }

                Button("log coordinates") {
                    print(String(describing: locationDataManager.coordinates))
                }

                Button("log authorizationStatus") {
                    print("\(locationDataManager.authorizationStatus)")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
