//
//  PeopleView.swift
//  FaceFacts
//
//  Created by Austin Trumbly on 2/18/24.
//
import SwiftData
import SwiftUI

struct PeopleView: View {
    @Environment(\.modelContext) var modelContext
    @Query var people: [Person]
    
    var body: some View {
        List {
            ForEach(people) { person in
                NavigationLink(value: person) {
                    Text(person.name)
                }
            }
            .onDelete(perform: deletePerson)
        }
    }
    
    init(searchText: String = "", sortOrder: [SortDescriptor<Person>] = []) {
        _people = Query(filter: #Predicate { person in
            if searchText.isEmpty {
                true
            } else {
                person.name.localizedStandardContains(searchText) ||
                person.email.localizedStandardContains(searchText) ||
                person.details.localizedStandardContains(searchText)
            }
        }, sort: sortOrder)
    }
    
    func deletePerson(at offsets: IndexSet) {
        for offset in offsets {
            let person = people[offset]
            modelContext.delete(person)
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return PeopleView()
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
