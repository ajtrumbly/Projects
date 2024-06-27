//
//  PerformanceTests.swift
//  PortfolioAppTests
//
//  Created by Austin Trumbly on 6/24/24.
//

import XCTest
@testable import PortfolioApp

final class PerformanceTests: BaseTestCase {
    func testAwardsCalculationPerformance() {
        for _ in 1...100 {
            dataController.createSampleData()
        }
        let awards = Array(repeating: Award.allAwards, count: 25).joined()
        XCTAssertEqual(awards.count, 500, "This checks the awards count is constant. Change this if you add awards")
        
        measure {
            _ = awards.filter(dataController.hasEarned)
        }
    }
}
