//
//  LocationsListView.swift
//  Weather
//
//  Created by Sarah Clark on 9/21/23.
//

import SwiftUI

struct LocationsListView: View {
    var locations: [Location] = Location.previewLocations

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(locations, id: \.id) { location in
                        LocationRow(location: location)
                    }
                }
            }
        }
    }
}

#Preview {
    LocationsListView()
}
