//
//  TimerViewControllerTimersProtocol.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-12.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

extension TimerViewController: ITVUpdateTimersProtocol, ITVEditIntervalProtocol, ITVDeleteTimerFromTimerViewProtocol{
    func didDelete() {
        back()
    }
    
    func didUpdateNew(_ intervals: [ITVInterval]?) {
        //do nothing, this wont be called for this vc
    }
    func didEdit(_ interval: ITVInterval) {
        //TODO: understand why the encoding is not called when updating the new values individualy and why we have to replace the timer with theNewTimer

        if let theTimerIndex = itvTimerIndex {
            if let theTimer = ITVUser.sharedInstance.thisTimers?[theTimerIndex] {
                if let theIntervalIndex = itvIntervalIndex {
                    //TODO: incomplete functionality, implement later -> modify this interval for this timer
                } else { //the timer had no intervals, fill its intervals with thie interval
                    let intervals: [ITVInterval] = [interval]
                    theTimer.intervals = intervals
                    ITVUser.sharedInstance.thisTimers?[theTimerIndex] = theTimer
                    isTimerEdited = true
                }
            } else {
                fatalError("------> ERROR TimerViewController didEdit(interval:) A timer is missing at the provided index \(theTimerIndex).")
            }
        } else {
            fatalError("------> ERROR TimerViewController didEdit(interval:) An index is needed. This timer's index should still be accessible at this point.")
        }
        
        loadTimer()
        loadWeather()
    }
    func didUpdateTimers() {
        loadTimer()
        loadWeather()
        collectionView.reloadData()
        isTimerEdited = true
    }
    func didEditASavedTimersInterval(){
    }
}
