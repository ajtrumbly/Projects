//
//  Event.swift
//  FaceFacts
//
//  Created by Austin Trumbly on 2/19/24.
//

import SwiftData
import Foundation

@Model
class Event {
    var name: String = ""
    var location: String = ""
    var people: [Person]? = [Person]()
    
    init(name: String, location: String) {
        self.name = name
        self.location = location
    }
}
