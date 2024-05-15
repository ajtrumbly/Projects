//
//  Card.swift
//  Flashzilla
//
//  Created by Austin Trumbly on 5/6/24.
//

import Foundation

struct Card: Codable, Hashable, Identifiable {
    var id = UUID()
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who", answer: "Jodie Whittatker")
}
