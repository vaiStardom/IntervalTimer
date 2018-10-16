//
//  TimerViewControllerActions.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-20.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

//MARK: Actions
extension TimerViewController {
    @IBAction func userWarning(_ sender: UIButton) {
        SHOW_USER_WARNING(type: ITVWarningForUser.sharedInstance.thisUserWarning)
    }

    @IBAction func cancel(_ sender: UIButton) {
        stopTimer()
    }
    
    @IBAction func startPauseResumeTimer(_ sender: Any) {
        if startPauseResume == (true, false, false) { //start the timer
            runIntervalTimer()
            aesthetics_timerStart()
            startPauseResume = (false, true, false)
        } else if startPauseResume == (false, true, false) { //pause the timer
            timer.invalidate()
            aesthetics_timerPause()
            startPauseResume = (false, false, true)
        } else if startPauseResume == (false, false, true) { //resume the timer
            runIntervalTimer()
            aesthetics_timerResume()
            startPauseResume = (false, true, false)
        }
    }

    //TODO: - Clicking here should also re-attempt to get the missing information by verifying first that the previous error no-longer exists, show the warning if it exists still, or re-attempt weather retreival.
    @IBAction func weatherMissing(_ sender: Any) {
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
            if ITVWarningForUser.sharedInstance.thisMessage != nil, !(ITVWarningForUser.sharedInstance.thisMessage?.isEmpty)! {
                SHOW_USER_WARNING(type: ITVWarningForUser.sharedInstance.thisUserWarning, with: ITVWarningForUser.sharedInstance.thisMessage)
            } else {
                SHOW_USER_WARNING(type: ITVWarningForUser.sharedInstance.thisUserWarning)
            }
        }
    }
}
