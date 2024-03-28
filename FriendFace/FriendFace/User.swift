//
//  User.swift
//  FriendFace
//
//  Created by Austin Trumbly on 3/25/24.
//

import Foundation
import SwiftData

@Model
class User: Codable {
    let id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var friends: [Friend]
    
    enum CodingKeys: CodingKey {
        case id, isActive, name, age, company, email, address, friends
    }
    
    static let example = User(id: UUID(), isActive: true, name: "Test Name", age: 25, company: "Test Company", email: "test@test.com", address: "test address", friends: [])
    
    init(id: UUID, isActive: Bool, name: String, age: Int, company: String, email: String, address: String, friends: [Friend]) {
        self.id = id
        self.isActive = isActive
        self.name = name
        self.age = age
        self.company = company
        self.email = email
        self.address = address
        self.friends = friends
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        isActive = try container.decode(Bool.self, forKey: .isActive)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int.self, forKey: .age)
        company = try container.decode(String.self, forKey: .company)
        email = try container.decode(String.self, forKey: .email)
        address = try container.decode(String.self, forKey: .address)
        friends = try container.decode([Friend].self, forKey: .friends)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(isActive, forKey: .isActive)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(company, forKey: .company)
        try container.encode(email, forKey: .email)
        try container.encode(address, forKey: .address)
        try container.encode(friends, forKey: .friends)
    }
}
