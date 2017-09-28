//
//  EditTimerViewControllerNotificationsObjc.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-23.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

@objc extension EditTimerViewController {
    func canAttemptWeatherUpdate(_ notification: Notification){
        print("------> EditTimerViewController canAttemptWeatherUpdate notification received")
        do {
            try ITVCurrentWeather.getWeatherByPriority()
        } catch let error {
            activityIndicatorStop()
            SHOW_USER_WARNING(type: UserWarning.LocationManagerDidFail, with: "\(error)")
        }
    }
    
    func didGetCurrentWeather(_ notification: Notification){
        print("------> EditTimerViewController didGetCurrentWeather notification received")
        if let theTopCell = topCell(){
            if theTopCell.showWeatherSwitch.isOn {
                updateWeatherInformation()
            }
        }
    }
    func didAuthorizeLocationServices(_ notification: Notification){
        aesthetics_hideWarning()
        startSettingWeather()
    }
    func errorGettingWeather(_ notification: Notification){
        aesthetics_showMissingWeatherWarning()
    }
}
