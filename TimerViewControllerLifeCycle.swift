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
        startPauseResume = (true, false, false)
        timerNameLabel.text = "Peak 8"
        ellapsedSeconds = Double(totalSeconds)
        aesthetics_initial()
        
        
        /////start timer
        runIntervalTimer()
        aesthetics_timerStart()
        startPauseResume = (false, true, false)
        /////
        
        testLabel.font = SystemFont.RegularMonospaced17
        
        //TODO: If timer is set to show weather {..do all the below...}
        //TODO: call this when user switches on weather for the first time
        //        IntervalTimerUser.sharedInstance.firstTimeLocationUsage()
        IntervalTimerCoreLocation.sharedInstance.firstTimeLocationUsage()
        
        //Only register if user wants weather for this timer
        self.registerNotifications() //will register at first weather use
        
        
        if IntervalTimerUser.sharedInstance.thisShouldUpdateWeather! {
            
            activityIndicatorStart()
            
            //TODO: call this when user starts a timer
            //IntervalTimerUser.sharedInstance.startUpdatingLocationManager()
            IntervalTimerCoreLocation.sharedInstance.requestLocation()
            
            print("------> TimerViewController viewDidLoad() attempting to set weather")
            IntervalTimerCurrentWeather.getWeatherByPriority()
            
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
