//
//  Sight.swift
//  ToDoApp
//
//  Created by Austin Trumbly on 2/18/24.
//

import Foundation
import SwiftData

@Model
class Sight {
    var name: String
    var destination: Destination?
    
    init(name: String = "") {
        self.name = name
    }
}
