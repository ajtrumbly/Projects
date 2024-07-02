//
//  ContentView.swift
//  GiftCardWallet
//
//  Created by Austin Trumbly on 7/2/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    // Injecting the swiftData container into the view
    @Environment(\.modelContext) var modelContext
    
    // Creating the wallet query
    @Query var wallet: [GiftCard]
    
    var body: some View {
        NavigationStack {
            // Iterate through the query to list each gift card
            // TODO: Format the cards like the wallet app
            List {
                ForEach(wallet) { giftCard in
                    Text(giftCard.store)
                }
                .onDelete(perform: removeGiftCard)
            }
            .navigationTitle("Wallet")
            .toolbar {
                // Add a new gift card
                // TODO: Create NewGiftCardView
                Button(action: addGiftCard) {
                    Label("Add Gift Card", systemImage: "plus")
                }
            }
        }
    }
    
    // TODO: Move these into a MVVM structure
    // CRUD Functions
    func addGiftCard() {
        let newCard = GiftCard(store: "Scheels", balance: 100.00)
        
        modelContext.insert(newCard)
    }
    
    func removeGiftCard(at offsets: IndexSet) {
        for offset in offsets {
            let giftCard = wallet[offset]
            modelContext.delete(giftCard)
        }
    }
}

#Preview {
    ContentView()
}
