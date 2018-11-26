//
//  WeatherData.swift
//  weatherApp
//
//  Created by Aaron Fisher on 11/16/18.
//  Copyright © 2018 Aaron Fisher. All rights reserved.
//

import Foundation
import SwiftyJSON

class WeatherData {
    
    // Weather App COnditiontions
    enum Conditions: String {
        case clearDay = "clear-day"
        case clearNight = "clear-night"
        case rain = "rain"
        case snow = "snow"
        case sleet = "sleet"
        case wind = "wind"
        case fog = "fog"
        case cloudy = "cloudy"
        case partlyCloudyDay = "partly-cloudy-day"
        case partlyCloudyNight = "partly-cloudy-night"
        
        // Icons for each conditions
        var icon: String {
            switch self {
            case .clearDay:
                return "☀️"
            case .clearNight:
                return "🌕"
            case .rain:
                return "🌧"
            case .snow:
                return "🌨"
            case .sleet:
                return "☔︎"
            case .wind:
                return "🌪"
            case .fog:
                return ""
            case .cloudy:
                return ""
            case .partlyCloudyDay:
                return ""
            case .partlyCloudyNight:
                return ""
            }
        }
    }
    
    // allows for easy key usage
    enum WeatherDataKeys: String {
        case currently = "currently"
        case temperature = "temperature"
        case icon = "icon"
        case daily = "daily"
        case data = "data"
        case temperatureHigh = "temperatureHigh"
        case temperatureLow = "temperatureLow"
    }
    
    // neccissary variables
    let temperature: Double
    let highTemperature: Double
    let lowTemperature: Double
    let condition: Conditions
    
    //Designated initializer
    init(temperature: Double, highTemperature: Double, lowTemperature: Double, condition: Conditions) {
        self.temperature = temperature
        self.highTemperature = highTemperature
        self.lowTemperature = lowTemperature
        self.condition = condition
    }
    
    convenience init?(json: JSON) {
        guard let temperature = json[WeatherDataKeys.currently.rawValue][WeatherDataKeys.temperature.rawValue].double else { // creates a temperature variable if the tempeture can be received from the JSON
            print("Couldn't get temperature") // Error Message
            return nil
        }
        
        guard let highTemperature = json[WeatherDataKeys.daily.rawValue][WeatherDataKeys.data.rawValue][0][WeatherDataKeys.temperatureHigh.rawValue].double else {// creates a temperature variable if the tempeture can be received from the JSON
            print("Couldn't get high temp") // Error Message
            return nil
        }
        
        guard let lowTemperature = json[WeatherDataKeys.daily.rawValue][WeatherDataKeys.data.rawValue][0][WeatherDataKeys.temperatureLow.rawValue].double else {// creates a low temperature variable if the temperature can be received from the JSON
            print("Couldn't get low temp") // Error Message
            return nil
        }
        
        guard let conditionString = json[WeatherDataKeys.currently.rawValue][WeatherDataKeys.icon.rawValue].string else {// creates a condition string variable if the condition string can be received from the JSON
            print("Couldn't get condition") // Error Message
            return nil
        }
        
        print(conditionString)
        
        guard let condition = Conditions(rawValue: conditionString) else {// creates a condition variable if the condition can be received from the JSON
            print("Couldn't init condition") // Error Message
            return nil
        }
        
        self.init(temperature: temperature, highTemperature: highTemperature, lowTemperature: lowTemperature, condition: condition) // Initializer 
    }
}
