//
//  weatherDisplayVC.swift
//  weatherApp
//
//  Created by Aaron Fisher on 11/14/18.
//  Copyright © 2018 Aaron Fisher. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class weatherDisplayVC: UIViewController {

    @IBOutlet weak var todaysLowLabel: UILabel!
    @IBOutlet weak var todaysHighLabel: UILabel!
    @IBOutlet weak var todaysTemperature: UILabel!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var displayWeatherData: WeatherData! {
        didSet {
            emojiLabel.text = displayWeatherData.condition.icon
            todaysTemperature.text = "\(displayWeatherData.temperature)º"
            todaysHighLabel.text = "\(displayWeatherData.highTemperature)º"
            todaysLowLabel.text = "\(displayWeatherData.lowTemperature)º"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the values for longitude and latitude
        let latitude = 37.8267
        let longitude = -122.4233
        
        // Calls the get weather function
        APIManager.getWeather(at: (latitude, longitude)) { weatherData, error in
            if let receivedData = weatherData {
                self.displayWeatherData = receivedData
            }

            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    var displayGeocodingData: GeocodingData! {
        didSet{
            locationLabel.text = displayGeocodingData.formattedAddress
        }
    }
    
    @IBAction func unwindToWeatherDisplay(segue: UIStoryboardSegue) {}
}



