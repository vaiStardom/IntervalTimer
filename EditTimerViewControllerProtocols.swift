//
//  EditTimerViewControllerProtocols.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-26.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

extension EditTimerViewController: ITVUpdateIntervalsProtocol {
    func didUpdateIntervals(_ updatedIntervals:[ITVInterval]?) {
        if let theNewIntervals = updatedIntervals {
            itvUnsavedTimersIntervals = theNewIntervals
            intervals = theNewIntervals
            uniqueArrays(intervals: theNewIntervals)
            isEditing = true
            configureNavBar()
        }
        tableView.reloadData()
        
        aesthetics_ShowTableView()
    }
    func didEditASavedTimersInterval(){
        if let theTimerIndex = itvTimerIndex {
            if let theIntervals = ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisIntervals {
                intervals = theIntervals
                uniqueArrays(intervals: theIntervals)
            }
        }
        isEditing = true
        configureNavBar()
        tableView.reloadData()
    }
}
