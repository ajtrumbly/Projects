//
//  DataController-StoreKit.swift
//  PortfolioApp
//
//  Created by Austin Trumbly on 7/23/24.
//

import Foundation
import StoreKit

extension DataController {
    static let unlockPremiumProductID = "me.Trumbly.Austin.PortfolioApp.premiumUnlock"
    
    var fullVersionUnlocked: Bool {
        get {
            defaults.bool(forKey: "fullVersionUnlocked")
        }
        
        set {
            defaults.setValue(newValue, forKey: "fullVersionUnlocked")
        }
    }
    
    func monitorTransactions() async {
        // Check for previous purchases.
        for await entitlement in Transaction.currentEntitlements {
            if case let .verified(transaction) = entitlement {
                await finalize(transaction)
            }
        }
        
        // Watch for future transactions coming in.
        for await update in Transaction.updates {
            if let transaction = try? update.payloadValue {
                await finalize(transaction)
            }
        }
    }
    
    func purchase(_ product: Product) async throws {
        let result = try await product.purchase()
        
        if case let .success(validation) = result {
            try await finalize(validation.payloadValue)
        }
    }
    
    @MainActor
    func finalize(_ transaction: Transaction) async {
        if transaction.productID == Self.unlockPremiumProductID {
            objectWillChange.send()
            fullVersionUnlocked = transaction.revocationDate == nil
            await transaction.finish()
        }
    }
}
