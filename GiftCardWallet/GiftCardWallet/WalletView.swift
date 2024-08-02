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
    
    func copyFeedback(textToCopy: String) -> some View {
            self.modifier(CopyFeedbackModifier(textToCopy: textToCopy))
        }
}

struct WalletView: View {
    @State private var selectedTab = 0
    @State private var selectedCard: GiftCard?
    @State private var cardOffset: CGSize = .zero
    @State private var cardScale: CGFloat = 1.0

    @Query private var allGiftCards: [GiftCard]
    @Query private var favoriteGiftCards: [GiftCard]

    init() {
        _allGiftCards = Query(sort: \GiftCard.store)
        _favoriteGiftCards = Query(filter: #Predicate<GiftCard> { $0.favorite == true }, sort: \GiftCard.store)
    }

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
                            .zIndex(1)
                    } else {
                        TabView(selection: $selectedTab) {
                            cardListView(cards: favoriteGiftCards)
                                .tabItem {
                                    Label("Favorites", systemImage: "star.fill")
                                }
                                .tag(0)
                            
                            cardListView(cards: allGiftCards)
                                .tabItem {
                                    Label("All Cards", systemImage: "creditcard")
                                }
                                .tag(1)
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

    @ViewBuilder
    func cardListView(cards: [GiftCard]) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(cards.indices, id: \.self) { index in
                WalletCardView(giftCard: cards[index])
                    .stacked(at: index, in: cards.count)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedCard = cards[index]
                            cardScale = 1.1
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
