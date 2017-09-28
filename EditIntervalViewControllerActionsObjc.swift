//
//  EditIntervalViewControllerActionsObjc.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-27.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Actions
@objc extension EditIntervalViewController {
    func cancel(){
        _ = navigationController?.popViewController(animated: true)
    }
    func save(){
        if self.editIntervalProtocolDelegate != nil {
            if totalSeconds() > 0 {
                let theIndicator = indicator
                let theNewInterval = ITVInterval(seconds: totalSeconds(), indicator: theIndicator)
                self.editIntervalProtocolDelegate?.didEdit(theNewInterval)
            } else {
                //TODO: Warn user the he must enter numbers to create a valid interval
            }
        }
        _ = navigationController?.popViewController(animated: true)
    }

//    func save(){
//        if self.updateIntervalsProtocolDelegate != nil {
//            if totalSeconds() > 0 {
//                let theIndicator = indicator
//
//                //TODO: understand why the encoding is not called when updating the new values individualy and why we have to replace the timer with theNewTimer
//                let theNewInterval = ITVInterval(seconds: totalSeconds(), indicator: theIndicator)
//
//                if let theTimerIndex = itvTimerIndex, ITVUser.sharedInstance.thisTimers?[theTimerIndex] != nil {
//                    if let theIntervalIndex = itvIntervalIndex, ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisIntervals?[theIntervalIndex] != nil { //user was editing an interval inside a saved timer
//
////                        ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisIntervals?[theIntervalIndex] = theNewInterval
////                        self.updateIntervalsProtocolDelegate?.didEditASavedTimersInterval()
//                        self.updateIntervalsProtocolDelegate?.didEdit(theNewInterval)
//                    } else { //user is adding a new interval to a saved timer
////                        if ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisIntervals == nil {
////                            ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisIntervals = []
////                        }
////                        ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisIntervals?.append(theNewInterval)
////                        self.updateIntervalsProtocolDelegate?.didEditASavedTimersInterval()
//                        self.updateIntervalsProtocolDelegate?.didEdit(theNewInterval)
//                    }
//                } else { //this interval is for an unsaved timer
//                    if let theIntervalIndex = itvIntervalIndex, itvUnsavedTimersIntervals?[theIntervalIndex] != nil {
//                        //user is editing an interval of an unsaved timer
//                        itvUnsavedTimersIntervals?[theIntervalIndex] = theNewInterval
//                        self.updateIntervalsProtocolDelegate?.didUpdateNew(itvUnsavedTimersIntervals)
//                    } else {
//                        if itvUnsavedTimersIntervals == nil {
//                            itvUnsavedTimersIntervals = []
//                        }
//                        itvUnsavedTimersIntervals?.append(theNewInterval)
//                        self.updateIntervalsProtocolDelegate?.didUpdateNew(itvUnsavedTimersIntervals)
//                    }
//                }
//            } else {
//                //TODO: Warn user the he must enter numbers to create a valid interval
//            }
//        }
//        _ = navigationController?.popViewController(animated: true)
//    }
}

