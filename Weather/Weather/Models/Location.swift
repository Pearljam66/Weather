//
//  Location.swift
//  Weather
//
//  Created by Sarah Clark on 10/7/23.
//

import CoreLocation
import Foundation

struct Location: Identifiable {
    var id: Int

    var city: String
    var country: String
    var latitude: Double
    var longitude: Double
}

extension Location {
    static var previewLocations: [Location] {
        return [
            Location(id: 1, city: "Chicago", country: "United States", latitude: 41.94433105288241, longitude: -87.6698008739112),
            Location(id: 2, city: "Erie", country: "United States", latitude: 40.114653755620864, longitude: -105.12333852620154),
            Location(id: 3, city: "Budapest", country: "Hungary", latitude: 47.500741705595175, longitude: 19.051962660114555),
            Location(id: 4, city: "Olympia", country: "United States", latitude: 47.040027978214056, longitude: -122.89558583864923)
        ]
    }
}
