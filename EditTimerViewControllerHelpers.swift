//
//  EditTimerViewControllerHelpers.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-23.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

extension EditTimerViewController {
    func didUserModifyATimer(){
        
        let theTimerName = topCell().timerNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let theTemperatureUnit = getTemperatureUnit(from: topCell().temperatureSegmentedControl)
        let theShowWeather = topCell().showWeatherSwitch.isOn

//        let theTimerName = timerNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
//        let theTemperatureUnit = getTemperatureUnit(from: temperatureSegmentedControl)
//        let theShowWeather = showWeatherSwitch.isOn
        print("------> EditTimerViewController didUserModifyATimer() theTimerName = \(theTimerName)")
        
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
    func uniqueArrays(intervals: [ITVInterval]) {
        for interval in intervals {
            
            let hasThisIntervalBeenFiltered = uniqueTimers.filter({ $0.0.thisSeconds == interval.thisSeconds && $0.0.thisIndicator == interval.thisIndicator })
            
            if hasThisIntervalBeenFiltered.count == 0 {
                let theFilteredArray = intervals.filter({ $0.thisSeconds == interval.thisSeconds && $0.thisIndicator == interval.thisIndicator })
                if theFilteredArray.count > 0 {
                    uniqueTimers.append((interval, theFilteredArray.count))
                    print("Added interval seconds \(interval.thisSeconds) type \(interval.thisIndicator) appearing \(theFilteredArray.count) times")
                }
            }
        }
        if uniqueTimers.count > 0 {
            uniqueTimers = uniqueTimers.sorted(by: {$0.1 < $1.1})
        }
    }

}
