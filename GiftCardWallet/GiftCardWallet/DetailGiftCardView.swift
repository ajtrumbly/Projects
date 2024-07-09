//
//  DetailGiftCardView.swift
//  GiftCardWallet
//
//  Created by Austin Trumbly on 7/3/24.
//

import SwiftUI
import SwiftData

struct DetailGiftCardView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Bindable var giftCard: GiftCard
    @State private var showingDelete = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Custom title view
            HStack {
                Text(giftCard.store)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Button(action: {
                    showingDelete = true
                }) {
                    Image(systemName: "ellipsis.circle")
                        .font(.title2)
                }
                .padding()
            }
            .background(Color(UIColor.systemBackground))
            
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
        }
        .alert("Delete Gift Card", isPresented: $showingDelete) {
                    Button("Delete", role: .destructive, action: deleteCard)
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Are you sure you want to delete this gift card? This action cannot be undone.")
                }
    }
    
    func deleteCard() {
        modelContext.delete(giftCard)
        dismiss()
    }
}

#Preview {
    DetailGiftCardView(giftCard: .example)
}
