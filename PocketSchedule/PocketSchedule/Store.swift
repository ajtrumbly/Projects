//
//  Store.swift
//  PocketSchedule
//
//  Created by Austin Trumbly on 2/19/24.
//

import Foundation

class Store: ObservableObject {
    
    var departments: [Department] = [
        Department(name: "ASL"),
        Department(name: "Bike Builder"),
        Department(name: "Bowtech"),
        Department(name: "Cashiers"),
        Department(name: "Customer Service"),
        Department(name: "Defectives/IT"),
        Department(name: "Delivery"),
        Department(name: "Display"),
        Department(name: "Ferris Wheel"),
        Department(name: "Fuzziwigs"),
        Department(name: "Ginnas"),
        Department(name: "Gun CS"),
        Department(name: "Hardlines-Guns"),
        Department(name: "Hardlines-Non Guns"),
        Department(name: "Home Decor"),
        Department(name: "Loss Prevention"),
        Department(name: "Lower Merchandisers"),
        Department(name: "Lower Midlines"),
        Department(name: "Maintenance"),
        Department(name: "Mens Fitting Room"),
        Department(name: "Mens Shoes"),
        Department(name: "Mens Softlines"),
        Department(name: "Processing"),
        Department(name: "Service Shop"),
        Department(name: "Upper Merchandisers"),
        Department(name: "Upper Midlines"),
        Department(name: "Visa"),
        Department(name: "Web"),
        Department(name: "Womens Fitting Room"),
        Department(name: "Womens Shoes"),
        Department(name: "Womens Softlines"),
        Department(name: "Youth Fitting Room"),
        Department(name: "Youth Shoes")
    ]
    
    var allEmployees: [Employee] = [
        Employee(name: "Austin T", ext: 2102, department: "Customer Service"),
        Employee(name: "Ben T", ext: 2245, department: "Customer Service"),
        Employee(name: "Sierra S", ext: 2071, department: "Ginnas"),
        Employee(name: "Nicole W", ext: 7002, department: "ASL"),
        Employee(name: "Stacey A", ext: 7001, department: "ASL"),
    ]
    
    var workdays: [Workday]
    
    init() {
        self.workdays = [Workday(allEmployees: self.allEmployees)]
    }
}
