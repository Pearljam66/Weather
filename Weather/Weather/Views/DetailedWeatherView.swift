//
//  DetailedWeatherView.swift
//  Weather
//
//  Created by Sarah Clark on 10/7/23.
//

import Charts
import CoreLocation
import SwiftUI
import WeatherKit

struct DetailedWeatherView: View {
    var location: Location
    var weatherServiceHelper = WeatherData.shared
    @State var isLoading = false
    @State var stateText = ""

    @State var dailyForecast: Forecast<DayWeather>?
    @State var hourlyForecast: Forecast<HourWeather>?

    var body: some View {
        NavigationView {
            VStack {
                Text("Detailed Forecast")

                if isLoading {
                    ProgressView()
                }

                Text(stateText)

                ScrollView {
                    VStack {
                        if let daily = dailyForecast {
                            Text("10-day overview").font(Font.system(.title))
                            ScrollView(.horizontal) {
                                HStack(spacing: 10) {
                                    ForEach(daily, id: \.date) { day in
                                        DayDetailsCell(dayWeather: day)
                                        Divider()
                                    }
                                }
                                .frame(height: 150.0)
                            }
                            .padding(.all, 5)
                            Divider()

                            Text("moon phases").font(Font.system(.title3))
                            ScrollView(.horizontal) {
                                HStack(spacing: 10) {
                                    ForEach(daily, id: \.date) { day in
                                        Image(systemName: day.moon.phase.symbolName)
                                            .font(.system(size: 25.0, weight: .bold))
                                            .padding(.all, 3.0)
                                        Divider()
                                    }
                                }
                                .frame(height: 100.0)
                            }
                            .padding(.all, 5)
                            Divider()
                            let range = WeatherDataHelper.findDailyTempMinMax(daily)

                            Chart(daily, id: \.date) { day in
                                LineMark( //1
                                    x: .value("Day", day.date),
                                    y: .value("Temperature", (day.lowTemperature.value + day.highTemperature.value) / 2)
                                )
                                .foregroundStyle(.orange)
                                .symbol(.circle)
                                .interpolationMethod(.catmullRom)
                                AreaMark( //2
                                    x: .value("Day", day.date),
                                    yStart: .value("Low", day.lowTemperature.value),
                                    yEnd: .value("High", day.highTemperature.value)
                                )
                                .foregroundStyle(
                                    Gradient(
                                        colors: [
                                            .orange.opacity(0.4),
                                            .blue.opacity(0.4)
                                        ]
                                    )
                                )
                            }
                            .chartForegroundStyleScale([ //3
                                "avg": .orange,
                                "low": .blue,
                                "high": .orange
                                                       ])
                            .chartYScale(domain: range.min - 5...range.max + 5) //4
                            .chartYAxisLabel(daily[0].lowTemperature.unit.symbol) //5
                            .chartXAxis { //6
                                AxisMarks(values: .automatic(minimumStride: 10, desiredCount: 10)) { _ in
                                    AxisGridLine()
                                    AxisTick()
                                    AxisValueLabel(format: .dateTime.day())
                                }
                            }
                            .frame(
                                height: 350.0
                            )

                            Divider()

                        }

                        if let hourly = hourlyForecast {
                            Text("Hourly Forecast").font(Font.system(.title))
                            Text("Next 25 hours").font(Font.system(.caption))

                            ScrollView(.horizontal) {
                                HStack(spacing: 15) {
                                    ForEach(hourly, id: \.date) { hour in
                                        HourDetailsCell(hourWeather: hour)
                                        Divider()
                                    }
                                }
                                .frame(height: 100.0)
                            }
                            .padding(.all, 5)

                            Divider()

                            let range = WeatherDataHelper.findHourlyTempMinMax(hourly)

                            Chart(hourly, id: \.date) { hour in
                                LineMark(
                                    x: .value("Day", hour.date),
                                    y: .value("Temperature", hour.temperature.value)
                                )
                                .foregroundStyle(.orange)
                                .symbol(.circle)
                                .interpolationMethod(.catmullRom)
                            }
                            .chartYScale(domain: range.min - 5...range.max + 5)
                            .chartYAxisLabel(hourly[0].temperature.unit.symbol)
                            .chartXAxis {
                                AxisMarks(values: .automatic(minimumStride: 10)) { _ in
                                    AxisGridLine()
                                    AxisTick()
                                    AxisValueLabel(
                                        format: .dateTime.hour().minute()
                                    )
                                }
                            }
                            .frame(
                                height: 350.0
                            )


                            Divider()
                        }

                    }
                }
            }
            .navigationTitle("\(location.city)")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                isLoading = true
                Task.detached {
                    dailyForecast = await weatherServiceHelper.dailyForecast(
                        for: CLLocation(
                            latitude: location.latitude,
                            longitude: location.longitude
                        )
                    )
                    hourlyForecast = await weatherServiceHelper.hourlyForecast(
                        for: CLLocation(
                            latitude: location.latitude,
                            longitude: location.longitude
                        )
                    )
                    isLoading = false
                }

            }
        }
    }
}

struct DetailedWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedWeatherView(location: Location.previewLocations[0])
    }
}
