//
//  TimerViewControllerTimersProtocol.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-12.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

extension TimerViewController: ITVUpdateTimersProtocol, ITVUpdateIntervalsProtocol{
    func didUpdateTimers() {
        timerNameLabel.text = ITVUser.sharedInstance.thisTimers?[itvTimerIndex!].thisName
        if (ITVUser.sharedInstance.thisTimers?[itvTimerIndex!].thisShowWeather)! {
            updateWeatherInformation()
        } else {
            aesthetics_hideWeatherView()
        }
    }
    func didUpdateIntervals(_ intervals:[ITVInterval]?){
        //do nothing, this wont be called for this vc
    }
    func didEditASavedTimersInterval(){

        //TODO: understand why the encoding is not called when updating the new values individualy and why we have to replace the timer with theNewTimer

        if let theTimerIndex = itvTimerIndex {
            if let theNewTimer = ITVUser.sharedInstance.thisTimers?[theTimerIndex] {
                ITVUser.sharedInstance.thisTimers?[theTimerIndex] = theNewTimer
            } else {
                fatalError("A timer is missing at the provided index \(theTimerIndex).")
            }
        } else {
            fatalError("An index is needed. This timer's index should still be accessible at this point.")
        }

        loadTimer()
        loadWeather()
    }
}
