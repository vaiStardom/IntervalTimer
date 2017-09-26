//
//  ITVFuncs.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-04.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

//MARK: - iPhoneModels and dimensions
func IPHONE() -> Model {
    switch(SCREEN_HEIGHT()) {
    case 568:   //iPhonePortraitInches -> 4 -> Models: 5, 5s, and SE
        return Model.five
        
    case 667:   //iPhonePortraitInches -> 4.7 -> Models: 6, 6s, 7, and 8
        return Model.six
        
    case 736:   //iPhonePortraitInches -> 5.5 -> Models: 6+, 6s+, 7+, and 8+
        return Model.sixPlus
        
    default:    //iPhonePortraitInches -> 4 -> Models: 5, 5s, and SE
        return Model.five
    }
}
func SCREEN_HEIGHT() -> CGFloat {
    return UIScreen.main.bounds.height
}

//MARK: - Messaging Functions
func SHOW_MESSAGE(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    DispatchQueue.main.async() { () -> Void in
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
}

func SHOW_USER_WARNING(type: UserWarning?, with message: String? = nil){
    
    var errorMessage: String?
    
    guard let theUserWarning = type else {
        fatalError("A UserWarning type must be provided.")
    }
    
    if message != nil, !(message?.isEmpty)! {
        errorMessage = message
    } else {
        errorMessage = ""
    }
    
    let alert = ITVUIViewWarningAlert(type: theUserWarning, with: errorMessage)
    alert.show(animated: true)

}

//MARK: - Weather Functions
func GET_WEATHER_FROM_NETWORK(){
    //TODO: call this when user starts a timer
    print("------> TimerViewController viewDidLoad() requesting Location")
    ITVCoreLocation.sharedInstance.requestLocation()
    
    print("------> TimerViewController viewDidLoad() attempting to set weather")
    do {
        try ITVCurrentWeather.getWeatherByPriority()
    } catch let error {
        SHOW_USER_WARNING(type: UserWarning.LocationManagerDidFail, with: "\(error)")
    }
}

//MARK: - Date Functions
func HOURS_SINCE(from: Date?, to: Date?) -> Int? {
    
    guard let theTo = to else {
        fatalError("You must provide a non-nil to date")
    }
    
    if let theStartDate = from {
        if let dateCompoenent = Calendar.current.dateComponents([.hour], from: theStartDate, to: theTo) as DateComponents? {
            if let hoursSince = dateCompoenent.hour {
                return hoursSince
            } else {
                return nil
            }
        } else {
            return nil
        }
    } else {
        return nil
    }
}

//MARK: - Time Functions
func TIME_OF_HMS(seconds: Double) -> String {
    
    let theSeconds = Int(seconds)
    let sec: Int = theSeconds % 60
    let minutes: Int = (theSeconds / 60) % 60
    let hours: Int = theSeconds / 3600
    
    if hours > 0 {
        return "\(String(format: "%02d h %02d m %02d s", hours, minutes, sec))"
    } else if minutes > 0 {
        return "\(String(format: "%02d m %02d s", minutes, sec))"
    } else {
        return "\(String(format: "%02d s", sec))"
    }
}
func TIME_OF_00(seconds: Double) -> String {
    
    let theSeconds = Int(seconds)
    let sec: Int = theSeconds % 60
    let minutes: Int = (theSeconds / 60) % 60
    let hours: Int = theSeconds / 3600
    
    if hours > 0 {
        return "\(String(format: "%02d:%02d:%02d", hours, minutes, sec))h"
    } else if minutes > 0 {
        return "\(String(format: "%02d:%02d", minutes, sec))m"
    } else {
        return "\(String(format: "%02d", sec))s"
    }
}
func HOURS_OF(seconds: Double) -> String {
    let theSeconds = Int(seconds)
    let hours: Int = theSeconds / 3600
    
    if hours > 0 {
        return "\(String(format: "%02d", hours))"
    } else {
        return ""
    }
}
func MINUTES_OF(seconds: Double) -> String {
    let theSeconds = Int(seconds)
    let minutes: Int = (theSeconds / 60) % 60
    
    if minutes > 0 {
        return "\(String(format: "%02d", minutes))"
    } else {
        return ""
    }

}
func SECONDS_OF(seconds: Double) -> String {
    let secs = Int(seconds)
    let theSeconds = secs % 60
    
    if theSeconds > 0 {
        return "\(String(format: "%02d", theSeconds))"
    } else {
        return ""
    }

}
