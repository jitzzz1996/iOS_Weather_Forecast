//
//  WeatherEndPoint.swift
//  iOS_Weather_Forecast
//
//  Created by Jitesh Bablani on 18/06/23.
//

import Foundation

enum WeatherEndPoint {
    case weatherByCityName(_:String?) // Module - GET
    case weatherByLatLong(_:String?,_:String?)
}

extension WeatherEndPoint: EndPointType {
    
    var path: String {
        switch self {
        case .weatherByCityName(let cityName):
            return "&q=\(cityName ?? "")"
        case .weatherByLatLong(let latitude, let Longitude):
            return "&lat=\(latitude ?? "")&lon=\(Longitude ?? "")"
        }
    }
    
    var baseURL: String {
        switch self {
        case .weatherByCityName,.weatherByLatLong:
            return Constant.API.weatherInfoURL
        }
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
    
    var method: HTTPMethods {
        switch self {
        case .weatherByCityName,.weatherByLatLong:
            return .get
        }
    }
    
    var body: Encodable? {
        switch self {
        case .weatherByCityName,.weatherByLatLong:
            return nil
        }
    }
    
    var headers: [String : String]? {
        APIManager.commonHeaders
    }
}
