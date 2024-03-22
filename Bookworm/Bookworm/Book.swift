//
//  Book.swift
//  Bookworm
//
//  Created by Austin Trumbly on 3/16/24.
//

import Foundation
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var reveiw: String
    var rating: Int
    
    init(title: String, author: String, genre: String, reveiw: String, rating: Int) {
        self.title = title
        self.author = author
        self.genre = genre
        self.reveiw = reveiw
        self.rating = rating
    }
}
