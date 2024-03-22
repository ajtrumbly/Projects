//
//  Department.swift
//  PocketSchedule
//
//  Created by Austin Trumbly on 2/19/24.
//

import Foundation

class Department: Identifiable {
    
    var id = UUID()
    let name: String
    var employees: [Employee] = []
    
    init(id: UUID = UUID(), name: String, employees: [Employee] = []) {
        self.id = id
        self.name = name
        self.employees = employees
    }
}
