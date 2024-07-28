//
//  StoreView.swift
//  PortfolioApp
//
//  Created by Austin Trumbly on 7/23/24.
//

import StoreKit
import SwiftUI

struct StoreView: View {
    enum LoadState {
        case loading, loaded, error
    }
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.dismiss) var dismiss
    
    @State private var loadState = LoadState.loading
    @State private var showingPurcahseError = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack {
                    Image(decorative: "unlock")
                        .resizable()
                        .scaledToFit()
                    
                    Text("Unlock Today!")
                        .font(.title.bold())
                        .fontDesign(.rounded)
                        .foregroundStyle(.white)
                    
                    Text("Get the most out of our app")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(20)
                .background(.blue.gradient)
                
                ScrollView {
                    VStack {
                        switch loadState {
                        case .loading:
                            Text("Fetching offers...")
                                .font(.title2.bold())
                                .padding(.top, 20)
                            
                            ProgressView()
                                .controlSize(.large)
                            
                        case .loaded:
                            ForEach(dataController.products) { product in
                                Button {
                                    purchase(product)
                                } label: {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(product.displayName)
                                                .font(.title2.bold())
                                            
                                            Text(product.description)
                                        }
                                        
                                        Spacer()
                                        
                                        Text(product.displayPrice)
                                            .font(.title)
                                            .fontDesign(.rounded)
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .frame(maxWidth: .infinity)
                                    .background(.gray.opacity(0.2), in: .rect(cornerRadius: 20))
                                    .contentShape(.rect)
                                }
                                .buttonStyle(.plain)
                            }
                            
                        case .error:
                            Text("Sorry there was an error loading our store.")
                                .padding(.top, 20)
                            
                            Button("Try Again") {
                                Task {
                                    await load()
                                }
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                    .padding(20)
                }
                
                Button("Restore Purchases", action: restore)
                
                Button("Cancel", role: .cancel) {
                    dismiss()
                }
                .padding(.top, 20)
            }
        }
        .alert("In-app purchases are disabled", isPresented: $showingPurcahseError) {
        } message: {
            Text("""
            You can't purchase the premium unlock because in-app purchases are disabled on this device.
            
            Please ask whomever manages your device for assistance.
            """)
        }
        .onChange(of: dataController.fullVersionUnlocked) { _, _ in
            checkForPurchase()
        }
        .task {
            await load()
        }
    }

    func checkForPurchase() {
        if dataController.fullVersionUnlocked {
            dismiss()
        }
    }

    func purchase(_ product: Product) {
        UserDefaults.resetStandardUserDefaults()
        
        guard AppStore.canMakePayments else {
            showingPurcahseError.toggle()
            return
        }
        
        Task { @MainActor in
            try await dataController.purchase(product)
        }
    }

    func load() async {
        loadState = .loading
        
        do {
            try await dataController.loadProducts()
            
            if dataController.products.isEmpty {
                loadState = .error
                print(".error1")
            } else {
                loadState = .loaded
                print(".loaded")
            }
        } catch {
            loadState = .error
            print(".error2")
        }
    }
    
    func restore() {
        Task {
            try await AppStore.sync()
        }
    }
}

#Preview {
    StoreView()
}
