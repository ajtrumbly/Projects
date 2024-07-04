//
//  DetailGiftCardView.swift
//  GiftCardWallet
//
//  Created by Austin Trumbly on 7/3/24.
//

import SwiftUI

struct DetailGiftCardView: View {
    @Environment(\.modelContext) var modelContext
    
    @Bindable var giftCard: GiftCard
    
    var body: some View {
        Form {
            TextField("Enter the name of the store", text: $giftCard.store)
            TextField("Enter the balance", value: $giftCard.balance, format: .number)
                .keyboardType(.decimalPad)
        }
        .navigationTitle("Edit Gift Card")
    }
}

#Preview {
    DetailGiftCardView(giftCard: .example)
}
