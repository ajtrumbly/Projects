//
//  NewGiftCardView.swift
//  GiftCardWallet
//
//  Created by Austin Trumbly on 7/3/24.
//

import SwiftUI
import SwiftData

struct NewGiftCardView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var store = "Enter the store name"
    @State private var balance = 0.0
    
    @State private var isShowingScanner = false
    @State private var scannedCode = "Unscanned code"
    @State private var barcodeType = "Unscanned code type"
    
    var body: some View {
        Form {
            Section("Card Details") {
                TextEditor(text: $store)
                TextField("Enter balance", value: $balance, format: .number)
                    .keyboardType(.decimalPad)
                Text("Gift card code: \(scannedCode)")
                Text("Gifr carde barcode: \(barcodeType)")
                Button("Scan gift card") {
                    isShowingScanner.toggle()
                }
            }
        }
        .toolbar {
            Button("Save", action: makeGiftCard)
        }
        .navigationTitle("Add Gift Card")
        .sheet(isPresented: $isShowingScanner) {
            BarcodeScannerView(scannedCode: $scannedCode, barcodeType: $barcodeType)
                .frame(height: 300)
                .presentationDetents([.medium])
                .navigationTitle("Scan Barcode")
        }
    }
    
    func makeGiftCard() {
        let giftCard = GiftCard(store: store, balance: balance)
        modelContext.insert(giftCard)
        dismiss()
    }
}

#Preview {
    NewGiftCardView()
}
