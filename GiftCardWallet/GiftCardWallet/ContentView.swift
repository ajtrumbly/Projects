//
//  ContentView.swift
//  GiftCardWallet
//
//  Created by Austin Trumbly on 7/2/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var wallet: [GiftCard]
    
    var body: some View {
        NavigationStack {
            List(wallet) { giftCard in
                Text(giftCard.store)
            }
            .navigationTitle("Wallet")
            .toolbar {
                Button(action: addGiftCard) {
                    Label("Add Gift Card", systemImage: "plus")
                }
            }
        }
    }
    
    func addGiftCard() {
        let newCard = GiftCard(store: "Scheels", balance: 100.00)
        
        modelContext.insert(newCard)
    }
}

#Preview {
    ContentView()
}
