//
//  WalletView.swift
//  GiftCardWallet
//
//  Created by Austin Trumbly on 7/3/24.
//

import SwiftUI
import SwiftData

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 5) // Reduced from 60 to 30
    }
}

struct WalletView: View {
    @Environment(\.modelContext) var modelContext
    @Query var wallet: [GiftCard]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                HStack {
                    Spacer()
                    VStack {
                        ForEach(wallet.indices, id: \.self) { index in
                            let giftCard = wallet[index]
                            NavigationLink(value: giftCard) {
                                WalletCardView(giftCard: giftCard)
                                    .offset(y: -CGFloat(index) * 20)
                            }
                        }
                    }
                    .frame(height: geometry.size.height + CGFloat(wallet.count - 1) * 160)
                    Spacer()
                }
            }
            .background(Color(UIColor.systemGroupedBackground))
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return WalletView()
            .modelContainer(previewer.container)
    } catch {
       return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
