//
//  WeatherData.swift
//  Weather
//
//  Created by Sarah Clark on 9/21/23.
//

import CoreLocation
import Foundation
import OSLog
import WeatherKit

class WeatherData {
    let logger = Logger(subsystem: "com.Sarah.Weather", category: "Model")
    static let shared = WeatherData()
    private let service = WeatherService.shared

    func currentWeather(for location: CLLocation) async -> CurrentWeather? {
        let currentWeather = await Task.detached(priority: .userInitiated) {
            let forecast = try? await self.service.weather(for: location, including: .current)
            return forecast
        }.value
        return currentWeather
    }

    func dailyForecast(for location: CLLocation) async -> Forecast<DayWeather>? {
        let dailyForecast = await Task.detached(priority: .userInitiated) {
            let forecast = try? await self.service.weather(for: location, including: .daily)
            return forecast
        }.value
        return dailyForecast
    }

    func hourlyForecast(for location: CLLocation) async -> Forecast<HourWeather>? {
        let hourlyForecast = await Task.detached(priority: .userInitiated) {
            let forecast = try? await self.service.weather (for: location, including: .hourly)
            return forecast
        }.value
        return hourlyForecast
    }

    func weatherAttribution() async -> WeatherAttribution? {
        let weatherAttribute = await Task.detached(priority: .userInitiated) {
            return try? await self.service.attribution
        }.value
        return weatherAttribute
    }
}

enum WeatherDataHelper {
    public static func findDailyTempMinMax(_ daily: Forecast<DayWeather>) -> (min: Double, max: Double) {
        let minElement = daily.min {valueA, valueB in
            valueA.lowTemperature.value < valueB.lowTemperature.value
        }
        let min = minElement?.lowTemperature.value ?? 0

        let maxElement = daily.max { valueA, valueB in
            valueA.highTemperature.value < valueB.highTemperature.value
        }
        let max = maxElement?.highTemperature.value ?? 200

        return (min, max)
    }

    static func findHourlyTempMinMax(_ hourly: Forecast<HourWeather>) -> (min: Double, max: Double) {
        let minElement = hourly.min { valueA, valueB in
            valueA.temperature.value < valueB.temperature.value
        }
        let min = minElement?.temperature.value ?? 200

        let maxElement = hourly.max { valueA, valueB in
            valueA.temperature.value < valueB.temperature.value
        }
        let max = maxElement?.temperature.value ?? 200

        return (min, max)
    }
}
