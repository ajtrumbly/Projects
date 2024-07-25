//
//  ContentView.swift
//  FeatureTesting
//
//  Created by Austin Trumbly on 7/24/24.
//

import SwiftUI

struct ContentView: View {
    var cards: [CardMode] = [
        CardMode(tColor: .blue , bColor: .gray, name: "Card 1", num: "**** **** **** 1234"),
        CardMode(tColor: .red , bColor: .gray, name: "Card 2", num: "**** **** **** 2345"),
        CardMode(tColor: .green , bColor: .gray, name: "Card 3", num: "**** **** **** 3456")
    ]
    
    @State private var show = false
    @Namespace var namespace
    @State private var selectedCard: CardMode? = nil
    
    var body: some View {
        ZStack {
            if let selectedCard = selectedCard, show {
                OpenCardView(close: $show, data: selectedCard, namespace: namespace)
            } else {
                ScrollView {
                    VStack {
                        ForEach(cards) { item in
                            CardView(data: item, namespace: namespace)
                                .matchedGeometryEffect(id: item.id, in: namespace)
                                .onTapGesture {
                                    selectedCard = item
                                    withAnimation(.spring(duration: 0.2)) {
                                        show = true
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
