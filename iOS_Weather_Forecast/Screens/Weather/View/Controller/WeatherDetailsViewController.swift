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
    
    private func baseSetup() {
        self.searchTextField.delegate = self
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
                print(error)
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
            viewModel.fetchWeatherDetails(cityName: city)
        }
        searchTextField.text = ""
    }
}

