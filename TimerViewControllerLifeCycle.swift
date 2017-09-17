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
    
    override func viewDidAppear(_ animated: Bool) {
        configureCollectionView()
        collectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        aesthetics_initial()
        
        //Validate the timer
        guard let theTimerIndex = itvTimerIndex , ITVUser.sharedInstance.thisTimers?[theTimerIndex] != nil else {
            timerInvalid()
            return
        }
        
        guard let theIntervalTimer = ITVUser.sharedInstance.thisTimers?[theTimerIndex], !theIntervalTimer.totalTime().isEmpty else {
            timerInvalid()
            return
        }
        
        timerNameLabel.text = theIntervalTimer.thisName
        
        //Validate the intervals
        guard let theIntervalCount = theIntervalTimer.thisIntervals?.count, theIntervalCount > 0 else {
            timerInvalid()
            return
        }
        
        configureCollectionView()
        
        aesthetics_managePulseIndicator(indicator: intervalsToRun?[0].thisIndicator)
        
        //TODO: QoS user interface thread
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
        
        //        if let theFirstInterval = theIntervalTimer.thisIntervals?.first {
        //            if let theFirstIntervalsSeconds = theFirstInterval.thisSeconds, theFirstIntervalsSeconds > 0.0 {
        //
        //                //yes
        //                //TODO: load the collection view
        //
        //                //TODO: QoS user interface thread
        //                //does user want to start it immedialy
        //                if let theStartIntervalTimer = startIntervalTimer, theStartIntervalTimer {
        //                    //yes
        //                    ellapsedSeconds = theIntervalTimer.thisIntervals![0].thisSeconds!
        //                    runIntervalTimer()
        //                    aesthetics_timerStart()
        //                    startPauseResume = (false, true, false)
        //                } else {
        //                    //no
        //                    startPauseResume = (true, false, false)
        //                }
        //
        //            } else {
        //                //interval empty, nothing to run
        //                //TODO: If an interval is zero, but timer total seconds is not, color interval nil
        //                timerInvalid()
        //            }
        //        } else {
        //            //interval empty, nothing to run
        //            timerInvalid()
        //        }
        
        //Second, if this is a selected timer, do we show the weather
        //TODO: cache the weather, update it only every 3 hours or if user has moved more than 5 kilometers
        if theIntervalTimer.thisShowWeather {
            
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
        } else {
            aesthetics_hideWeatherView()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
