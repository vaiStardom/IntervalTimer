//
//  EditIntervalViewControllerActions.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-20.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

//MARK: - Actions
extension EditIntervalViewController {
    @IBAction func redIndicator(_ sender: Any) {
        aesthetics_manageSelectedColorIndicator(indicatorIndex: 0)
    }
    @IBAction func greenIndicator(_ sender: Any) {
        aesthetics_manageSelectedColorIndicator(indicatorIndex: 1)
    }
    @IBAction func orangeIndicator(_ sender: Any) {
        aesthetics_manageSelectedColorIndicator(indicatorIndex: 2)
    }
    @IBAction func blueIndicator(_ sender: Any) {
        aesthetics_manageSelectedColorIndicator(indicatorIndex: 3)
    }
    @IBAction func yellowIndicator(_ sender: Any) {
        aesthetics_manageSelectedColorIndicator(indicatorIndex: 4)
    }
    @IBAction func purpleIndicator(_ sender: Any) {
        aesthetics_manageSelectedColorIndicator(indicatorIndex: 5)
    }
    func back(){
        _ = navigationController?.popViewController(animated: true)
    }
    func save(){
        
        if self.itvIntervalsProtocolDelegate != nil {
            if totalSeconds() > 0 {
                let theIndicator = indicator
                
                if let theTimerIndex = itvTimerIndex, ITVUser.sharedInstance.thisTimers?[theTimerIndex] != nil {
                    if let theIntervalIndex = itvIntervalIndex, ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisIntervals?[theIntervalIndex] != nil { //user was editing an interval inside a saved timer
                        ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisIntervals?[theIntervalIndex].thisSeconds = totalSeconds()
                        ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisIntervals?[theIntervalIndex].thisIndicator = theIndicator
                        self.itvIntervalsProtocolDelegate?.didUpdateIntervals(nil)
                    } else { //user is adding a new interval to a saved timer
                        let newInterval = ITVInterval(seconds: totalSeconds(), indicator: indicator)
                        ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisIntervals?.append(newInterval)
                        self.itvIntervalsProtocolDelegate?.didUpdateIntervals(nil)
                    }
                } else { //this interval is for an unsaved timer
                    if let theIntervalIndex = itvIntervalIndex, itvUnsavedTimersIntervals?[theIntervalIndex] != nil {
                        //user is editing an interval of an unsaved timer
                        itvUnsavedTimersIntervals?[theIntervalIndex].thisSeconds = totalSeconds()
                        itvUnsavedTimersIntervals?[theIntervalIndex].thisIndicator = theIndicator
                        self.itvIntervalsProtocolDelegate?.didUpdateIntervals(itvUnsavedTimersIntervals)
                    } else {
                        let newInterval = ITVInterval(seconds: totalSeconds(), indicator: indicator)
                        itvUnsavedTimersIntervals?.append(newInterval)
                    }
                }
            } else {
                //TODO: Warn user the he must enter numbers to create a valid interval
            }
        }
        _ = navigationController?.popViewController(animated: true)
    }
    func cancel(){
        _ = navigationController?.popViewController(animated: true)
    }
}
