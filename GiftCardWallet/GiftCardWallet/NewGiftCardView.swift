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
    
    var body: some View {
        Form {
            Text("Hello World")
        }
    }
}

#Preview {
    NewGiftCardView()
}
