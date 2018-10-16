//
//  EditTimerViewControllerProtocols.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-26.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

//TODO: + Swipe to delete on top cell deletes entire timer
extension EditTimerViewController: ITVEditIntervalProtocol, ITVSwipeToDeleteIntervalProtocol {
    
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
    //MARK: - ITVSwipeToDeleteIntervalProtocol
    func delete(index: Int?) {
        
        guard let theIntervalIndex = index else {
            return
        }
        
        intervals?.remove(at: theIntervalIndex)
        
        tableView.beginUpdates()
        let rowIndex = theIntervalIndex + tableViewIntervalIndexOffset
        let indexPathForRow = IndexPath(row: rowIndex, section: 0)
//        print("------> EditTimerViewController deleteTimer(atIndex:) indexPathForRow = \(indexPathForRow), count = \(indexPathForRow.count)")
        tableView.deleteRows(at: [indexPathForRow], with: .left)
        tableView.endUpdates()
        
        tableView.reloadData() //this regenerates te indexes for the rows and intervals to delete
        
        isEditing = true
//        didEditAnInterval = true
        configureNavBar()

    }
}
