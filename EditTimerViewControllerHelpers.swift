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

extension EditTimerViewController {
    func didUserModifyATimer(){
        if let theItvTimer = itvTimer  {
            let theTimerName = timerNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let theTemperatureUnit = getTemperatureUnit(from: temperatureSegmentedControl)
            let theShowWeather = showWeatherSwitch.isOn
            
            if theTimerName! != theItvTimer.thisName!
                || theTemperatureUnit != theItvTimer.thisTemperatureUnit
                || theShowWeather != theItvTimer.thisShowWeather! {
                isEditing = true
            } else {
                isEditing = false
            }
        } else {
            isEditing = false
        }
        configureNavBar()
    }
    
    func getTemperatureUnit(from: UISegmentedControl) -> TemperatureUnit? {
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
