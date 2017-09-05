//
//  EditTimerViewControllerWeather.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-03.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation


import UIKit

//MARK: - Weather Management
extension EditTimerViewController{
    func activityIndicatorStart(){
        weatherIconImageView.addSubview(activityIndicator)
        activityIndicator.frame = weatherIconImageView.bounds
        activityIndicator.startAnimating()
    }
    func activityIndicatorStop(){
        activityIndicator.stopAnimating()
    }
    func canAttemptWeatherUpdate(_ notification: Notification){
        print("------> TimerViewController canAttemptWeatherUpdate notification received")
        IntervalTimerCurrentWeather.getWeatherByPriority()
    }
    func didGetCurrentWeather(_ notification: Notification){
        updateWeatherInformation()
    }
    func setWeatherFromNetwork(){
        activityIndicatorStart()
        getWeatherFromNetwork()
    }
    func updateWeatherInformation(){
        activityIndicatorStop()
        
        // Background Thread Or Service call Or DB fetch etc
        print("------> TimerViewController didGetCurrentWeather notification received")
        guard let theTemperature = ITVUser.sharedInstance.thisCurrentWeather?.thisTemperature else {
            aesthetics_showMissingWeatherWarning()
            fatalError("------> ERROR - TimerViewController didGetCurrentWeather invalid temperature \(String(describing: ITVUser.sharedInstance.thisCurrentWeather?.thisTemperature))")
        }
        
        guard let theIcon = ITVUser.sharedInstance.thisCurrentWeather?.thisIcon! else {
            aesthetics_showMissingWeatherWarning()
            fatalError("------> ERROR TimerViewController didGetCurrentWeather invalid icon \(String(describing: ITVUser.sharedInstance.thisCurrentWeather?.thisIcon!))")
        }
        
        guard let theImage = UIImage(named: theIcon) else {
            aesthetics_showMissingWeatherWarning()
            fatalError("------> ERROR TimerViewController didGetCurrentWeather invalid image for icon name \(theIcon)")
        }
        
        print("------> TimerViewController didGetCurrentWeather theTemperature = \(theTemperature), theImage = \(theIcon)")
        
        weatherIconImageView.alpha = 0.0
        weatherTemperatureLabel.alpha = 0.0
        
        aesthetics_hideMissingWeatherWarning()
        
        weatherTemperatureLabel.text = theTemperature
        weatherIconImageView.image = theImage
        
        UIView.animate(withDuration: 1.5, animations: {
            self.weatherIconImageView.alpha = 1.0
            self.weatherTemperatureLabel.alpha = 1.0
        })
        
        //Weather updated, no need to update location until 3 hrs have passed or user has moved 1KM
        ITVUser.sharedInstance.thisShouldUpdateWeather = false
    }
}
