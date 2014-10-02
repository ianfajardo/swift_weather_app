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
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var dayLabel1: UILabel!
    @IBOutlet weak var iconImage1: UIImageView!
    @IBOutlet weak var tempLabel1: UILabel!
    
    @IBOutlet weak var dayLabel2: UILabel!
    @IBOutlet weak var iconImage2: UIImageView!
    @IBOutlet weak var tempLabel2: UILabel!
    
    @IBOutlet weak var dayLabel3: UILabel!
    @IBOutlet weak var iconImage3: UIImageView!
    @IBOutlet weak var tempLabel3: UILabel!
    
    @IBOutlet weak var dayLabel4: UILabel!
    @IBOutlet weak var iconImage4: UIImageView!
    @IBOutlet weak var tempLabel4: UILabel!
    
    @IBOutlet weak var dayLabel5: UILabel!
    @IBOutlet weak var iconImage5: UIImageView!
    @IBOutlet weak var tempLabel5: UILabel!
    
    @IBOutlet weak var dayLabel6: UILabel!
    @IBOutlet weak var iconImage6: UIImageView!
    @IBOutlet weak var tempLabel6: UILabel!
    
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
                //println(currentWeather.temperature)
                //println(forecastWeatherArray[0].temperatureMin)
                //println(currentWeather.currentDate)
                //println(forecastWeatherArray[0].day)
                println(forecastWeatherArray[3].summary)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tempLabel.text = "\(currentWeather.temperature)"
                    self.weatherIcon.image = currentWeather.icon!
                    self.timeLabel.text = "\(currentWeather.currentTime!)"
                    self.dateLabel.text = "\(currentWeather.currentDate!)"
                    self.summaryLabel.text = "\(currentWeather.summary)"
                    
                    self.dayLabel1.text = "\(forecastWeatherArray[1].day!)"
                    self.iconImage1.image = forecastWeatherArray[1].icon!
                    self.tempLabel1.text = "\(forecastWeatherArray[1].tempCatString!)"
                    
                    self.dayLabel2.text = "\(forecastWeatherArray[2].day!)"
                    self.iconImage2.image = forecastWeatherArray[2].icon!
                    self.tempLabel2.text = "\(forecastWeatherArray[2].tempCatString!)"
                    
                    self.dayLabel3.text = "\(forecastWeatherArray[3].day!)"
                    self.iconImage3.image = forecastWeatherArray[3].icon!
                    self.tempLabel3.text = "\(forecastWeatherArray[3].tempCatString!)"
                    
                    self.dayLabel4.text = "\(forecastWeatherArray[4].day!)"
                    self.iconImage4.image = forecastWeatherArray[4].icon!
                    self.tempLabel4.text = "\(forecastWeatherArray[4].tempCatString!)"
                    
                    self.dayLabel5.text = "\(forecastWeatherArray[5].day!)"
                    self.iconImage5.image = forecastWeatherArray[5].icon!
                    self.tempLabel5.text = "\(forecastWeatherArray[5].tempCatString!)"
                    
                    self.dayLabel6.text = "\(forecastWeatherArray[6].day!)"
                    self.iconImage6.image = forecastWeatherArray[6].icon!
                    self.tempLabel6.text = "\(forecastWeatherArray[6].tempCatString!)"
                })
            }
            else{
                
            }
        })
        downloadTask.resume()
        
        
        
        
    }
    

}

