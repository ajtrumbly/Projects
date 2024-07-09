//
//  WalletCardView.swift
//  GiftCardWallet
//
//  Created by Austin Trumbly on 7/8/24.
//

import SwiftUI

struct WalletCardView: View {
    let giftCard: GiftCard
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hue: Double.random(in: 0...1), saturation: 0.5, brightness: 0.9))
                .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(giftCard.store)
                        .font(.title2.bold())
                    Spacer()
                    Image(systemName: "creditcard.fill")
                        .font(.title2)
                }
                
                Spacer()
                
                Text(String(format: "$%.2f", giftCard.balance))
                    .font(.title.bold())
                
                Text("Available Balance")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .frame(width: UIScreen.main.bounds.width - 40, height: 200)
        .padding(.horizontal)
    }
}

#Preview {
    WalletCardView(giftCard: .example)
}
