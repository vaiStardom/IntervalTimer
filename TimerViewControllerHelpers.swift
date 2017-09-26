//
//  TimerViewControllerHelpers.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-07.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

//MARK: - Helpers
extension TimerViewController{
    func activityIndicatorStart(){
        weatherImageView.addSubview(activityIndicator)
        activityIndicator.frame = weatherImageView.bounds
        activityIndicator.startAnimating()
    }
    func activityIndicatorStop(){
        activityIndicator.stopAnimating()
    }
    func timerInvalid(){
        //TODO: design a warning for the user to add intervals, since this timer is empty
        startPauseResume = (true, false, false)
        aesthetics_ShowIntervalMissingWarning()
    }
    func loadTimer(){
        configureNavBar()
        aesthetics_initial()

        //Validate the timer
        guard let theTimerIndex = itvTimerIndex , ITVUser.sharedInstance.thisTimers?[theTimerIndex] != nil else {
            timerInvalid()
            return
        }
        
        guard let theTimer = ITVUser.sharedInstance.thisTimers?[theTimerIndex], !theTimer.totalTime().isEmpty else {
            timerInvalid()
            return
        }
        
        timerNameLabel.text = theTimer.thisName
        
        //Validate the intervals
        guard let theIntervals = theTimer.thisIntervals, let theIntervalCount = theTimer.thisIntervals?.count, theIntervalCount > 0 else {
            //TODO: version two ...maybe propose a stop watch when no intervals were added....?
            ITVWarningForUser.sharedInstance.thisUserWarning = UserWarning.MissingIntervals
            timerInvalid()
            return
        }
        
//        print("------> TimerViewController loadTimer() VALID TIMER, ")
        intervalsToRun = theIntervals
        indexOfIntervalToRun = 0
        configureCollectionView()
        
        guard let theSeconds = intervalsToRun[indexOfIntervalToRun].thisSeconds else {
            timerInvalid()
            return
        }
        
        ellapsedSeconds = theSeconds
        aesthetics_managePulseIndicator(indicator: intervalsToRun[indexOfIntervalToRun].thisIndicator)
        
        //TODO: If an interval is zero, but timer total seconds is not, color interval nil
        
        //TODO: QoS user interface thread
        //does user want to start it immedialy
        if let theStartIntervalTimer = startIntervalTimer, theStartIntervalTimer {
            
            //yes
            
            runIntervalTimer()
            aesthetics_timerStart()
            startPauseResume = (false, true, false)
        } else {
            //no
            startPauseResume = (true, false, false)
        }
    }
    func loadWeather(){
        //Validate the timer
        guard let theTimerIndex = itvTimerIndex , ITVUser.sharedInstance.thisTimers?[theTimerIndex] != nil else {
            timerInvalid()
            return
        }
        
        guard let theTimer = ITVUser.sharedInstance.thisTimers?[theTimerIndex], !theTimer.totalTime().isEmpty else {
            timerInvalid()
            return
        }
        
        //Second, if this is a selected timer, do we show the weather
        //TODO: cache the weather, update it only every 3 hours or if user has moved more than 5 kilometers
        if theTimer.thisShowWeather {
            
            if ITVCoreLocation.sharedInstance.isLocationServicesAndNetworkAvailable() {
                //IntervalTimerCoreLocation.sharedInstance.firstTimeLocationUsage()
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
        } else {
            aesthetics_hideWeatherView()
        }
    }
}
