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
        temperatureSegmentedControl.isHidden = true
        temperatureSegmentedControl.selectedSegmentIndex = 2
        showWeatherDescriptionLabel.isHidden = false
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
        
        UIView.animate(withDuration: 0.5, animations: {
            self.warningImageView.alpha = 1.0
        })
    }
    func aesthetics_hideMissingWeatherWarning(){
        aesthetics_showWeatherViews()
    }
    func aesthetics_hideWeatherViews(){
        
        self.showWeatherDescriptionLabel.isHidden = false
        
        UIView.animate(withDuration: 0.5, animations: {
            self.weatherIconImageView.alpha = 0.0
            self.weatherTemperatureLabel.alpha = 0.0
            self.temperatureSegmentedControl.alpha = 0.0
            self.showWeatherDescriptionLabel.alpha = 1.0

        }, completion: { (completed) in
            self.weatherIconImageView.isHidden = true
            self.weatherTemperatureLabel.isHidden = true
            self.temperatureSegmentedControl.isHidden = true
        })
        weatherIconImageView.isHidden = true
        weatherTemperatureLabel.isHidden = true
    }
    func aesthetics_showWeatherViews(){
        weatherIconImageView.alpha = 0.0
        weatherTemperatureLabel.alpha = 0.0
        temperatureSegmentedControl.alpha = 0.0
        
        weatherIconImageView.isHidden = false
        weatherTemperatureLabel.isHidden = false
        temperatureSegmentedControl.isHidden = false
        
        UIView.animate(withDuration: 0.5, animations: {
            self.weatherIconImageView.alpha = 1.0
            self.weatherTemperatureLabel.alpha = 1.0
            self.temperatureSegmentedControl.alpha = 1.0
            self.showWeatherDescriptionLabel.alpha = 0.0
        }, completion: { (completed) in
            self.showWeatherDescriptionLabel.isHidden = true
        })
        
        
    }
}
