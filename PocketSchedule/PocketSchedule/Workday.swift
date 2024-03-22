//
//  Workday.swift
//  PocketSchedule
//
//  Created by Austin Trumbly on 2/19/24.
//

import Foundation

class Workday: ObservableObject {
    
    var date: Date
    var employees: [Employee]
    var allEmployees: [Employee]
    
    init(date: Date = .now, employees: [Employee] = [], allEmployees: [Employee]) {
        self.date = date
        self.employees = employees
        self.allEmployees = allEmployees
    }
}
