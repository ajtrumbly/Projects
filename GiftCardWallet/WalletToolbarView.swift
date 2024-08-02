//
//  WalletToolbarView.swift
//  GiftCardWallet
//
//  Created by Austin Trumbly on 8/2/24.
//

import SwiftUI

struct WalletToolbarView: ToolbarContent {
    @Binding var selectedCard: GiftCard?
    @Environment(\.modelContext) private var modelContext

    var body: some ToolbarContent {
        if let selectedCard = selectedCard {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    selectedCard.favorite.toggle()
                    try? modelContext.save()
                }) {
                    Image(systemName: selectedCard.favorite ? "star.fill" : "star")
                }
                
                NavigationLink(destination: DetailGiftCardView(giftCard: selectedCard)) {
                    Image(systemName: "ellipsis.circle")
                }
            }
        } else {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: NewGiftCardView()) {
                    Label("Add Gift Card", systemImage: "plus")
                }
            }
        }
    }
}
