//
//  EditTimerViewControllerItvIntervalsProtocol.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-12.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

extension EditTimerViewController_old: ITVEditIntervalProtocol {
    func didUpdateNew(_ intervals: [ITVInterval]?) {
        if let theNewIntervals = intervals {
            itvUnsavedTimersIntervals = theNewIntervals
            isEditing = true
            configureNavBar()
        }
        tableView.reloadData()
        aesthetics_ShowTableView()

    }
    
    func didEdit(_ interval: ITVInterval) {
        isEditing = true
        configureNavBar()
        tableView.reloadData()

    }
}
