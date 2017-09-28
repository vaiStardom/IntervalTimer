//
//  EditTimerViewControllerProtocols.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-26.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

extension EditTimerViewController: ITVEditIntervalProtocol {
    func didEdit(_ interval: ITVInterval) {
        if let theIntervalIndex = itvSelectedIntervalIndex { //user edited an existing interval
            intervals?[theIntervalIndex] = interval
        } else { //user added a new interval
            intervals?.append(interval)
        }
        isEditing = true
        didEditAnInterval = true
        configureNavBar()
        uniqueArrays(intervals: intervals!)
        tableView.reloadData()
        reloadQuickAddCollection()
    }
//    func didUpdateNew(_ intervals: [ITVInterval]?) {
//        if let theNewIntervals = intervals {
//            itvUnsavedTimersIntervals = theNewIntervals
//            self.intervals = theNewIntervals
//            uniqueArrays(intervals: theNewIntervals)
//            isEditing = true
//            configureNavBar()
//        }
//        tableView.reloadData()
//        
//        aesthetics_ShowTableView()
//    }
    

}
