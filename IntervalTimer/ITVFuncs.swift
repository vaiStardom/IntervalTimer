//
//  ITVFuncs.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-04.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Messaging Functions
func showMessage(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    DispatchQueue.main.async() { () -> Void in
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
}

func showUserWarning(type: UserWarning?, with message: String? = nil){
    
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
func getWeatherFromNetwork(){
    //TODO: call this when user starts a timer
    print("------> TimerViewController viewDidLoad() requesting Location")
    ITVCoreLocation.sharedInstance.requestLocation()
    
    print("------> TimerViewController viewDidLoad() attempting to set weather")
    do {
        try ITVCurrentWeather.getWeatherByPriority()
    } catch let error {
        showUserWarning(type: UserWarning.LocationManagerDidFail, with: "\(error)")
    }
}

//MARK: - Date Functions
func hoursSince(from: Date?, to: Date?) -> Int? {
    guard let theFrom = from else {
        fatalError("You must provide a non-nil from date")
    }
    guard let theTo = to else {
        fatalError("You must provide a non-nil to date")
    }
    
    if let dateCompoenent = Calendar.current.dateComponents([.hour], from: theFrom, to: theTo) as DateComponents? {
        if let hoursSince = dateCompoenent.hour {
            return hoursSince
        } else {
            return nil
        }
    } else {
        return nil
    }
}

//MARK: - Time Functions
func realTimeOf(seconds: Double) -> String {
    
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

