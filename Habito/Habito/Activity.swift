//
//  Activity.swift
//  Habito
//
//  Created by Austin Trumbly on 3/11/24.
//

import Foundation

struct Activity: Codable, Identifiable, Equatable {
    var id = UUID()
    var title: String
    var description: String
    var completionCount = 0
    
    static let example = Activity(title: "Example Activity", description: "This is a test activity.")
}
