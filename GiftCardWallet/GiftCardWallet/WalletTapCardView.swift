//
//  WalletTapCardView.swift
//  GiftCardWallet
//
//  Created by Austin Trumbly on 7/30/24.
//

import SwiftUI

struct WalletTapCardView: View {
    @Bindable var giftCard: GiftCard
    @Binding var cardOffset: CGSize
    @Binding var cardScale: CGFloat
    @State private var isShowingScanner = false
    
    var body: some View {
        VStack {
            WalletCardView(giftCard: giftCard)
                .scaleEffect(cardScale)
                .offset(cardOffset)
                .rotation3DEffect(.degrees(cardOffset.height / 20), axis: (x: 1, y: 0, z: 0))
                .rotation3DEffect(.degrees(-cardOffset.width / 20), axis: (x: 0, y: 1, z: 0))
            
            Spacer()
            
            if giftCard.barcodeValue.isEmpty == false {
                GenerateBarcodeView(giftCard: giftCard)
                    .padding()
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            } else {
                Button {
                    isShowingScanner = true
                } label: {
                    Label("Scan gift card", systemImage: "camera")
                }
            }
            
            Spacer()
        }
        .sheet(isPresented: $isShowingScanner) {
            SheetScannerView(barcodeValue: $giftCard.barcodeValue, barcodeType: $giftCard.barcodeValue, isShowingScanner: $isShowingScanner)
        }
        .transition(.asymmetric(
            insertion: .scale(scale: 0.1).combined(with: .opacity),
            removal: .scale(scale: 0.3).combined(with: .opacity)
        ))
    }
}

