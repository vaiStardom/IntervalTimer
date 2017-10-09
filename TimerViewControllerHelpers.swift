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
    func intervalProgressInitialLayer(withColor: CGColor) {
        let bezierPath = UIBezierPath(roundedRect: intervalProgressView.bounds, cornerRadius: 0)
        bezierPath.close()
        intervalBorderLayer.path = bezierPath.cgPath
        intervalBorderLayer.fillColor = withColor
        intervalBorderLayer.strokeEnd = 0
        intervalProgressView.layer.addSublayer(intervalBorderLayer)
    }
    func intervalProgress(incremented : CGFloat){
        if incremented <= intervalProgressView.bounds.width - 10{
            intervalProgressLayer.removeFromSuperlayer()
            let bezierPathProg = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: incremented , height: intervalProgressView.bounds.height) , cornerRadius: 0)
            bezierPathProg.close()
            intervalProgressLayer.path = bezierPathProg.cgPath
            intervalProgressLayer.fillColor = intervalProgressColor?.cgColor
            intervalBorderLayer.addSublayer(intervalProgressLayer)
        }
    }
    func timerProgressInitialLayer(withColor: CGColor) {
        let bezierPath = UIBezierPath(roundedRect: timerProgressView.bounds, cornerRadius: 0)
        bezierPath.close()
        timerBorderLayer.path = bezierPath.cgPath
        timerBorderLayer.fillColor = withColor
        timerBorderLayer.strokeEnd = 0
        timerProgressView.layer.addSublayer(timerBorderLayer)
    }
    func timerProgress(incremented : CGFloat){
        if incremented <= timerProgressView.bounds.width - 10{
            timerProgressLayer.removeFromSuperlayer()
            let bezierPathProg = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: incremented , height: timerProgressView.bounds.height) , cornerRadius: 0)
            bezierPathProg.close()
            timerProgressLayer.path = bezierPathProg.cgPath
            timerProgressLayer.fillColor = UIColor.black.cgColor
            timerBorderLayer.addSublayer(timerProgressLayer)
        }
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
        aesthetics_manageIntervalProgress(indicator: intervalsToRun[indexOfIntervalToRun].thisIndicator)
        
        //TODO: If an interval is zero, but timer total seconds is not, color interval nil
        
        //TODO: QoS user interface thread
        
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
