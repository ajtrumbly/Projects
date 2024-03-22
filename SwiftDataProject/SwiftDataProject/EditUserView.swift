//
//  EditUserView.swift
//  SwiftDataProject
//
//  Created by Austin Trumbly on 3/19/24.
//

import SwiftData
import SwiftUI

struct EditUserView: View {
    @Bindable var user: User
    
    var body: some View {
        Form {
            TextField("Name", text: $user.name)
            TextField("City", text: $user.city)
            DatePicker("Join Date", selection: $user.joinDate)
        }
        .navigationTitle("Edit User")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let user = User(name: "Test Name", city: "Test City", joinDate: .now)
        
        return EditUserView(user: user)
            .modelContainer(container)
    } catch  {
        return Text("Error setting up preview: \(error.localizedDescription)")
    }
   
}
