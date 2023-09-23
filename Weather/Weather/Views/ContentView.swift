//
//  ContentView.swift
//  Weather
//
//  Created by Sarah Clark on 9/19/23.
//

import CoreLocation
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            TabView {
                CurrentWeatherView()
                    .tabItem {
                        Image(systemName: "cloud.drizzle.circle")
                        Text("Current")
                    }
                LocationsListView()
                    .tabItem {
                        Image(systemName: "calendar.circle")
                        Text("Detailed")
                    }
            }
        }
        .navigationTitle("Weather")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}

#Preview {
    ContentView()
}
