//
//  Hot_ProspectsApp.swift
//  Hot Prospects
//
//  Created by Austin Trumbly on 4/24/24.
//

import SwiftUI
import SwiftData

@main
struct Hot_ProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
