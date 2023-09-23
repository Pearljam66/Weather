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
}
