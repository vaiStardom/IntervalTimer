//
//  EditTimerViewControllerTableView.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-10.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

//TODO: find a cute way of showing the percentage of completness of a timer's total interval times
//MARK: - Table View Management
extension EditTimerViewController_old : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let theTimerIndex = itvTimerIndex, ITVUser.sharedInstance.thisTimers?[theTimerIndex] != nil {
            if let theCount = ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisIntervals?.count {
                return theCount
            } else {
                return 0
            }
        } else if let theUnsavedIntervals = itvUnsavedTimersIntervals {
            if theUnsavedIntervals.count > 0 {
                return theUnsavedIntervals.count
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IntervalCell") as! IntervalTableViewCell
        let index = (indexPath as NSIndexPath).row
        
        if let theTimerIndex = itvTimerIndex {
            if let theTimer = ITVUser.sharedInstance.thisTimers?[theTimerIndex] {
                if let theInterval = theTimer.thisIntervals?[index] {
                    
                    cell.indicatorImageView.backgroundColor = theInterval.thisIndicator.uiColor()
                    cell.indicatorImageView.layer.borderColor = theInterval.thisIndicator.uiColor().cgColor
                    cell.indicatorImageView.roundImageView()
                    cell.intervalNumberLabel.text = "\(index + 1)"
                    if let theSeconds = theInterval.thisSeconds {
                        cell.intervalTimeLabel.text = TIME_OF_00(seconds: theSeconds)
                        print("------> EditTimerViewController cellForRowAt timer = \(TIME_OF_00(seconds: theSeconds)), indicator = \(theInterval.thisIndicator.rawValue), color = \(theInterval.thisIndicator.uiColor())")

                    } else {
                        cell.intervalTimeLabel.text = "0"
                    }
                }
            }
        } else if let theUnsavedIntervals = itvUnsavedTimersIntervals {
            let theUnsavedInterval = theUnsavedIntervals[index]
            cell.indicatorImageView.backgroundColor = theUnsavedInterval.thisIndicator.uiColor()
            cell.indicatorImageView.layer.borderColor = theUnsavedInterval.thisIndicator.uiColor().cgColor
            cell.indicatorImageView.roundImageView()
            cell.intervalNumberLabel.text = "\(index + 1)"
            if let theSeconds = theUnsavedInterval.thisSeconds {
                cell.intervalTimeLabel.text = TIME_OF_00(seconds: theSeconds)
            } else {
                cell.intervalTimeLabel.text = "0"
            }
        }
        return cell
    }
}
