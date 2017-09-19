//
//  TimersViewControllerItvSwipeToDeleteTimerProtocol.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-19.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

extension TimersViewController: ITVSwipeToDeleteTimerProtocol {
    func delete(timer: ITVTimer?) {

        guard let theTimer = timer else {
            return
        }

        guard let theTimersNsArray = ITVUser.sharedInstance.thisTimers as NSArray? else {
            return
        }
        
        let timerIndex = theTimersNsArray.index(of: theTimer)
        
        ITVUser.sharedInstance.thisTimers?.remove(at: timerIndex)
        
        tableView.beginUpdates()
        let indexPathForRow = IndexPath(row: timerIndex, section: 0)
        print("------> TimersViewController deleteTimer(atIndex:) indexPathForRow = \(indexPathForRow), count = \(indexPathForRow.count)")
        tableView.deleteRows(at: [indexPathForRow], with: .left)
        tableView.endUpdates()
    }
}
