//
//  GiftCard.swift
//  GiftCardWallet
//
//  Created by Austin Trumbly on 7/2/24.
//

import Foundation
import SwiftData

@Model
class GiftCard: Identifiable {
    var id = UUID().uuidString
    var store: String
    var balance: Double
    
    init(store: String, balance: Double) {
        self.store = store
        self.balance = balance
    }
    
    static let example = GiftCard(store: "Example", balance: 100.00)
}
