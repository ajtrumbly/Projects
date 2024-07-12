//
//  Transactions.swift
//  GiftCardWallet
//
//  Created by Austin Trumbly on 7/12/24.
//

import Foundation
import SwiftData

@Model
class Transaction {
    @Relationship(deleteRule: .cascade) var transactions: [Double]? = [Double]()
    
    init() { }
}
