//
//  GiftCardWalletApp.swift
//  GiftCardWallet
//
//  Created by Austin Trumbly on 7/2/24.
//

import SwiftUI
import SwiftData

@main
struct GiftCardWalletApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [GiftCard.self, Transaction.self])
    }
}
