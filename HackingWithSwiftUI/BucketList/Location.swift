//
//  Location.swift
//  BucketList
//
//  Created by Warren Su on 7/25/25.
//

import SwiftUI
import MapKit
struct Location: Codable, Equatable, Identifiable {
    
    var id = UUID()
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    static let example = Location(
            name: "Statue of Liberty",
            description: "An iconic landmark in NYC",
            latitude: 40.6892,
            longitude: -74.0445
        )
}


