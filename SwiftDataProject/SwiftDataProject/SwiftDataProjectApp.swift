//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Austin Trumbly on 3/19/24.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
