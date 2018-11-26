//
//  GeocodingData.swift
//  weatherApp
//
//  Created by Aaron Fisher on 11/19/18.
//  Copyright © 2018 Aaron Fisher. All rights reserved.
//

import Foundation
import SwiftyJSON

class GeocodingData { // Creates a Class for the geocoding data
    enum GeocodingDataKeys: String{
        case results = "results"
        case formattedAddress = "formatted_address"
        case geometry = "geometry"
        case location = "location"
        case latitude = "lat"
        case longitude = "lng"
    }
    // Creates vaiables that will take in information receic=ved from the JSON
    var formattedAddress: String
    var latitude: Double
    var longitude: Double
    
    // formates the API address
    init(formattedAddress: String, latitude: Double, longitude: Double) {
        self.formattedAddress = formattedAddress
        self.latitude = latitude
        self.longitude = longitude
    }
    
    convenience init?(json: JSON) {
        guard let results = json[GeocodingDataKeys.results.rawValue].array,
            results.count > 0 else {
                return nil
        }
        // sets the formatted address to JSON
        guard let formattedAddress = results[0][GeocodingDataKeys.formattedAddress.rawValue].string else {
                return nil
        }
        // sets the latitude to JSON
        guard let latitude = results[0][GeocodingDataKeys.geometry.rawValue][GeocodingDataKeys.location.rawValue][GeocodingDataKeys.latitude.rawValue].double
            else {
            return nil
        }
        // sets the longitude to JSON
        guard let longitude = results[0][GeocodingDataKeys.geometry.rawValue][GeocodingDataKeys.location.rawValue][GeocodingDataKeys.longitude.rawValue].double else {
            return nil
        }
        
        // Initializer
        self.init(formattedAddress: formattedAddress, latitude: latitude, longitude: longitude)
        
    }
}
