//
//  EditTimerViewControllerAesthetics.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-01.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

extension EditTimerViewController {
    func aesthetics_initial(){
        activityIndicator.color = IntervalTimerColors.Orange
    }
    func aesthetics_showMissingWeatherWarning(){
        //TODO: program the alert to show when this button is pressed
//        showMissingTemperatureWarningButton.isHidden = false
//        missingTemperatureImageView.isHidden = false
        
        weatherIconImageView.isHidden = true
        weatherTemperatureLabel.isHidden = true
    }
    func aesthetics_hideMissingWeatherWarning(){
//        showMissingTemperatureWarningButton.isHidden = true
//        missingTemperatureImageView.isHidden = true
        
        weatherIconImageView.isHidden = false
        weatherTemperatureLabel.isHidden = false
    }
}
