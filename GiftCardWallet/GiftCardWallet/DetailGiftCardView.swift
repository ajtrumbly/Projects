//
//  DetailGiftCardView.swift
//  GiftCardWallet
//
//  Created by Austin Trumbly on 7/3/24.
//

import SwiftUI

struct DetailGiftCardView: View {
    var giftCard: GiftCard
    
    var body: some View {
        Text(giftCard.store)
    }
}

#Preview {
    DetailGiftCardView(giftCard: .example)
}
