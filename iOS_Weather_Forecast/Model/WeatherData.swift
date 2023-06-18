//
//  WeatherData.swift
//  iOS_Weather_Forecast
//
//  Created by Jitesh Bablani on 18/06/23.
//

import Foundation
struct WeatherData: Decodable {
       let coord: CoordinationData
       let weather: [WeatherMainData]
       let base: String
       let main: MainData
       let visibility: Int
       let wind: WindData
       let clouds: CloudsData
       let dt: Int
       let sys: SysData
       let timezone, id: Int
       let name: String
       let cod: Int
}
// MARK: - Clouds
struct CloudsData: Codable {
    let all: Int
}

// MARK: - Coord
struct CoordinationData: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct MainData: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct SysData: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct WeatherMainData: Codable {
    let id: Int
    let main, description, icon: String
}

// MARK: - Wind
struct WindData: Codable {
    let speed: Double
    let deg: Int
}
