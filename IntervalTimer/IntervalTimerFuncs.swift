//
//  IntervalTimerFuncs.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-04.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Messaging Function
func showMessage(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    DispatchQueue.main.async() { () -> Void in
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
}

func getWeatherFromNetwork(){
    //TODO: call this when user starts a timer
    //IntervalTimerUser.sharedInstance.startUpdatingLocationManager()
    print("------> TimerViewController viewDidLoad() requesting Location")
    ITVCoreLocation.sharedInstance.requestLocation()
    
    print("------> TimerViewController viewDidLoad() attempting to set weather")
    IntervalTimerCurrentWeather.getWeatherByPriority()
}
