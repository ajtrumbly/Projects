//
//  Previewer.swift
//  FaceFacts
//
//  Created by Austin Trumbly on 2/19/24.
//

import SwiftData
import Foundation

@MainActor
struct Previewer {
    let container: ModelContainer
    let event: Event
    let person: Person
    
    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Person.self, configurations: config)
        
        event = Event(name: "Dimension Jump", location: "Nottingham")
        person = Person(name: "Dave Lister", email: "dave@reddward.com", details: "", metAt: event)
        
        container.mainContext.insert(person)
    }
}
