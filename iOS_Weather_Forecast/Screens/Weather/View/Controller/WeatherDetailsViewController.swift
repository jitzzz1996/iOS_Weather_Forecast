//
//  WeatherDetailsViewController.swift
//  iOS_Weather_Forecast
//
//  Created by Jitesh Bablani on 14/06/23.
//

import UIKit
import CoreLocation

class WeatherDetailsViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    private let viewModel = WeatherDetailsViewModel()
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseSetup()
        self.configuration()
        // Do any additional setup after loading the view.
    }

    @IBAction func locationButtonAction(_ sender: UIButton) {
        locationManager.requestLocation()
    }

    private func baseSetup() {
        self.searchTextField.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    @IBAction func searchButtonAction(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func setupUI() {
        let data = viewModel.weatherModel
        self.temperatureLabel.text = data?.temperatureString
        self.cityLabel.text = data?.cityName
        self.conditionImageView.image = UIImage(systemName: data?.conditionName ?? "cloud")
    }
    func setupErrorView() {
        self.temperatureLabel.text = "N/A"
        self.cityLabel.text = "N/A"
        self.conditionImageView.image = UIImage(systemName: "cloud")
        
    }
    

}
extension WeatherDetailsViewController {
    func configuration() {
        observeEvent()
    }
    
    
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }

            switch event {
            case .loading:
                print("Product loading....")
            case .stopLoading:
                print("Stop loading...")
            case .dataLoaded:
                print("Data loaded...")
                DispatchQueue.main.async { [weak self] in
                    self?.setupUI()
                }
            case .error(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.setupErrorView()
                }
            }
        }
    }
    
}

// MARK: - UITextFieldDelegate
extension WeatherDetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Please type something"
            return false 
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = textField.text {
            viewModel.fetchWeatherDetails(cityname: city)
        }
        searchTextField.text = ""
    }
}

extension WeatherDetailsViewController:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = String(location.coordinate.latitude)
            let long = String(location.coordinate.longitude)
            viewModel.fetchWeatherDetails(latitude: lat, longitude: long)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("got error")
    }
}
