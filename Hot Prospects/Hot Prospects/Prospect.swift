//
//  Prospect.swift
//  Hot Prospects
//
//  Created by Austin Trumbly on 4/25/24.
//

import Foundation
import SwiftData

@Model
class Prospect {
    var name: String
    var email: String
    var isContacted: Bool
    var dateAdded = Date.now
    
    init(name: String, email: String, isContacted: Bool) {
        self.name = name
        self.email = email
        self.isContacted = isContacted
    }
}
