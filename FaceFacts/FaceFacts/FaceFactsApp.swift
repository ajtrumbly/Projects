//
//  FaceFactsApp.swift
//  FaceFacts
//
//  Created by Austin Trumbly on 2/18/24.
//

import SwiftUI
import SwiftData

@main
struct FaceFactsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Person.self)
    }
}
