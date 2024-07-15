//
//  Transactions.swift
//  GiftCardWallet
//
//  Created by Austin Trumbly on 7/12/24.
//

import Foundation
import SwiftData

@Model
class Transaction: Identifiable {
    let id: UUID
    var amount: Double
    var date: Date
    var notes: String?
    var giftCard: GiftCard?
    
    init(id: UUID = UUID(), amount: Double, date: Date = Date(), notes: String? = nil, giftCard: GiftCard? = nil) {
        self.id = id
        self.amount = amount
        self.date = date
        self.notes = notes
        self.giftCard = giftCard
    }
}
