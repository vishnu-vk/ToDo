//
//  ForecastModel.swift
//  ToDo
//
//  Created by Vishnu on 09/07/24.
//

import Foundation

struct ForecastModel: Codable {
    let latitude, longitude, generationtimeMS: Double
    let utcOffsetSeconds: Int
    let timezone, timezoneAbbreviation: String
    let elevation: Int
    let currentUnits: CurrentUnits
    let current: Current

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case currentUnits = "current_units"
        case current
    }
}

struct Current: Codable {
    let time: String
    let interval: Int
    let temperature2M: Double
    let weatherCode: Int

    enum CodingKeys: String, CodingKey {
        case time, interval
        case temperature2M = "temperature_2m"
        case weatherCode = "weather_code"
    }
}

struct CurrentUnits: Codable {
    let time, interval, temperature2M, weatherCode: String

    enum CodingKeys: String, CodingKey {
        case time, interval
        case temperature2M = "temperature_2m"
        case weatherCode = "weather_code"
    }
}
