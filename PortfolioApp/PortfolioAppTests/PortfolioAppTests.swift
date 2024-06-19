//
//  PortfolioAppTests.swift
//  PortfolioAppTests
//
//  Created by Austin Trumbly on 6/19/24.
//
import CoreData
import XCTest
@testable import PortfolioApp

class BaseTestCase: XCTestCase {
    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!
    
    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }
}
