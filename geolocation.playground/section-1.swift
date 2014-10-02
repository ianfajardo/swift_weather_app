// Playground - noun: a place where people can play

import UIKit
import Foundation
import CoreLocation




CLGeocoder().geocodeAddressString("20105", completionHandler: { (placemarks, error) -> Void in
    if (error != nil) {println("reverse geodcode fail: \(error.localizedDescription)")}
    if placemarks.count > 0 {
        let pm = placemarks[0] as CLPlacemark
        println(pm)
    }
    
})



