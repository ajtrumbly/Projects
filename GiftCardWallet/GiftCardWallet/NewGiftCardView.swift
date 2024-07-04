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
    
    @State private var store = ""
    @State private var balance = 0.0
    
    @State private var isShowingScanner = false
    @State private var scannedCode = ""
    @State private var barcodeType = ""
    
    var body: some View {
        Form {
            Section("Card Details") {
                TextField("Store name", text: $store)
                TextField("Enter balance", value: $balance, format: .number)
                    .keyboardType(.decimalPad)
                TextField("Barcode value", text: $scannedCode)
                TextField("Barcode type", text: $barcodeType)
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
            NavigationStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 2)
                        .frame(width: 300, height: 180)
                    BarcodeScannerView(scannedCode: $scannedCode, barcodeType: $barcodeType)
                        .frame(height: .infinity)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: {
                                    isShowingScanner = false  // This replaces dismiss()
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                }
            }
            .presentationDetents([.medium])
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
