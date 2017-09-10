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
    func aesthetics_initial(){
        activityIndicator.color = ITVColors.Orange
        showWeatherSwitch.isOn = false
    }
    func aesthetics_showMissingWeatherWarning(){
        //TODO: program the alert to show when this button is pressed
        activityIndicatorStop()
        aesthetics_hideWeatherViews()
       
        warningButton.isHidden = false
        warningImageView.alpha = 0.0
        
        warningButton.isHidden = false
        warningImageView.isHidden = false
        
        UIView.animate(withDuration: 1.5, animations: {
            self.warningImageView.alpha = 1.0
        })
    }
    func aesthetics_hideMissingWeatherWarning(){
//        showMissingTemperatureWarningButton.isHidden = true
//        missingTemperatureImageView.isHidden = true
        
        aesthetics_showWeatherViews()
    }
    func aesthetics_hideWeatherViews(){
        weatherIconImageView.isHidden = true
        weatherTemperatureLabel.isHidden = true
    }
    func aesthetics_showWeatherViews(){
        weatherIconImageView.isHidden = false
        weatherTemperatureLabel.isHidden = false
    }
}
