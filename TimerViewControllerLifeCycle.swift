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
        if let theIntervalTimer = itvTimer {
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
            //TODO: cache the weather, update it only every 3 hours or if user has moved more than 5 kilometers
            if theIntervalTimer.thisShowWeather! {
                if ITVCoreLocation.sharedInstance.isLocationServicesAndNetworkAvailable() {
                    self.registerNotifications() //will register at first weather use
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
            }
        } else {
            //no, user probably wants to create a new timer
            timerNameLabel.text = ""
            startPauseResume = (true, false, false)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
