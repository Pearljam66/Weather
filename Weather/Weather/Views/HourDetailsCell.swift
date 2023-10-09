//
//  HourDetailsCell.swift
//  Weather
//
//  Created by Sarah Clark on 10/9/23.
//

import SwiftUI
import WeatherKit

struct HourDetailsCell: View {
    var hourWeather: HourWeather?

    var body: some View {
        if let hour = hourWeather {
            VStack {
                Text(hour.date.formatted(.dateTime.hour()))
                    .font(.system(size: 13.0))
                Divider()

                Image(systemName: hour.symbolName)
                    .font(.system(size: 22.0, weight: .bold))
                    .padding(.bottom, 3.0)
                Text("\((hour.precipitationChance * 100).formatted(.number.precision(.fractionLength(1))))%")
                    .foregroundColor(.blue)
                    .font(.system(size: 15.0))
            }
        }
    }
}

#Preview {
    HourDetailsCell()
}
