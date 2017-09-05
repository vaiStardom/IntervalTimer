//
//  TimerViewControllerLifeCycle.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-24.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

//MARK: Life-cycle
extension TimerViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        aesthetics_initial()
        
        //First, is this a selected timer?
        if let theIntervalTimer = intervalTimer {
            //yes
            timerNameLabel.text = theIntervalTimer.thisName
            //does user want to start it immedialy
            if let theStartIntervalTimer = startIntervalTimer, theStartIntervalTimer {
                //yes
                ellapsedSeconds = theIntervalTimer.thisIntervals![0].thisSeconds!
                runIntervalTimer()
                aesthetics_timerStart()
                startPauseResume = (false, true, false)
            } else {
                //no
                startPauseResume = (true, false, false)
            }
            
            //Second, if this is a selected timer, do we show the weather
            if theIntervalTimer.thisShowWeather! {
            
            }
            
        } else {
            //no, user probably wants to create a new timer
            timerNameLabel.text = ""
            startPauseResume = (true, false, false)
        }

        //TODO: If timer is set to show weather {..do all the below...}
        //TODO: call this when user switches on weather for the first time
        //TODO: cache the weather, update it only every 3 hours or if user has moved more than 5 kilometers
        

        //IntervalTimerCoreLocation.sharedInstance.firstTimeLocationUsage()
        
        //Only register if user wants weather for this timer
        self.registerNotifications() //will register at first weather use

        if ITVUser.sharedInstance.thisShouldUpdateWeather! {
            setWeatherFromNetwork()
//            activityIndicatorStart()
//            
//            //TODO: call this when user starts a timer
//            //IntervalTimerUser.sharedInstance.startUpdatingLocationManager()
//            print("------> TimerViewController viewDidLoad() requesting Location")
//            IntervalTimerCoreLocation.sharedInstance.requestLocation()
//            
//            print("------> TimerViewController viewDidLoad() attempting to set weather")
//            IntervalTimerCurrentWeather.getWeatherByPriority()
        } else {
            //has the weather been retreived before, if yes update the saved weather
            if ITVUser.sharedInstance.thisCurrentWeather != nil {
                updateWeatherInformation()
            } else {
                setWeatherFromNetwork()
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
