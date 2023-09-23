//
//  CurrentWeatherView.swift
//  Weather
//
//  Created by Sarah Clark on 9/21/23.
//

import CoreLocation
import SwiftUI
import WeatherKit

struct CurrentWeatherView: View {
    var locationManager = LocationManager()
    var weatherServiceHelper = WeatherData.shared

    @State var attribution: WeatherAttribution?
    @State var isLoading = true
    @State var currentLocation: CLLocation?

    @State var stateText: String = "Loading.."

    @State var currentWeather: CurrentWeather?
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                if isLoading {
                    ProgressView()
                }

                if let current = currentWeather, !isLoading {
                    Image(systemName: current.symbolName)
                        .font(.system(size: 75.0, weight: .bold))

                    Text(current.condition.description)
                        .font(Font.system(.largeTitle))

                    let tUnit = current.temperature.unit.symbol
                    Text("\(current.temperature.value.formatted(.number.precision(.fractionLength(1))))\(tUnit)")
                        .font(Font.system(.title))

                    Spacer()

                    VStack(alignment: .leading) {
                        Text("Feels like: \(current.temperature.converted(to: .fahrenheit).description)")
                            .font(Font.system(.title2))
                        Text("Humidity: \((current.humidity * 100).formatted(.number.precision(.fractionLength(1))))%")
                            .font(Font.system(.title2))
                        Text("Wind Speed: \(Int(current.wind.speed.value)), \(current.wind.compassDirection.description)")
                            .font(Font.system(.title2))
                        Text("UV Index: \(current.uvIndex.value)")
                            .font(Font.system(.title2))
                    }
                    Spacer()
                    Divider()
                } else {
                    Text(stateText)
                }
            }
            .navigationTitle("Weather Now")
            .padding()
        }
        .task {
            isLoading = true
            self.locationManager.updateLocation(handler: locationUpdated)
        }
    }


    func locationUpdated(location: CLLocation?, error: Error?) {
        if let currentLocation: CLLocation = location, error == nil {
            Task.detached {
                isLoading = false
                currentWeather = await weatherServiceHelper.currentWeather(for: currentLocation)
                stateText = ""
            }
        } else {
            stateText = "Cannot get your location. \n \(error?.localizedDescription ?? "")"
            isLoading = false
        }
    }
}

#Preview {
    CurrentWeatherView()
}
