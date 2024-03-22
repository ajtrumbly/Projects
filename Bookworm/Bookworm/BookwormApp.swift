//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Austin Trumbly on 3/15/24.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
