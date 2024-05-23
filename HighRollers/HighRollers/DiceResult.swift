//
//  DiceResult.swift
//  HighRollers
//
//  Created by Austin Trumbly on 5/22/24.
//

import Foundation

struct DiceResult: Identifiable, Codable {
    var id = UUID()
    var type: Int
    var number: Int
    var rolls = [Int]()
    
    var description: String {
        rolls.map(String.init).joined(separator: ", ")
    }
    
    init(type: Int, number: Int) {
        self.type = type
        self.number = number
        
        for _ in 0..<number {
            let roll = Int.random(in: 1...type)
            rolls.append(roll)
        }
    }
}
