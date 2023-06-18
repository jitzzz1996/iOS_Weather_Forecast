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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func searchButtonAction(_ sender: UIButton) {
        print(searchTextField.text)
    }
    

}

