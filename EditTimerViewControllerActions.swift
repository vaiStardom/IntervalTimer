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
            aesthetics_hideWeatherViews()
            aesthetics_hideShowWeatherDescription()
        }
    }
    @IBAction func addInterval(_ sender: Any) {
        performSegue(withIdentifier: "EditTimerToEditInterval", sender: nil)
    }
    func back(){
        //TODO: if a name was added, save the timer
        //TODO: if no name and no intervals were added, just delete and dont save anything
        _ = navigationController?.popViewController(animated: true)
    }
    func cancel(){
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func weatherMissing(_ sender: Any) {
        if ITVWarningForUser.sharedInstance.thisMessage != nil, !(ITVWarningForUser.sharedInstance.thisMessage?.isEmpty)! {
            showUserWarning(type: ITVWarningForUser.sharedInstance.thisUserWarning, with: ITVWarningForUser.sharedInstance.thisMessage)
        } else {
            showUserWarning(type: ITVWarningForUser.sharedInstance.thisUserWarning)
        }
    }
    @IBAction func selectedTemperatureUnit(_ sender: UISegmentedControl) {
        let temperature = getTemperatureUnit(from: sender).temperature(kelvins: ITVUser.sharedInstance.thisCurrentWeather?.thisKelvin)
        weatherTemperatureLabel.text = temperature
    }
}
