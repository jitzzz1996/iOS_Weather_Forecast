//
//  WeatherManager.swift
//  iOS_Weather_Forecast
//
//  Created by Jitesh Bablani on 17/06/23.
//

import Foundation
struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=746982769924693708974ccda9277973&units=metric"
    
    func fetchWeather(city: String) {
        let url = "\(weatherURL)&q=\(city)"
        performRequest(urlString: url)
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error)
                }
                
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            task.resume()
        }
        
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodeData.weather[0].id
            let temeprature = decodeData.main.temp
            let name = decodeData.name
            let weather = WeatherModel(conditionId: id, cityName: name, temeperature: temeprature)
            print(weather.cityName)
        } catch {
               print(error)
            }
    }

}
