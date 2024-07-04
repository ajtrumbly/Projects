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
    
    @State private var showingInvalidBalanceAlert = false
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
            Button("Save") {
                if balance > 0 {
                    makeGiftCard()
                } else {
                    showingInvalidBalanceAlert = true
                }
            }
            .alert("Invalid Balance", isPresented: $showingInvalidBalanceAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("The balance must be greater than $0 to add a new card.")
            }
        }
        .navigationTitle("Add Gift Card")
        .sheet(isPresented: $isShowingScanner) {
            NavigationStack {
                ZStack {
                    BarcodeScannerView(scannedCode: $scannedCode, barcodeType: $barcodeType)
                        
                    CardOverlayView()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isShowingScanner = false
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.gray)
                        }
                    }
                }
            }
            .presentationDetents([.medium])
        }
    }
    
    func makeGiftCard() {
        let giftCard = GiftCard(store: store, balance: balance)
        if scannedCode.isEmpty == false {
            giftCard.barcodeValue = scannedCode
        }
        if barcodeType.isEmpty == false {
            giftCard.barcodeType = barcodeType
        }
        
        if giftCard.balance > 0 {
            modelContext.insert(giftCard)
            dismiss()
        }
    }
}

#Preview {
    NewGiftCardView()
}
