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
    // TODO: Move into new view with NavLink
    @Query var wallet: [GiftCard]
    
    var body: some View {
        NavigationStack {
            // Iterate through the query to list each gift card
            // TODO: Format the cards like the wallet app
            // TODO: Change nav structure to use view & NavLink
            List(wallet, id: \.id) { giftCard in
                NavigationLink(giftCard.store, value: giftCard)
            }
            .navigationDestination(for: GiftCard.self, destination: DetailGiftCardView.init)
            .navigationTitle("Wallet")
            .toolbar {
                // TODO: Add Button to create new gift card
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
