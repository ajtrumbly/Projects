//
//  ToDoAppApp.swift
//  ToDoApp
//
//  Created by Austin Trumbly on 2/18/24.
//

import SwiftUI
import SwiftData

@main
struct iTool: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        Label("Destination", systemImage: "map")
                    }
                SightsView()
                    .tabItem {
                        Label("Sights", systemImage: "mappin.and.ellipse")
                    }
            }
        }
        .modelContainer(for: Destination.self)
    }
}
