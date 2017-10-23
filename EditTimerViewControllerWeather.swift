//
//  EditTimerViewControllerWeather.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-23.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

extension EditTimerViewController{
    func showWeather(){
        if ITVCoreLocation.sharedInstance.isLocationServicesAndNetworkAvailable() {
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
        if let theTopCell = topCell(){
            theTopCell.weatherActivityIndicator.isHidden = false
            theTopCell.weatherActivityIndicator.startAnimating()
        }
    }
    func activityIndicatorStop(){
        if let theTopCell = topCell(){
            theTopCell.weatherActivityIndicator.stopAnimating()
            theTopCell.weatherActivityIndicator.isHidden = true
        }
    }
    func startSettingWeather(){
        if ITVUser.sharedInstance.thisShouldUpdateWeather {
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
    func setWeatherFromNetwork(){
        activityIndicatorStart()
        GET_WEATHER_FROM_NETWORK()
    }
    func updateWeatherInformation(){
        if let theTopCell = topCell(){
            activityIndicatorStop()
            
            guard let theTemperature = getTemperatureUnit(from: theTopCell.temperatureSegmentedControl!).temperature(kelvins: ITVUser.sharedInstance.thisCurrentWeather?.thisKelvin)  else {
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
            
            theTopCell.weatherTemperatureLabel.text = theTemperature
            theTopCell.weatherIconImageView.image = theImage
            
            aesthetics_showWeatherViews()

        }
    }
}
