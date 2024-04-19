//
//  ContentView.swift
//  BucketList
//
//  Created by Austin Trumbly on 4/9/24.
//

import MapKit
import SwiftUI

struct ContentView: View {
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    @State private var viewModel = ViewModel()
    @AppStorage("mapstyle") private var mapStyle = "standard"
    
    var body: some View {
        if viewModel.isUnlocked {
            VStack {
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture{
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }
                    .mapStyle(mapStyle == "standard" ? .standard : .hybrid)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in
                        EditView(location: place) {
                            viewModel.update(location: $0)
                        }
                    }
                }
                
                Picker("Map mode", selection: $mapStyle) {
                    Text("Standard")
                        .tag("standard")
                    
                    Text("Hybrid")
                        .tag("tag")
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
            }
        } else {
            Button("Unlock places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                .alert("Authentication Error", isPresented: $viewModel.isShowingAuthenticationError) {
                    Button("OK") { }
                } message: {
                    Text(viewModel.authenticationError)
                }
        }
    }
}

#Preview {
    ContentView()
}
