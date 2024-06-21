//
//  TagTest.swift
//  PortfolioAppTests
//
//  Created by Austin Trumbly on 6/20/24.
//
import CoreData
import XCTest
@testable import PortfolioApp

final class TagTest: BaseTestCase {
    func testCreatingTagsAndIssues() {
        let count = 10
        
        for _ in 0..<count {
            let tag = Tag(context: managedObjectContext)
            
            for _ in 0..<count {
                let issue = Issue(context: managedObjectContext)
                tag.addToIssues(issue)
            }
        }
        
        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), count, "Expected \(count) tags.")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), count * count, "Expected \(count * count) tags.")
    }
    
    func testDeletingTagDoesNotDeleteIssues() throws {
        dataController.createSampleData()
        
        let request = NSFetchRequest<Tag>(entityName: "Tag")
        let tags = try managedObjectContext.fetch(request)
        
        dataController.delete(tags[0])
        
        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), 4, "Should be 4 tags after deleting 1 from sample data.")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), 50, "Should be 50 issues after deleting a tag from sample data.")
    }
}
