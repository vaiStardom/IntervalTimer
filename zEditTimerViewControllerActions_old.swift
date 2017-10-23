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
extension EditTimerViewController_old {
    @IBAction func showWeather(_ sender: Any) {
        if showWeatherSwitch.isOn {
            registerNotifications() //will register at first weather use
            aesthetics_startLoadingWeather()
            showWeather()
        } else {
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
    @IBAction func weatherMissing(_ sender: Any) {
        if ITVCoreLocation.sharedInstance.isLocationServicesAndNetworkAvailable() {
            aesthetics_hideWarning()
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
                SHOW_USER_WARNING(type: ITVWarningForUser.sharedInstance.thisUserWarning, with: ITVWarningForUser.sharedInstance.thisMessage)
            } else {
                SHOW_USER_WARNING(type: ITVWarningForUser.sharedInstance.thisUserWarning)
            }
        }
    }
    @IBAction func selectedTemperatureUnit(_ sender: UISegmentedControl) {
        let temperature = getTemperatureUnit(from: sender).temperature(kelvins: ITVUser.sharedInstance.thisCurrentWeather?.thisKelvin)
        weatherTemperatureLabel.text = temperature
        didUserModifyATimer()
    }
    @objc func back(){
        print("------> EditTimerViewController back()")
//        _ = navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    @objc func cancel(){
//        _ = navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    @objc func save(){
        print("------> EditTimerViewController save()")
        
        if let theTimerName = timerNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !theTimerName.isEmpty  {
            let theTemperatureUnit = getTemperatureUnit(from: temperatureSegmentedControl)
            let theShowWeather = showWeatherSwitch.isOn

            if let theTimerIndex = itvTimerIndex, ITVUser.sharedInstance.thisTimers?[theTimerIndex] != nil {
                //this was a selected timer
                let thisTimersIntervals = ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisIntervals
                let theNewTimer = ITVTimer(name: theTimerName, showWeather: theShowWeather, temperatureUnit: theTemperatureUnit, intervals: thisTimersIntervals)
                ITVUser.sharedInstance.thisTimers?[theTimerIndex] = theNewTimer
                
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
            
            if self.updateTimersProtocolDelegate != nil {
                self.updateTimersProtocolDelegate?.didUpdateTimers()
            }
            
//            _ = navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
            
        } else {
            ITVWarningForUser.sharedInstance.thisUserWarning = UserWarning.MissingTimerName
            SHOW_USER_WARNING(type: ITVWarningForUser.sharedInstance.thisUserWarning)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itvIntervalIndex = indexPath.row
        performSegue(withIdentifier: "EditTimerToEditInterval", sender: nil)
    }
}
