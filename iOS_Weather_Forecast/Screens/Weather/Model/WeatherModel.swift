//
//  WeatherModel.swift
//  iOS_Weather_Forecast
//
//  Created by Jitesh Bablani on 18/06/23.
//

import Foundation
struct WeatherModel {
    let conditionId: Int?
    let cityName: String?
    let temeperature: Double?
    
    var temperatureString : String {
        return String(format: "%.1f", temeperature ?? "")
    }
    
    var conditionName: String {
        switch conditionId ?? 0 {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }

}
