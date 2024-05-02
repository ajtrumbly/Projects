//
//  EditingView.swift
//  Hot Prospects
//
//  Created by Austin Trumbly on 5/2/24.
//

import SwiftUI
import SwiftData

struct EditingView: View {
    @Bindable var prospect: Prospect
    
    var body: some View {
        Form {
            TextField("Name", text: $prospect.name)
            TextField("Email", text: $prospect.email)
            Toggle("Contacted", isOn: $prospect.isContacted)
        }
        .navigationTitle("Edit Prospect")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Prospect.self, configurations: config)
            let example = Prospect(name: "Example User", email: "example@user.com", isContacted: false)

            return EditingView(prospect: example)
                .modelContainer(container)
        } catch {
            return Text("Failed to create preview: \(error.localizedDescription)")
        }
}
