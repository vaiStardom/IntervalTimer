//
//  EditTimerViewControllerItvIntervalsProtocol.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-12.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

extension EditTimerViewController: ITVIntervalsProtocol {
    func didUpdateIntervals(_ intervals:[ITVInterval]?) {
        if let theNewIntervals = intervals {
            itvUnsavedTimersIntervals = theNewIntervals
        }
        self.tableView.reloadData()
    }
}
