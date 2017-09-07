//
//  IntervalTimerFuncs.swift
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

func getWeatherFromNetwork(){
    //TODO: call this when user starts a timer
    //IntervalTimerUser.sharedInstance.startUpdatingLocationManager()
    print("------> TimerViewController viewDidLoad() requesting Location")
    ITVCoreLocation.sharedInstance.requestLocation()
    
    print("------> TimerViewController viewDidLoad() attempting to set weather")
    do {
        try ITVCurrentWeather.getWeatherByPriority()
    } catch let error {
        showUserWarning(type: UserWarning.LocationManagerDidFail, with: "\(error)")
    }

}
