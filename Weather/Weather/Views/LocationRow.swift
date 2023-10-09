//
//  LocationRow.swift
//  Weather
//
//  Created by Sarah Clark on 10/7/23.
//

import SwiftUI

struct LocationRow: View {
    var location: Location

    var body: some View {
        NavigationLink("\(location.city), \(location.country)", destination: DetailedWeatherView(location: location))
    }
}

#Preview {
    LocationsListView()
}
