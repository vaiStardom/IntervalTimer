//
//  EditTimerViewControllerLifeCycle.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-22.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Life-cycle
extension EditTimerViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: view)
        }
        
        configureNavBar()
        configureTableView()
        registerNotifications()
    }
    
    override func viewDidLayoutSubviews() {
        
        guard didEditAnInterval == false else {
            return
        }
        
        guard let theTopCell = topCell() else {
            return
        }
                
        //First, is this a selected timer?
        if let theTimerIndex = itvTimerIndex, ITVUser.sharedInstance.thisTimers?[theTimerIndex] != nil {
            theTopCell.timerNameTextField.text = ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisName

            
            //Find and show the grouped unique intervals for quick additions
            if let theIntervals = ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisIntervals {
                intervals = theIntervals
                uniqueArrays(intervals: theIntervals)
            }
            
            //Second, if this is a selected timer, do we show the weather
            if let theShowWeather = ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisShowWeather {
                theTopCell.showWeatherSwitch.isOn = theShowWeather
                if theShowWeather {
                    if let theTemperatureUnit = ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisTemperatureUnit {
                        theTopCell.temperatureSegmentedControl.selectedSegmentIndex = theTemperatureUnit.rawValue
                    }
                    aesthetics_startLoadingWeather()
                    showWeather()
                } else {
                    aesthetics_dontLoadWeather()
                }
            } else {
                theTopCell.showWeatherSwitch.isOn = false
                aesthetics_dontLoadWeather()
            }
            
            timerName = ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisName
            isShowWeather = theTopCell.showWeatherSwitch.isOn
            temperatureUnit = getTemperatureUnit(from: theTopCell.temperatureSegmentedControl)

        } else {
            if let theUnsavedIntervals = itvUnsavedTimersIntervals {
                intervals = theUnsavedIntervals
            } else {
                intervals = []
            }
        }
        
        isScrollEnabled()
    }
}
