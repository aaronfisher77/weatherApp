//
//  APIManager.swift
//  weatherApp
//
//  Created by Aaron Fisher on 11/14/18.
//  Copyright © 2018 Aaron Fisher. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

struct APIManager {
    
    enum APIErrors: Error {
        case noData
        case noResponse
        case invalidData
    }
    
     private let googleURL = "https://maps.googleapis.com/maps/api/geocode/json?address-"
    
    // call darksky for weather at location (latitude, longitude)
    static func getWeather(at location: Location, onComplete: @escaping (WeatherData?, Error?) -> Void) {
        let root = "https://api.darksky.net/forecast"
        let key = APIKey.darkSkySecret
        
        let url = "\(root)/\(key)/\(location.latitude),\(location.longitude)"
        
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let weatherData = WeatherData(json: json) {
                    onComplete(weatherData, nil)
                } else {
                    onComplete(nil, APIErrors.invalidData)
                }
            case .failure(let error):
                onComplete(nil, error)
            }
        }
    }
    
    static func getCoordinates(for address: String, onComplete: @escaping (GeocodingData?, Error?) -> Void) {
        let googleURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
        let baseURL = googleURL + address + "&key=" + APIKey.googleKey
        
        let request = Alamofire.request(baseURL)
        
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let geocodingData = GeocodingData(json: json){
                    onComplete(geocodingData, nil)}
                else {
                    onComplete(nil, APIErrors.invalidData)
                }
                print(json)
            case .failure(let error):
                print(error.localizedDescription)
                onComplete(nil, error)
                
            }
        }
    }
    
}
