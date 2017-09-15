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
    func showWeather(){
        if ITVCoreLocation.sharedInstance.isLocationServicesAndNetworkAvailable() {
            self.registerNotifications() //will register at first weather use
            if ITVUser.sharedInstance.thisShouldUpdateWeather {
                setWeatherFromNetwork()
            } else {
                if ITVUser.sharedInstance.thisCurrentWeather != nil {
                    updateWeatherInformation()
                } else {
                    setWeatherFromNetwork()
                }
            }
        } else {
            aesthetics_showMissingWeatherWarning()
        }
    }

    func activityIndicatorStart(){
        weatherActivityIndicator.isHidden = false
        weatherActivityIndicator.startAnimating()
    }
    
    func activityIndicatorStop(){
        weatherActivityIndicator.stopAnimating()
        weatherActivityIndicator.isHidden = true
    }
    
    func errorGettingWeather(_ notification: Notification){
        aesthetics_showMissingWeatherWarning()
    }
    
    func canAttemptWeatherUpdate(_ notification: Notification){
        print("------> EditTimerViewController canAttemptWeatherUpdate notification received")
        do {
            try ITVCurrentWeather.getWeatherByPriority()
        } catch let error {
            activityIndicatorStop()
            showUserWarning(type: UserWarning.LocationManagerDidFail, with: "\(error)")
        }
    }
    
    func startSettingWeather(){
        if ITVUser.sharedInstance.thisShouldUpdateWeather {
            //TODO: cache the weather, update it only every 3 hours or if user has moved more than 5 kilometers
            print("------> EditTimerViewController startSettingWeather() will update weather from Network")
            setWeatherFromNetwork()
        } else {
            if ITVUser.sharedInstance.thisCurrentWeather != nil {
                print("------> EditTimerViewController startSettingWeather() will update weather from UserDefaults")
                updateWeatherInformation()
            } else {
                print("------> EditTimerViewController startSettingWeather() will update weather from Network")
                setWeatherFromNetwork()
            }
        }
    }
    func didAuthorizeLocationServices(_ notification: Notification){
        //IntervalTimerCoreLocation.sharedInstance.firstTimeLocationUsage()
        startSettingWeather()
    }
    func didGetCurrentWeather(_ notification: Notification){
        print("------> EditTimerViewController didGetCurrentWeather notification received")
        if showWeatherSwitch.isOn {
            updateWeatherInformation()
        }
    }
    func setWeatherFromNetwork(){
        activityIndicatorStart()
        getWeatherFromNetwork()
    }
    func updateWeatherInformation(){
        activityIndicatorStop()
        
        guard let theTemperature = getTemperatureUnit(from: temperatureSegmentedControl!).temperature(kelvins: ITVUser.sharedInstance.thisCurrentWeather?.thisKelvin)  else {
            aesthetics_showMissingWeatherWarning()
            fatalError("------> ERROR - EditTimerViewController updateWeatherInformation invalid temperature \(String(describing: ITVUser.sharedInstance.thisCurrentWeather?.thisKelvin))")
        }

        guard let theIcon = ITVUser.sharedInstance.thisCurrentWeather?.thisIcon! else {
            aesthetics_showMissingWeatherWarning()
            fatalError("------> ERROR EditTimerViewController updateWeatherInformation invalid icon \(String(describing: ITVUser.sharedInstance.thisCurrentWeather?.thisIcon!))")
        }
        
        guard let theImage = UIImage(named: theIcon) else {
            aesthetics_showMissingWeatherWarning()
            fatalError("------> ERROR EditTimerViewController updateWeatherInformation invalid image for icon name \(theIcon)")
        }
        
        
        print("------> EditTimerViewController updateWeatherInformation theTemperature = \(theTemperature), theImage = \(theIcon)")
        
        aesthetics_hideMissingWeatherWarning()
        
        weatherTemperatureLabel.text = theTemperature
        weatherIconImageView.image = theImage

        aesthetics_showWeatherViews()
    }
}
