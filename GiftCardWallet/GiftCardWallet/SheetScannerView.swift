//
//  SheetScannerView.swift
//  GiftCardWallet
//
//  Created by Austin Trumbly on 8/1/24.
//

import SwiftUI

struct SheetScannerView: View {
    @Binding var barcodeValue: String
    @Binding var barcodeType: String
    @Binding var isShowingScanner: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                BarcodeScannerView(scannedCode: $barcodeValue, barcodeType: $barcodeType)
                    
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
