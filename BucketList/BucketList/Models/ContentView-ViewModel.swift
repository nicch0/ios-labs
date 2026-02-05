//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by niccho on 19/11/2025.
//

import CoreLocation
import Foundation
import LocalAuthentication
import MapKit

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        var selectedPlace: Location?
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        var isUnlocked = false
        var error: String?

        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }

        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Couldn't save data")
            }
        }

        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            save()
        }

        func updateLocation(_ location: Location) {
            guard let selectedPlace else { return }

            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
            }
            save()
        }

        func authenticate() {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                // it's possible, so go ahead and use it
                let reason = "We need to unlock your data."

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                    // authentication has now completed
                    if success {
                        // authenticated successfully
                        self.isUnlocked = true
                    } else {
                        // there was a problem
                        self.error = error?.localizedDescription
                    }
                }
            } else {
                // no biometrics
            }
        }
    }
}
