//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Austin Trumbly on 5/23/24.
//

import SwiftUI

enum SortType {
    case `default`, alphabetical, country
}

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var favorites = Favorites()
    @State private var searchText = ""
    @State private var sortType = SortType.default
    @State private var showingSortOptions = false
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            resorts
        } else {
            resorts.filter { $0.name.localizedStandardContains(searchText)}
        }
    }
    
    var sortedResults: [Resort] {
        switch sortType {
        case .default:
            filteredResorts
        case .alphabetical:
            filteredResorts.sorted { $0.name < $1.name }
        case .country:
            filteredResorts.sorted { $0.country < $1.country}
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List(sortedResults) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(.rect(cornerRadius: 5))
                            .overlay {
                                RoundedRectangle(cornerRadius: 5)
                                .stroke(.black, lineWidth: 1)
                            }
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                            .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Button("Change sort order", systemImage: "arrow.up.arrow.down") {
                    showingSortOptions = true
                }
            }
            .confirmationDialog("Sort order", isPresented: $showingSortOptions) {
                Button("Default"){ sortType = .default }
                Button("Alphabetical"){ sortType = .alphabetical }
                Button("Country"){ sortType = .country }
            }
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }
}

#Preview {
    ContentView()
}
