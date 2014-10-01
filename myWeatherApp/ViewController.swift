//
//  ViewController.swift
//  myWeatherApp
//
//  Created by Ariel-Ian Fajardo on 9/26/14.
//  Copyright (c) 2014 Ariel-Ian Fajardo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    private let apiKey =  "b00a6f5a9b222df176bd56f438bac362"
    
    override func viewDidLoad() {
        getDailyWeatherData()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getDailyWeatherData() -> Void{
        
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")
        let forecastURL = NSURL(string: "38.905155,-77.546006", relativeToURL: baseURL)
        
        let sharedSession = NSURLSession.sharedSession()
        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(forecastURL, completionHandler: { (location: NSURL!, repsonse: NSURLResponse!, error: NSError!) -> Void in
            if(error == nil){
                
                let dataObject = NSData(contentsOfURL: location)
                let weatherDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject, options: nil, error: nil) as NSDictionary
                println(weatherDictionary)
                
                let currentWeather = Current(weatherDictionary: weatherDictionary)
                
                let forecastDictionary: NSDictionary = weatherDictionary["daily"] as NSDictionary
                let forecastDataArray: NSMutableArray = forecastDictionary["data"] as NSMutableArray
                //forecastDataArray.removeObjectAtIndex(0)
                
                var forecastWeatherArray: [Forecast] = []
                for item in (forecastDataArray as Array){
                    let forecastObj = Forecast(weatherDictionary: item as NSDictionary)
                    forecastWeatherArray.append(forecastObj)
                }
                println(currentWeather.temperature)
                println(forecastWeatherArray[0].temperatureMin)
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tempLabel.text = "\(currentWeather.temperature)"
                    self.weatherIcon.image = currentWeather.icon!
                    self.timeLabel.text = "\(currentWeather.currentTime!)"
                })
            }
            else{
                
            }
        })
        downloadTask.resume()
        
        
        
        
    }
    

}

