//
//  GiftCard.swift
//  GiftCardWallet
//
//  Created by Austin Trumbly on 6/26/24.
//

import Foundation
import SwiftData


@Model
/// A gift card model that will be used within the app to store each individual gift card.
struct GiftCard {
    var store: String
    var barcodeType: String
    var barcodeValue: String
    var balance: Double
    var creationDate = Date.now
    var lastModifiedDate: Date = Date.now
    var pin: Int?
    var notes: String?
    
    
    init(store: String, barcodeType: String, barcodeValue: String, balance: Double, creationDate: Foundation.Date = Date.now, lastModifiedDate: Date, pin: Int, notes: String) {
        self.store = store
        self.barcodeType = barcodeType
        self.barcodeValue = barcodeValue
        self.balance = balance
        self.creationDate = creationDate
        self.lastModifiedDate = lastModifiedDate
        self.pin = pin
        self.notes = notes
    }
    
    static let example = GiftCard(store: "Scheels", barcodeType: "UPC-A", barcodeValue: "115727^115727rt", balance: 100.00, creationDate: .distantPast, lastModifiedDate: .now, pin: 1234, notes: "This is a test gift card.")
}
