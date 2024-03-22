//
//  Employee.swift
//  PocketSchedule
//
//  Created by Austin Trumbly on 2/19/24.
//

import Foundation

class Employee: Identifiable, ObservableObject {
    
    var id = UUID()
    let name: String
    @Published var shift: String = "_-_"
    let ext: Int
    var department: String
    @Published var attendance: Attendance = Attendance.base
    
    init(id: UUID = UUID(), name: String, shift: String = "_-_", ext: Int, department: String, attendance: Attendance = .base) {
        self.id = id
        self.name = name
        self.shift = shift
        self.ext = ext
        self.department = department
        self.attendance = attendance
    }
}

enum Attendance {
    case base
    case here
    case absent
}
