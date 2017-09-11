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
        weatherActivityIndicator.color = ITVColors.Orange
        weatherActivityIndicator.isHidden = true
        showWeatherSwitch.isOn = false
        timerNameTextField.tintColor = ITVColors.Orange
        temperatureSegmentedControl.isHidden = true
        temperatureSegmentedControl.selectedSegmentIndex = 2
        showWeatherDescriptionLabel.isHidden = false
    }
    func aesthetics_dontLoadWeather(){
        showWeatherSwitch.isOn = false
        weatherIconImageView.isHidden = true
        weatherTemperatureLabel.isHidden = true
        temperatureSegmentedControl.isHidden = true
        showWeatherDescriptionLabel.isHidden = false
    }
    func aesthetics_showWeatherDescription(){
        showWeatherDescriptionLabel.alpha = 1.0
        showWeatherDescriptionLabel.isHidden = false
    }
    func aesthetics_startLoadingWeather() {
        activityIndicatorStart()
        showWeatherSwitch.isOn = true
        weatherIconImageView.isHidden = false
        weatherTemperatureLabel.isHidden = true
        temperatureSegmentedControl.isHidden = false
        showWeatherDescriptionLabel.isHidden = true
        
    }
    func aesthetics_showMissingWeatherWarning(){
        //TODO: program the alert to show when this button is pressed
        activityIndicatorStop()
        aesthetics_hideWeatherViews()
       
        warningButton.isHidden = false
        warningImageView.alpha = 0.0
        
        warningButton.isHidden = false
        warningImageView.isHidden = false
        
        warningImageView.alpha = 1.0
    }
    func aesthetics_hideMissingWeatherWarning(){
        aesthetics_showWeatherViews()
    }
    func aesthetics_hideWeatherViews(){

        weatherIconImageView.isHidden = true
        weatherTemperatureLabel.isHidden = true
        temperatureSegmentedControl.isHidden = true
            
        weatherIconImageView.image = nil
        weatherTemperatureLabel.text = nil
    }
    func aesthetics_showWeatherViews(){
        weatherIconImageView.alpha = 0.0
        weatherTemperatureLabel.alpha = 0.0
        temperatureSegmentedControl.alpha = 0.0
        
        weatherIconImageView.isHidden = false
        weatherTemperatureLabel.isHidden = false
        temperatureSegmentedControl.isHidden = false

        weatherIconImageView.alpha = 1.0
        weatherTemperatureLabel.alpha = 1.0
        temperatureSegmentedControl.alpha = 1.0        
    }
}
