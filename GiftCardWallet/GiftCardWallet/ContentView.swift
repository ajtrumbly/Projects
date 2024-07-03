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
    @State private var path = NavigationPath()
    
    // Creating the wallet query
    // TODO: Move into new view with NavLink
    @Query var wallet: [GiftCard]
    
    var body: some View {
        NavigationStack(path: $path) {
            // Iterate through the query to list each gift card
            // TODO: Format the cards like the wallet app
            // TODO: Change nav structure to use view & NavLink
            WalletView()
                .navigationTitle("Wallet")
                .navigationDestination(for: GiftCard.self) { giftCard in
                    DetailGiftCardView(giftCard: giftCard)
                }
                .toolbar {
                    // TODO: Add Button to create new gift card
                    Button("Add Gift Card", systemImage: "plus", action: addGiftCard)
                }
        }
    }
    
    // TODO: Move these into a MVVM structure
    // CRUD Functions
    func addGiftCard() {
        let newCard = GiftCard(store: "Scheels", balance: 100.00)
        modelContext.insert(newCard)
        path.append(newCard)
    }
}

#Preview {
    ContentView()
}
