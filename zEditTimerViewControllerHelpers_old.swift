//
//  EditTimerViewControllerHelpers.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-01.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

extension EditTimerViewController_old {
    func didUserModifyATimer(){
        
        let theTimerName = timerNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let theTemperatureUnit = getTemperatureUnit(from: temperatureSegmentedControl)
        let theShowWeather = showWeatherSwitch.isOn

//        print("theTimerName = \(theTimerName)")
        //First, is this a selected timer?
        if let theTimerIndex = itvTimerIndex, ITVUser.sharedInstance.thisTimers?[theTimerIndex] != nil {
            if let theItvTimer = ITVUser.sharedInstance.thisTimers?[theTimerIndex] {
                if theTimerName! != theItvTimer.thisName!
                    || theTemperatureUnit != theItvTimer.thisTemperatureUnit
                    || theShowWeather != theItvTimer.thisShowWeather {
                    isEditing = true
                } else {
                    isEditing = false
                }
            }
        } else {
            if (!theTimerName!.isEmpty){
                isEditing = true
            } else {
                isEditing = false
            }
        }
        configureNavBar()
    }
    
    func getTemperatureUnit(from: UISegmentedControl) -> TemperatureUnit {
        switch from.selectedSegmentIndex {
        case 0 :
            return TemperatureUnit.Kelvin
        case 1 :
            return TemperatureUnit.Fahrenheit
        case 2 :
            return TemperatureUnit.Celcius
        default:
            return TemperatureUnit.Celcius
        }
    }
}
