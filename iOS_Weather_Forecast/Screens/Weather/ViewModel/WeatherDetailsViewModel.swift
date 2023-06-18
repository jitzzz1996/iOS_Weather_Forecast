//
//  WeatherDetailsViewModel.swift
//  iOS_Weather_Forecast
//
//  Created by Jitesh Bablani on 18/06/23.
//

import Foundation

final class WeatherDetailsViewModel {
    
    var weatherModel: WeatherModel?
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure
    
    func fetchWeatherDetails(cityName:String?) {
        self.eventHandler?(.loading)
        APIManager.shared.request(
            modelType: WeatherData.self,
            type: WeatherEndPoint.weatherDetails(cityName)) { response in
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let weatherData):
                    self.setupWeatherModel(data: weatherData)
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }
    
    private func setupWeatherModel(data: WeatherData?) {
        let id = data?.weather[0].id
        let temeprature = data?.main.temp
        let name = data?.name
        let weather = WeatherModel(conditionId: id, cityName: name, temeperature: temeprature)
        self.weatherModel = weather
    }
}
extension WeatherDetailsViewModel {
    
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
    
}
