//
//  Previewer.swift
//  GiftCardWallet
//
//  Created by Austin Trumbly on 7/8/24.
//

import SwiftData
import Foundation

@MainActor
struct Previewer {
    let container: ModelContainer
    let giftCard: GiftCard
    let giftCard1: GiftCard
    let giftCard2: GiftCard
    let giftCard3: GiftCard
    let giftCard4: GiftCard
    let giftCard5: GiftCard
    let giftCard6: GiftCard
    let giftCard7: GiftCard
    let giftCard8: GiftCard
    
    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: GiftCard.self, configurations: config)
        
        giftCard = GiftCard(store: "Preview", balance: 150.00)
        giftCard1 = GiftCard(store: "Preview1", balance: 100.00)
        giftCard2 = GiftCard(store: "Preview2", balance: 150.00)
        giftCard3 = GiftCard(store: "Preview3", balance: 100.00)
        giftCard4 = GiftCard(store: "Preview4", balance: 150.00)
        giftCard5 = GiftCard(store: "Preview5", balance: 100.00)
        giftCard6 = GiftCard(store: "Preview6", balance: 150.00)
        giftCard7 = GiftCard(store: "Preview7", balance: 100.00)
        giftCard8 = GiftCard(store: "Preview8", balance: 100.00)
        
        giftCard.barcodeValue = "603086300000548032"
        giftCard.barcodeType = "EAN8"
        
        giftCard1.barcodeValue = "603086300000548033"
        giftCard1.barcodeType = "EAN8"
        
        giftCard2.barcodeValue = "603086300000548034"
        giftCard2.barcodeType = "EAN8"
        
        giftCard3.barcodeValue = "603086300000548035"
        giftCard3.barcodeType = "EAN8"
        
        giftCard4.barcodeValue = "603086300000548036"
        giftCard4.barcodeType = "EAN8"
        
        giftCard5.barcodeValue = "603086300000548037"
        giftCard5.barcodeType = "EAN8"
        
        giftCard6.barcodeValue = "603086300000548038"
        giftCard6.barcodeType = "EAN8"
        
        giftCard7.barcodeValue = "603086300000548039"
        giftCard7.barcodeType = "EAN8"
        
        giftCard8.barcodeValue = "603086300000548040"
        giftCard8.barcodeType = "EAN8"
        
        
        
        container.mainContext.insert(giftCard)
        container.mainContext.insert(giftCard1)
        container.mainContext.insert(giftCard2)
        container.mainContext.insert(giftCard3)
        container.mainContext.insert(giftCard4)
        container.mainContext.insert(giftCard5)
        container.mainContext.insert(giftCard6)
        container.mainContext.insert(giftCard7)
        container.mainContext.insert(giftCard8)
    }
}
