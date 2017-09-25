//
//  EditTimerViewControllerAesthetics.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-23.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

//
//  EditTimerViewControllerAesthetics.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-01.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

extension EditTimerViewController {

//    func aesthetics_initial(){
//        topCell().weatherActivityIndicator.color = ITVColors.Orange
//        topCell().weatherActivityIndicator.isHidden = true
//        topCell().showWeatherSwitch.isOn = false
//        topCell().timerNameTextField.tintColor = ITVColors.Orange
//        topCell().temperatureSegmentedControl.isHidden = true
//        topCell().temperatureSegmentedControl.selectedSegmentIndex = 2
//        topCell().showWeatherDescriptionLabel.isHidden = false
//        topCell().warningButton.isEnabled = false
//        
//        aesthetics_ShowTableView()
//    }
    func aesthetics_timerNamePlaceHolder(){
        topCell().timerNameTextField.attributedPlaceholder = NSAttributedString(string: Litterals.TimerNamePlaceholder, attributes: [NSAttributedStringKey.foregroundColor : ITVColors.OrangeAlpha50])
    }
    func aesthetics_ShowTableView(){
//        if let theTimerIndex = itvTimerIndex {
//            if let theTimersIntervals = ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisIntervals {
//                if theTimersIntervals.count > 0 {
//                    tableView.isHidden = false
//                    addIntervalsToTimerLabel.isHidden = true
//                } else {
//                    tableView.isHidden = true
//                    addIntervalsToTimerLabel.isHidden = false
//                }
//            }
//        } else {
//            if itvUnsavedTimersIntervals != nil {
//                tableView.isHidden = false
//                addIntervalsToTimerLabel.isHidden = true
//            } else {
//                tableView.isHidden = true
//                addIntervalsToTimerLabel.isHidden = false
//            }
//        }
    }
    
    func aesthetics_hideWarning(){
        topCell().warningImageView.isHidden = true
        topCell().warningButton.isEnabled = false
    }

    func aesthetics_dontLoadWeather(){
        topCell().showWeatherSwitch.isOn = false
        topCell().weatherIconImageView.isHidden = true
        topCell().weatherTemperatureLabel.isHidden = true
        topCell().temperatureSegmentedControl.isHidden = true
        topCell().showWeatherDescriptionLabel.isHidden = false
    }
    func aesthetics_showWeatherDescription(){
        topCell().showWeatherDescriptionLabel.alpha = 1.0
        topCell().showWeatherDescriptionLabel.isHidden = false
    }
    func aesthetics_startLoadingWeather() {
        activityIndicatorStart()
        aesthetics_hideWarning()

        topCell().temperatureSegmentedControl.isHidden = false
        topCell().weatherIconImageView.isHidden = false
        
        topCell().showWeatherSwitch.isOn = true
        topCell().weatherTemperatureLabel.isHidden = true
        topCell().showWeatherDescriptionLabel.isHidden = true

    }
    func aesthetics_showMissingWeatherWarning(){
        //TODO: program the alert to show when this button is pressed
        activityIndicatorStop()
        aesthetics_hideWeatherViews()

        topCell().warningButton.isEnabled = true
        topCell().warningImageView.alpha = 0.0

        topCell().warningButton.isHidden = false
        topCell().warningImageView.isHidden = false

        topCell().warningImageView.alpha = 1.0
    }
    func aesthetics_hideMissingWeatherWarning(){
        aesthetics_showWeatherViews()
    }
    func aesthetics_hideWeatherViews(){
        
        topCell().weatherIconImageView.isHidden = true
        topCell().weatherTemperatureLabel.isHidden = true
        topCell().temperatureSegmentedControl.isHidden = true

        topCell().weatherIconImageView.image = nil
        topCell().weatherTemperatureLabel.text = nil
    }
    func aesthetics_showWeatherViews(){
        topCell().weatherIconImageView.alpha = 0.0
        topCell().weatherTemperatureLabel.alpha = 0.0
        topCell().temperatureSegmentedControl.alpha = 0.0

        topCell().weatherIconImageView.isHidden = false
        topCell().weatherTemperatureLabel.isHidden = false
        topCell().temperatureSegmentedControl.isHidden = false

        topCell().weatherIconImageView.alpha = 1.0
        topCell().weatherTemperatureLabel.alpha = 1.0
        topCell().temperatureSegmentedControl.alpha = 1.0
    }

}
