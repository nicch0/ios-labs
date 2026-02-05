//
//  Page.swift
//  BucketList
//
//  Created by niccho on 19/11/2025.
//

struct Page: Codable, Comparable {
    static func < (lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }

    let pageid: Int
    let title: String
    let terms: [String: [String]]?

    var description: String {
        if let rawDescription = terms?["description"]?.first {
            return rawDescription.prefix(1).uppercased() + rawDescription.dropFirst()
        } else {
            return ""
        }
    }
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Result: Codable {
    let query: Query
}
