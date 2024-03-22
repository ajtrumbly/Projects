//
//  Person.swift
//  FaceFacts
//
//  Created by Austin Trumbly on 2/18/24.
//

import Foundation
import SwiftData

@Model
class Person {
    var name: String = ""
    var email: String = ""
    var details: String = ""
    var metAt: Event?
    @Attribute(.externalStorage) var photo: Data?
    
    init(name: String, email: String, details: String, metAt: Event? = nil) {
        self.name = name
        self.email = email
        self.details = details
        self.metAt = metAt
    }
}
