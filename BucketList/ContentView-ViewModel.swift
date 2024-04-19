//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Austin Trumbly on 4/18/24.
//

import CoreLocation
import Foundation
import MapKit
import LocalAuthentication

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        var selectedPlace: Location?
        var isUnlocked = false
        
        var authenticationError = "unknown error"
        var isShowingAuthenticationError = false
        
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        
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
                print("unable to save data")
            }
        }
     
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "New Location", description: "New Description", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate to view saved places"
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                    success, authenticateError in
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.authenticationError = "There was a problem authenticating you. Please try again"
                        self.isShowingAuthenticationError = true
                    }
                }
            } else {
                authenticationError = "Sorry, your device does not support biometric authentication."
                isShowingAuthenticationError = true
            }
        }
    }
}
