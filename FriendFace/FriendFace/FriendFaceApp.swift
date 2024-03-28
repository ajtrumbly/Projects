//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Austin Trumbly on 3/25/24.
//

import SwiftUI
import SwiftData

@main
struct FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
