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
        return self.offset(y: offset / 20)
    }
}

struct WalletView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \GiftCard.store) var wallet: [GiftCard]
    
    @State private var selectedCard: GiftCard? = nil
    @State private var cardOffset: CGSize = .zero
    @State private var cardScale: CGFloat = 1.0
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Wallet")
                        .font(.system(size: 32).bold())
                        .padding(.leading, 20)
                    
                    Spacer()
                }
                ZStack {
                    if let selectedCard = selectedCard {
                        Color.clear
                            .ignoresSafeArea()
                        WalletTapCardView(giftCard: selectedCard, cardOffset: $cardOffset, cardScale: $cardScale)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    self.selectedCard = nil
                                    cardOffset = .zero
                                    cardScale = 1.0
                                }
                            }
                            .zIndex(1) // Ensure the selected card is always on top
                    } else {
                        ScrollView(.vertical, showsIndicators: false) {
                            ForEach(wallet.indices, id: \.self) { index in
                                WalletCardView(giftCard: wallet[index])
                                    .stacked(at: index, in: wallet.count)
                                    .onTapGesture {
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                            selectedCard = wallet[index]
                                            cardScale = 1.1
                                        }
                                    }
                            }
                        }
                    }
                }
            }
            .toolbar {
                if selectedCard == nil {
                    NavigationLink(destination: NewGiftCardView()) {
                        Label("Add Gift Card", systemImage: "plus")
                    }
                } else {
                    NavigationLink(destination: DetailGiftCardView(giftCard: selectedCard!)) {
                        Label("Card Details", systemImage: "ellipsis.circle")
                    }
                }
            }
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
