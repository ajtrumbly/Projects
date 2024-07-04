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
    @State private var path = NavigationPath()
    
    var body: some View {
        VStack {
            NavigationStack(path: $path) {
                // TODO: Format the cards like the wallet app
                WalletView()
                    .navigationTitle("Wallet")
                    .navigationDestination(for: GiftCard.self) { giftCard in
                        DetailGiftCardView(giftCard: giftCard)
                    }
                    .toolbar {
                        NavigationLink(destination: NewGiftCardView()) {
                            Label("Add Gift Card", systemImage: "plus")
                        }
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
