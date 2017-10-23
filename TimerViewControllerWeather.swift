//
//  TimerViewControllerWeather.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-20.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

//MARK: - Weather Management
extension TimerViewController{
    func setWeatherFromNetwork(){
        activityIndicatorStart()
        GET_WEATHER_FROM_NETWORK()
        getWeatherDeadlineTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(TimerViewController.cancelGetWeather), userInfo: nil, repeats: false)
        print("------> TimerViewController getWeatherDeadlineTimer set")
    }
    func updateWeatherInformation(){
        activityIndicatorStop()
        guard let theTimerIndex = itvTimerIndex else {
            aesthetics_showMissingWeatherWarning()
            fatalError("------> ERROR - TimerViewController updateWeatherInformation invalid timer index \(String(describing: itvTimerIndex)))")
        }
        
        guard let theTemperature = ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisTemperatureUnit.temperature(kelvins: ITVUser.sharedInstance.thisCurrentWeather?.thisKelvin)  else {
            aesthetics_showMissingWeatherWarning()
            fatalError("------> ERROR - TimerViewController updateWeatherInformation invalid temperature \(String(describing: ITVUser.sharedInstance.thisCurrentWeather?.thisKelvin))")
        }
        
        guard let theIcon = ITVUser.sharedInstance.thisCurrentWeather?.thisIcon! else {
            aesthetics_showMissingWeatherWarning()
            fatalError("------> ERROR TimerViewController updateWeatherInformation invalid icon \(String(describing: ITVUser.sharedInstance.thisCurrentWeather?.thisIcon!))")
        }
        
        guard let theImage = UIImage(named: theIcon) else {
            aesthetics_showMissingWeatherWarning()
            fatalError("------> ERROR TimerViewController updateWeatherInformation invalid image for icon name \(theIcon)")
        }
        
        print("------> TimerViewController updateWeatherInformation theTemperature = \(theTemperature), theImage = \(theIcon)")
        
        weatherImageView.alpha = 0.0
        weatherTemperatureLabel.alpha = 0.0
        
        aesthetics_hideMissingWeatherWarning()
        
        weatherTemperatureLabel.text = theTemperature
        weatherImageView.image = theImage
        
        UIView.animate(withDuration: 0.5, animations: {
            self.weatherImageView.alpha = 1.0
            self.weatherTemperatureLabel.alpha = 1.0
        })
    }
}
