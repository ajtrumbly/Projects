//
//  WalletView.swift
//  GiftCardWallet
//
//  Created by Austin Trumbly on 7/3/24.
//

import SwiftUI
import SwiftData

struct WalletView: View {
    @Environment(\.modelContext) var modelContext
    @Query var wallet: [GiftCard]
    
    var body: some View {
        List {
            ForEach(wallet, id: \.id) { giftCard in
                NavigationLink(value: giftCard) {
                    Text(giftCard.store)
                }
            }
            .onDelete(perform: removeGiftCard)
        }
    }
    
    func removeGiftCard(at offsets: IndexSet) {
        for offset in offsets {
            let giftCard = wallet[offset]
            modelContext.delete(giftCard)
        }
    }
}

#Preview {
    WalletView()
}