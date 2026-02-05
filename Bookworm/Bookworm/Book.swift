//
//  Book.swift
//  Bookworm
//
//  Created by niccho on 11/11/2025.
//

import SwiftData
import SwiftUI

@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    var reviewDate: Date
    
    init(title: String, author: String, genre: String, review: String, rating: Int) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        self.reviewDate = .now
    }
}
