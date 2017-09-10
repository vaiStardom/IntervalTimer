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
        timerNameTextField.tintColor = ITVColors.Orange
    }
    
    func aesthetics_hideShowWeatherDescription(){
    
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
        aesthetics_showWeatherViews()
    }
    func aesthetics_hideWeatherViews(){
        UIView.animate(withDuration: 0.5, animations: {
            self.weatherIconImageView.alpha = 0.0
            self.weatherTemperatureLabel.alpha = 0.0
        }, completion: { (completed) in
            self.weatherIconImageView.isHidden = true
            self.weatherTemperatureLabel.isHidden = true
        })
        weatherIconImageView.isHidden = true
        weatherTemperatureLabel.isHidden = true
    }
    func aesthetics_showWeatherViews(){
        self.weatherIconImageView.alpha = 0.0
        self.weatherTemperatureLabel.alpha = 0.0

        self.weatherIconImageView.isHidden = false
        self.weatherTemperatureLabel.isHidden = false
        
        UIView.animate(withDuration: 1.5, animations: {
            self.weatherIconImageView.alpha = 1.0
            self.weatherTemperatureLabel.alpha = 1.0
        })
        weatherIconImageView.isHidden = false
        weatherTemperatureLabel.isHidden = false
    }
}
