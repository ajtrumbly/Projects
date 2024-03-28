//
//  UserView.swift
//  FriendFace
//
//  Created by Austin Trumbly on 3/26/24.
//

import SwiftUI

struct UserView: View {
    let user: User
    
    var body: some View {
        List {
            Section("Info") {
                Text("Name: \(user.name)")
                Text("Age: \(String(user.age))")
                Text("Address: \(user.address)")
            }
            
            Section("Work") {
                Text("Company: \(user.company)")
            }
            
            Section("Friends") {
                ForEach(user.friends) { friend in
                    Text(friend.name)
                }
            }
        }
        .listStyle(.grouped)
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    UserView(user: .example)
}
