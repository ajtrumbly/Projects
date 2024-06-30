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
    
    /// Initializer when creating a new gift card.
    /// The dates, pin, and notes are optional/automatically assigned
    /// values to be changed at a later date
    /// - Parameters:
    ///   - store: Assign the store to be redeemed at
    ///   - barcodeType: Assign the barcode type which will be needed for recreation
    ///   - barcodeValue: Assign the value of the barcode to use in conjunction with the barcodeType
    ///   - balance: Assign the starting balance
    init(store: String, 
         barcodeType: String,
         barcodeValue: String,
         balance: Double) {
        self.store = store
        self.barcodeType = barcodeType
        self.barcodeValue = barcodeValue
        self.balance = balance
    }
    
    // Example Gift Card to be used when testing or as a placeholder
    static let example = GiftCard(
        store: "Scheels",
        barcodeType: "UPC-A",
        barcodeValue: "115727^115727rt",
        balance: 100.00)
}
