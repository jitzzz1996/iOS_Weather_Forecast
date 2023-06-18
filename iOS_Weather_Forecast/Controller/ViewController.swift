//
//  ViewController.swift
//  iOS_Weather_Forecast
//
//  Created by Jitesh Bablani on 14/06/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    let weatherManager = WeatherManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseSetup()
        // Do any additional setup after loading the view.
    }
    
    private func baseSetup() {
        self.searchTextField.delegate = self
    }

    @IBAction func searchButtonAction(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    

}
extension ViewController: UITextFieldDelegate {
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
            weatherManager.fetchWeather(city: city)
        }
        searchTextField.text = ""
    }
}

