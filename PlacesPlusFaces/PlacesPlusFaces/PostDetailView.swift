//
//  PostDetailView.swift
//  PlacesPlusFaces
//
//  Created by niccho on 25/11/2025.
//

import MapKit
import SwiftData
import SwiftUI

struct PostDetailView: View {
    let post: Post

    init(post: Post) {
        self.post = post
    }

    var startPosition: MapCameraPosition? {
        guard let coordinates = post.coordinates else { return nil }

        return MapCameraPosition.region(
            MKCoordinateRegion(
                center: coordinates,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        )
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .aspectRatio(1.0, contentMode: .fit)
                    .overlay {
                        if let image = post.image {
                            image.resizable().scaledToFill()
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .containerRelativeFrame(.horizontal) { width, _ in
                        width * 0.95
                    }

                CarouselView(text: post.name)

                if let postCoordinates = post.coordinates, let startPosition {
                    Map(initialPosition: startPosition) {
                        Marker(
                            post.name,
                            coordinate: CLLocationCoordinate2D(
                                latitude: postCoordinates.latitude,
                                longitude: postCoordinates.longitude
                            )
                        )
                    }
                    .aspectRatio(1.0, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .containerRelativeFrame(.horizontal) { width, _ in
                        width * 0.95
                    }
                }

                Spacer()
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Post.self, configurations: config)
        let post = Post.examples.first!

        return PostDetailView(post: post).modelContainer(container)
    } catch {
        return Text("Failed to create preview")
    }
}
