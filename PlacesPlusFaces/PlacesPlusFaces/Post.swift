//
//  Post.swift
//  PlacesPlusFaces
//
//  Created by niccho on 25/11/2025.
//
import MapKit
import SwiftData
import SwiftUI


@Model
class Post: Identifiable {
    var id = UUID()
    var name: String

    @Attribute(.externalStorage)
    var imageData: Data

    var createdAt: Date

    private var location: Coordinate2D?

    var coordinates: CLLocationCoordinate2D? {
        guard let location else { return nil }

        return CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    }

    init(name: String, imageData: Data, createdAt: Date, location: Coordinate2D?) {
        self.name = name
        self.imageData = imageData
        self.createdAt = createdAt
        self.location = location
    }

    @Transient
    var image: Image? {
        guard let uiImage = UIImage(data: imageData) else { return nil }
        return Image(uiImage: uiImage)
    }

    static var examples: [Post] {
        var posts = [Post]()
        let prefix = "sample"

        for num in 1 ..< 20 {
            let fileName = "\(prefix)\(num)"
            let image = UIImage(named: fileName)
            if let data = image?.pngData() {
                posts
                    .append(
                        Post(
                            name: fileName.uppercased(),
                            imageData: data,
                            createdAt: .now,
                            location: Coordinate2D(latitude: -33.868820, longitude: 151.209290)
                        )
                    )
            }
        }
        return posts
    }
}
