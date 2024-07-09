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
    do {
        let previewer = try Previewer()
        
        return ContentView()
            .modelContainer(previewer.container)
    } catch {
       return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
