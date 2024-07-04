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
            
            Section("Card Details") {
                VStack {
                    GenerateBarcodeView(giftCard: giftCard)
                    
                    Text("Gift card code: \(giftCard.barcodeValue)")
                    Text("Barcode type: \(giftCard.barcodeType)")
                }
            }
        }
        .navigationTitle("\(giftCard.store) Gift Card")
    }
}

#Preview {
    DetailGiftCardView(giftCard: .example)
}
