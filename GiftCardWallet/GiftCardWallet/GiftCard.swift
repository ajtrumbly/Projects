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
    @Attribute(.unique) var id: String
    var store: String
    var balance: Double
    var barcodeValue: String
    var barcodeType: String
    @Relationship(deleteRule: .cascade) var transactions: [Transaction] = []
    
    init(id: String = UUID().uuidString, store: String, balance: Double) {
        self.id = id
        self.store = store
        self.balance = balance
        self.barcodeValue = ""
        self.barcodeType = ""
    }
    
    static var example: GiftCard {
        let giftCard = GiftCard(store: "Scheels", balance: 100.00)
        giftCard.barcodeValue = "00614207"
        giftCard.barcodeType = "EAN-8"
        return giftCard
    }
}
