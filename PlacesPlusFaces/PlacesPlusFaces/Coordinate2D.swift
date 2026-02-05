//
//  Coordinate2D.swift
//  PlacesPlusFaces
//
//  Created by niccho on 25/11/2025.
//

import MapKit

struct Coordinate2D: Codable {
    let latitude: Double
    let longitude: Double
}

extension CLLocationCoordinate2D {
    func toCoordinate2D() -> Coordinate2D {
        return Coordinate2D(latitude: latitude, longitude: longitude)
    }
}
