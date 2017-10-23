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
        startPauseResume = (true, false, false)
        aesthetics_ShowIntervalMissingWarning()
    }

    func loadTimer(){
        configureNavBar()
        aesthetics_initial()

        //Validate the timer
        guard let theTimerIndex = itvTimerIndex
            , ITVUser.sharedInstance.thisTimers?[theTimerIndex] != nil
            , let theTimer = ITVUser.sharedInstance.thisTimers?[theTimerIndex]
            , !theTimer.totalTimeHMS().isEmpty else {
            timerInvalid()
            return
        }
        
        timerNameLabel.text = theTimer.thisName
        
        //Validate the intervals
        guard let theIntervals = theTimer.thisIntervals
            , let theIntervalCount = theTimer.thisIntervals?.count
            , theIntervalCount > 0 else {
            ITVWarningForUser.sharedInstance.thisUserWarning = UserWarning.MissingIntervals
            timerInvalid()
            return
        }

        intervalsToRun = theIntervals
        configureCollectionView()
        
        guard let theSeconds = intervalsToRun[0].thisSeconds else {
            timerInvalid()
            return
        }

        ellapsedSeconds = theSeconds
        intervalTime = theSeconds
        timerTotalSeconds = Double(theTimer.totalSeconds()!) //maybe dont need this
        numberOfIntervals = theIntervals.count

        aesthetics_manageTimerProgress()
        aesthetics_manageIntervalProgress(indicator: intervalsToRun[0].thisIndicator)
        

        //TODO: Make the countdown timer a QoS user interface thread
        aesthetics_timerLabels()
        //does user want to start it immedialy
        aesthetics_initializeTimeLabels()
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
        
        guard let theTimer = ITVUser.sharedInstance.thisTimers?[theTimerIndex], !theTimer.totalTimeHMS().isEmpty else {
            timerInvalid()
            return
        }
        
        //Second, if this is a selected timer, do we show the weather
        //TODO: update weather only every 3 hours or if user has moved more than 5 kilometers
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
