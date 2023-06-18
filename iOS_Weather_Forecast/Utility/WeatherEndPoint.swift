//
//  WeatherEndPoint.swift
//  iOS_Weather_Forecast
//
//  Created by Jitesh Bablani on 18/06/23.
//

import Foundation

enum WeatherEndPoint {
    case weatherDetails(_:String?) // Module - GET
}

extension WeatherEndPoint: EndPointType {
    
    var path: String {
        switch self {
        case .weatherDetails(let cityName):
            return "&q=\(cityName ?? "")"
        }
    }
    
    var baseURL: String {
        switch self {
        case .weatherDetails:
            return Constant.API.weatherInfoURL
        }
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
    
    var method: HTTPMethods {
        switch self {
        case .weatherDetails:
            return .get
        }
    }
    
    var body: Encodable? {
        switch self {
        case .weatherDetails:
            return nil
        }
    }
    
    var headers: [String : String]? {
        APIManager.commonHeaders
    }
}
