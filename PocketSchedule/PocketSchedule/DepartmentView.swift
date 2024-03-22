//
//  DepartmentView.swift
//  PocketSchedule
//
//  Created by Austin Trumbly on 2/19/24.
//

import SwiftUI

struct DepartmentView: View {
    var department: Department
    @ObservedObject var store: Store
    let textSize = 14
    
    let timeSlots = ["9", "10", "11", "12", "1", "2", "3", "4", "5"]
    
    var body: some View {
        List {
            ForEach(store.allEmployees.filter { $0.department == department.name }, id: \.id) { employee in
                HStack {
                    Text(employee.name)
                    
                    if department.name == "ASL" {
                        HStack {
                            ForEach(timeSlots, id: \.self) { time in
                                VStack {
                                    Text(time)
                                        .font(.system(size: CGFloat(textSize)))
                                    ZStack {
                                        Rectangle()
                                            .fill(.white)
                                            .frame(height: 40)
                                        Text("x")
                                            .bold()
                                    }
                                }
                                .frame(width: 16)
                                .padding(-3)
                            }
                        }
                    }
                }
            }
            .navigationTitle(department.name)
        }
    }
}

