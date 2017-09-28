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
        } else {
            if let theUnsavedIntervals = itvUnsavedTimersIntervals {
                intervals = theUnsavedIntervals
            } else {
                intervals = []
            }
        }
//        aesthetics_manageBottomSectionOfView()
    }
    override func viewDidAppear(_ animated: Bool) {
        aesthetics_manageBottomSectionOfView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
