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
    
    func aesthetics_timerNamePlaceHolder(){
        if let theTopCell = topCell(){
            theTopCell.timerNameTextField.attributedPlaceholder = NSAttributedString(string: Litterals.TimerNamePlaceholder, attributes: [NSAttributedString.Key.foregroundColor : ITVColors.OrangeAlpha50])
        }
    }
    func aesthetics_hideWarning(){
        if let theTopCell = topCell(){
            theTopCell.warningImageView.isHidden = true
            theTopCell.warningButton.isEnabled = false
        }
    }
    
    func aesthetics_dontLoadWeather(){
        if let theTopCell = topCell(){
            theTopCell.showWeatherSwitch.isOn = false
            theTopCell.weatherIconImageView.isHidden = true
            theTopCell.weatherTemperatureLabel.isHidden = true
            theTopCell.temperatureSegmentedControl.isHidden = true
            theTopCell.showWeatherDescriptionLabel.isHidden = false
        }
    }
    func aesthetics_showWeatherDescription(){
        if let theTopCell = topCell() {
            theTopCell.showWeatherDescriptionLabel.alpha = 1.0
            theTopCell.showWeatherDescriptionLabel.isHidden = false
        }
    }
    
    func aesthetics_startLoadingWeather() {
        activityIndicatorStart()
        aesthetics_hideWarning()
        
        if let theTopCell = topCell() {
            theTopCell.temperatureSegmentedControl.isHidden = false
            theTopCell.weatherIconImageView.isHidden = false
            
            theTopCell.showWeatherSwitch.isOn = true
            theTopCell.weatherTemperatureLabel.isHidden = true
            theTopCell.showWeatherDescriptionLabel.isHidden = true
        }
    }
    func aesthetics_showMissingWeatherWarning(){
        //TODO: - UI -> program the alert to show when this button is pressed
        activityIndicatorStop()
        aesthetics_hideWeatherViews()
        
        if let theTopCell = topCell() {
            theTopCell.warningButton.isEnabled = true
            theTopCell.warningImageView.alpha = 0.0
            
            theTopCell.warningButton.isHidden = false
            theTopCell.warningImageView.isHidden = false
            
            theTopCell.warningImageView.alpha = 1.0
        }
    }
    func aesthetics_hideMissingWeatherWarning(){
        aesthetics_showWeatherViews()
    }
    func aesthetics_hideWeatherViews(){
        
        if let theTopCell = topCell() {
            theTopCell.weatherIconImageView.isHidden = true
            theTopCell.weatherTemperatureLabel.isHidden = true
            theTopCell.temperatureSegmentedControl.isHidden = true
            
            theTopCell.weatherIconImageView.image = nil
            theTopCell.weatherTemperatureLabel.text = nil
        }
    }
    func aesthetics_showWeatherViews(){
        if let theTopCell = topCell() {
            theTopCell.weatherIconImageView.alpha = 0.0
            theTopCell.weatherTemperatureLabel.alpha = 0.0
            theTopCell.temperatureSegmentedControl.alpha = 0.0
            
            theTopCell.weatherIconImageView.isHidden = false
            theTopCell.weatherTemperatureLabel.isHidden = false
            theTopCell.temperatureSegmentedControl.isHidden = false
            
            theTopCell.showWeatherDescriptionLabel.isHidden = true
            
            theTopCell.weatherIconImageView.alpha = 1.0
            theTopCell.weatherTemperatureLabel.alpha = 1.0
            theTopCell.temperatureSegmentedControl.alpha = 1.0
        }
    }
}
