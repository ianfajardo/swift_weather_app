//
//  Forecast.swift
//  myWeatherApp
//
//  Created by Ariel-Ian Fajardo on 9/26/14.
//  Copyright (c) 2014 Ariel-Ian Fajardo. All rights reserved.
//

import Foundation
import UIKit

struct Forecast{
    var temperatureMax: Int
    var temperatureMin: Int
    var humidity: Int?
    var precipProbability: Int?
    var summary: String
    var icon: UIImage?
    
    init(weatherDictionary: NSDictionary){

        temperatureMax = weatherDictionary["temperatureMax"] as Int
        temperatureMin = weatherDictionary["temperatureMin"] as Int
        summary = weatherDictionary["summary"] as String
        
        let iconString = weatherDictionary["icon"] as String
        icon = weatherIconFromString(iconString)
        
        let humidityPercentage = weatherDictionary["humidity"] as Double
        humidity = Int(humidityPercentage * 100)
        
        let precip = weatherDictionary["precipProbability"] as Double
        precipProbability = Int(precip * 100)
        
        
    }
    
    func dateStringFromUnixTime(unixTime: Int) -> String {
        let timeInSeconds = NSTimeInterval(unixTime)
        let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter.stringFromDate(weatherDate)
    }
    
    func weatherIconFromString(stringIcon: String) -> UIImage{
        var imageName: String
        switch stringIcon {
        case "clear-day":
            imageName = "clear-day"
        case "clear-night":
            imageName = "clear-night"
        case "rain":
            imageName = "rain"
        case "snow":
            imageName = "snow"
        case "sleet":
            imageName = "sleet"
        case "wind":
            imageName = "wind"
        case "fog":
            imageName = "fog"
        case "cloudy":
            imageName = "cloudy"
        case "partly-cloudy-day":
            imageName = "partly-cloudy"
        case "partly-cloudy-night":
            imageName = "cloudy-night"
        default:
            imageName = "default"
        }
        
        var iconImage = UIImage(named: imageName)
        return iconImage
    }
    
}