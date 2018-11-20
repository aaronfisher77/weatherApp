//
//  locationSearch.swift
//  weatherApp
//
//  Created by Aaron Fisher on 11/15/18.
//  Copyright © 2018 Aaron Fisher. All rights reserved.
//

import UIKit

class locationSearch: UIViewController, UISearchBarDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    
    let apiManager = APIManager() // creates a variable that = APIManager
    
    // creating variables
    var geocodingData: GeocodingData?
    var weatherData: WeatherData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        // Do any additional setup after loading the view.
        
        
    }
    
    func handleError() {
        geocodingData = nil
        weatherData = nil
    }
    
    func retrieveGeocodingData(searchAddress: String) {
        APIManager.getCoordinates(for: searchAddress) {
            (geocodingData, error) in
            if let recievedError = error {// If error appears then we will reset everythin with the handle error func
                print(recievedError.localizedDescription)
                self.handleError()
                return
            }
            
            if let recievedData = geocodingData {
                self.geocodingData = recievedData
                self.retrieveWeatherData(latitude: recievedData.latitude, longitude: recievedData.longitude)
            } else {
                self.handleError()
                return
            }
        }
    }
    
    
    func retrieveWeatherData(latitude: Double, longitude: Double) {
        APIManager.getWeather(at: (latitude, longitude)) { (weatherData,error) in
            if let recievedError = error {
                print(recievedError.localizedDescription)
                self.handleError()
                return
            }
            if let recievedData = weatherData {
                self.weatherData = recievedData
                print("7777777777777")
                self.performSegue(withIdentifier: "unwindToWeatherDisplay", sender: self)
            }else {
                self.handleError()
                return
            }
            
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchAddress = searchBar.text?.replacingOccurrences(of: " ", with: "+") else {
            return
        }
        retrieveGeocodingData(searchAddress: searchAddress)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? weatherDisplayVC,
            let recievedGeocodingData = geocodingData,
            let retrievedWeatherData = weatherData {
            destinationVC.displayWeatherData = retrievedWeatherData
            destinationVC.displayGeocodingData = recievedGeocodingData
        }
    }
    
}
