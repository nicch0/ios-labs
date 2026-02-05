//
//  NavigationPathStore.swift
//  Moonshot
//
//  Created by niccho on 8/11/2025.
//

import SwiftUI

@Observable
class NavigationPathStore {
    var path: NavigationPath {
        didSet {
            print("saving path \(path.count)")
            save()
        }
    }

    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")

    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(
                NavigationPath.CodableRepresentation.self,
                from: data
            ) {
                path = NavigationPath(decoded)
                return
            }
        }

        path = NavigationPath()
    }

    func save() {
        // first check if we can have a Codable representation of our path
        guard let codable = path.codable else { return }

        do {
            let data = try JSONEncoder().encode(codable)
            try data.write(to: savePath)
        } catch {
            print("Error saving navigation path data")
        }
    }
}
