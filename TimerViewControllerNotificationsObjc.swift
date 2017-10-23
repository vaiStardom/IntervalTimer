//
//  TimerViewControllerNotificationsObjc.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-26.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

@objc extension TimerViewController {
    //TODO: Investigate the useful ness of this function versus the calls made to GET_WEATHER_FROM_NETWORK(), maybe this can be deleted.
    func canAttemptWeatherUpdate(_ notification: Notification){
        print("------> TimerViewController canAttemptWeatherUpdate notification received")
        do {
            try ITVCurrentWeather.getWeatherByPriority()
        } catch let error {
            activityIndicatorStop()
            SHOW_USER_WARNING(type: UserWarning.LocationManagerDidFail, with: "\(error)")
        }        
    }
    func cancelGetWeather(){
        print("------> TimerViewController cancelGetWeather()  called by getWeatherDeadlineTimer")
        ITVCurrentWeather.cancelGetWeather()
        aesthetics_showMissingWeatherWarning()
    }
    func didGetCurrentWeather(_ notification: Notification){
        print("------> TimerViewController didGetCurrentWeather notification received")
        getWeatherDeadlineTimer.invalidate()
        updateWeatherInformation()
    }
    func errorGettingWeather(_ notification: Notification){
        aesthetics_showMissingWeatherWarning()
    }
    func segueToEditInterval(_ notification: Notification){
        print("------> NOTIFICATION didTapOnAddInterval() received")
        performSegue(withIdentifier: Segues.TimerToEditInterval, sender: nil)
    }
}
