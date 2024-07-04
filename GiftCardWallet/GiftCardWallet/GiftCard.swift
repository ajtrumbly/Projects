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
    var barcodeValue = ""
    var barcodeType = ""
    
    init(store: String, balance: Double) {
        self.store = store
        self.balance = balance
    }
    
    static var example: GiftCard {
        var giftCard = GiftCard(store: "Scheels", balance: 100.00)
        giftCard.barcodeValue = "00614207"
        giftCard.barcodeType = "EAN-8"
        return giftCard
    }
}
