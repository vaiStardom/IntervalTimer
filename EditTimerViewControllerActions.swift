//
//  EditTimerViewControllerActions.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-01.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Actions
extension EditTimerViewController {
    @IBAction func showWeather(_ sender: Any) {
        if showWeatherSwitch.isOn {
            aesthetics_startLoadingWeather()
            showWeather()
        } else {
            //TODO: if switched OFF and weather has not finished loading, then cancel weather loading (cancel network calls)
            activityIndicatorStop()
            aesthetics_hideWeatherViews()
            aesthetics_showWeatherDescription()
        }
        didUserModifyATimer()
    }
    
    @IBAction func addInterval(_ sender: Any) {
        itvIntervalIndex = nil
        performSegue(withIdentifier: "EditTimerToEditInterval", sender: nil)
    }
    func back(){
        print("------> EditTimerViewController back()")
        
        //TODO: if a name was added, save the timer
        //TODO: if no name and no intervals were added, just delete and dont save anything
        _ = navigationController?.popViewController(animated: true)
    }
    func cancel(){
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func weatherMissing(_ sender: Any) {
        if ITVCoreLocation.sharedInstance.isLocationServicesAndNetworkAvailable() {
            self.registerNotifications() //will register at first weather use
            //IntervalTimerCoreLocation.sharedInstance.firstTimeLocationUsage()
            if ITVUser.sharedInstance.thisShouldUpdateWeather {
                setWeatherFromNetwork()
            } else {
                if ITVUser.sharedInstance.thisCurrentWeather != nil {
                    updateWeatherInformation()
                } else {
                    setWeatherFromNetwork()
                }
            }
        } else {
            aesthetics_showMissingWeatherWarning()
            if ITVWarningForUser.sharedInstance.thisMessage != nil, !(ITVWarningForUser.sharedInstance.thisMessage?.isEmpty)! {
                showUserWarning(type: ITVWarningForUser.sharedInstance.thisUserWarning, with: ITVWarningForUser.sharedInstance.thisMessage)
            } else {
                showUserWarning(type: ITVWarningForUser.sharedInstance.thisUserWarning)
            }
        }
    }
    @IBAction func selectedTemperatureUnit(_ sender: UISegmentedControl) {
        let temperature = getTemperatureUnit(from: sender).temperature(kelvins: ITVUser.sharedInstance.thisCurrentWeather?.thisKelvin)
        weatherTemperatureLabel.text = temperature
        didUserModifyATimer()
    }
    func save(){
        print("------> EditTimerViewController save()")
        
        if let theTimerName = timerNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !theTimerName.isEmpty  {
            let theTemperatureUnit = getTemperatureUnit(from: temperatureSegmentedControl)
            let theShowWeather = showWeatherSwitch.isOn
            
            if let theTimerIndex = itvTimerIndex, ITVUser.sharedInstance.thisTimers?[theTimerIndex] != nil {
                    //this was a selected timer
                    ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisName = theTimerName
                    ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisShowWeather = theShowWeather
                    ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisTemperatureUnit = theTemperatureUnit
            } else {
                //this is a new timer
                if let theNewTimersIntervals = itvUnsavedTimersIntervals {
                    let theNewTimer = ITVTimer(name: theTimerName, showWeather: theShowWeather, temperatureUnit: theTemperatureUnit, intervals: theNewTimersIntervals)
                    ITVUser.sharedInstance.thisTimers?.append(theNewTimer)
                } else {
                    let theNewTimer = ITVTimer(name: theTimerName, showWeather: theShowWeather, temperatureUnit: theTemperatureUnit, intervals: nil)
                    ITVUser.sharedInstance.thisTimers?.append(theNewTimer)
                }
            }
            
            if self.itvTimersProtocolDelegate != nil {
                self.itvTimersProtocolDelegate?.didUpdateTimers()
            }
            
            _ = navigationController?.popViewController(animated: true)

        } else {
            //TODO: Alert user that he must name the timer.
            ITVWarningForUser.sharedInstance.thisUserWarning = UserWarning.MissingTimerName
            showUserWarning(type: ITVWarningForUser.sharedInstance.thisUserWarning)
        }
    }
}
