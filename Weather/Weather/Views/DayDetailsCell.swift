//
//  DayDetailsView.swift
//  Weather
//
//  Created by Sarah Clark on 10/7/23.
//

import SwiftUI
import WeatherKit

struct DayDetailsCell: View {
    var dayWeather: DayWeather?

    var body: some View {
        if let day = dayWeather {
            VStack {
                Text(day.date.formatted(.dateTime.day().month()))
                    .font(.system(size: 15.0))
                Divider()
                Image(systemName: day.symbolName)
                    .font(.system(size: 25.0, weight: .bold))
                    .padding(.bottom, 3.0)

                HStack {
                    VStack {
                        Image(systemName: "sunrise")
                            .font(.system(size: 12.0, weight: .bold))
                            .foregroundColor(.orange)
                        Text(day.sun.sunrise?.formatted(.dateTime.hour().minute()) ?? "?")
                            .font(.system(size: 12.0))
                    }
                    VStack {
                        Image(systemName: "sunset")
                            .font(.system(size: 12.0, weight: .bold))
                            .foregroundColor(.orange)
                        Text(day.sun.sunset?.formatted(.dateTime.hour().minute()) ?? "?")
                            .font(.system(size: 12.0))
                    }
                }
                Divider()

                HStack {
                    VStack {
                        Image(systemName: "moon.circle")
                            .font(.system(size: 13.0, weight: .bold))
                            .foregroundColor(.indigo)
                        Text(day.moon.moonrise?.formatted(.dateTime.hour().minute()) ?? "?")
                            .font(.system(size: 12.0))
                    }
                    VStack {
                        Image(systemName: "moon.haze.circle")
                            .font(.system(size: 13.0, weight: .bold))
                            .foregroundColor(.indigo)
                        Text(day.moon.moonset?.formatted(.dateTime.hour().minute()) ?? "?")
                            .font(.system(size: 12.0))
                    }
                }
            }
        }
    }
}

#Preview {
    DayDetailsCell()
}
