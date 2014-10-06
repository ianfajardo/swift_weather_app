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
    var tempCatString: String?
    var humidity: Int?
    var precipProbability: Int?
    var summary: String
    var icon: UIImage?
    var day: String?
    
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
    
        let currentTimeIntValue = weatherDictionary["time"] as Int
        
        day = dayStringFromUnixTime(currentTimeIntValue)
        
        tempCatString = "\(temperatureMin)/\(temperatureMax)"
    }
    
    func dateStringFromUnixTime(unixTime: Int) -> String {
        let timeInSeconds = NSTimeInterval(unixTime)
        let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter.stringFromDate(weatherDate)
    }
    
    func dayStringFromUnixTime(unixTime: Int) -> String{
        let timeInSeconds = NSTimeInterval(unixTime)
        let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .FullStyle
        var dateString: NSString = dateFormatter.stringFromDate(weatherDate)

        if dateString.rangeOfString("Monday").location != NSNotFound{
            return "Monday"
        }
        else if dateString.rangeOfString("Tuesday").location != NSNotFound {
            return "Tuesday"
        }
        else if dateString.rangeOfString("Wednesday").location != NSNotFound {
            return "Wednesday"
        }
        else if dateString.rangeOfString("Thursday").location != NSNotFound {
            return "Thursday"
        }
        else if dateString.rangeOfString("Friday").location != NSNotFound {
            return "Friday"
        }
        else if dateString.rangeOfString("Saturday").location != NSNotFound{
            return "Saturday"
        }
        else if dateString.rangeOfString("Sunday").location != NSNotFound {
            return "Sunday"
        }
        else{
            return "";
        }
        
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
            imageName = "cloudy-day"
        case "partly-cloudy-night":
            imageName = "cloudy-night"
        default:
            imageName = "clear-day"
        }
        
        var iconImage = UIImage(named: imageName)
        return iconImage
    }
    
}