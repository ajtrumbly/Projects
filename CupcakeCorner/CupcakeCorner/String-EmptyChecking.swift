//
//  String-EmptyChecking.swift
//  CupcakeCorner
//
//  Created by Austin Trumbly on 3/14/24.
//

import Foundation

extension String {
    var isReallyEmpty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
