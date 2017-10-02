//
//  EditTimerViewControllerHelpers.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-23.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

extension EditTimerViewController {
    func didUserModifyTimerTopCell(){
        
        if let theTopCell = topCell() {
            timerName = theTopCell.timerNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            temperatureUnit = getTemperatureUnit(from: theTopCell.temperatureSegmentedControl)
            isShowWeather = theTopCell.showWeatherSwitch.isOn
            
            print("------> EditTimerViewController didUserModifyATimer() theTimerName = \(timerName)")
            
            //First, is this a selected timer?
            if let theTimerIndex = itvTimerIndex, ITVUser.sharedInstance.thisTimers?[theTimerIndex] != nil {
                if let theItvTimer = ITVUser.sharedInstance.thisTimers?[theTimerIndex] {
                    if timerName! != theItvTimer.thisName!
                        || temperatureUnit != theItvTimer.thisTemperatureUnit
                        || isShowWeather != theItvTimer.thisShowWeather {
                        isEditing = true
                    } else {
                        isEditing = false
                    }
                }
            } else {
                if (!timerName!.isEmpty){
                    isEditing = true
                } else {
                    isEditing = false
                }
            }
            configureNavBar()
        }
    }
    
    func getTemperatureUnit(from: UISegmentedControl) -> TemperatureUnit {
        switch from.selectedSegmentIndex {
        case 0 :
            return TemperatureUnit.Kelvin
        case 1 :
            return TemperatureUnit.Fahrenheit
        case 2 :
            return TemperatureUnit.Celcius
        default:
            return TemperatureUnit.Celcius
        }
    }
    func uniqueArrays(intervals: [ITVInterval]) {
        uniqueTimers = []
        for interval in intervals {
            
            let hasThisIntervalBeenFiltered = uniqueTimers.filter({ $0.0.thisSeconds == interval.thisSeconds && $0.0.thisIndicator == interval.thisIndicator })
            
            if hasThisIntervalBeenFiltered.count == 0 {
                let theFilteredArray = intervals.filter({ $0.thisSeconds == interval.thisSeconds && $0.thisIndicator == interval.thisIndicator })
                if theFilteredArray.count > 0 {
                    uniqueTimers.append((interval, theFilteredArray.count))
                    print("Added interval seconds \(interval.thisSeconds) type \(interval.thisIndicator) appearing \(theFilteredArray.count) times")
                }
            }
        }
        if uniqueTimers.count > 0 {
            uniqueTimers = uniqueTimers.sorted(by: {$1.1 < $0.1})
        }
    }
    func dataSourceCount() -> Int {
        if let theDataSourceCount = intervals?.count {
            return theDataSourceCount
        } else{
            return 0
        }
    }
    func getAllRowCount() -> Int{
        var rowCount = 0
        for index in 0...self.tableView.numberOfSections-1{
            rowCount += self.tableView.numberOfRows(inSection: index)
        }
        return rowCount
    }

    func heightQuickAddSections() -> Double {
        if let theIntervals = intervals {
            if theIntervals.count > 1 {
                return 79.0 * 2.0
            } else {
                return 79.0
            }
        } else {
            return 79.0
        }
    }

    func heightIntervalsSection() -> Double {
        if let theIntervals = intervals {
            return Double(theIntervals.count) * 79.0
        } else {
            return 0.0
        }
    }
    func scrollToBottom(){
        
        let bottomRow = tableView.numberOfRows(inSection: 0) - 1
        let bottomIndex = IndexPath(row: bottomRow, section: 0)
        
        guard (intervals?.count)! > 0 else {
            return
        }
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({ () -> Void in
            // Now we can scroll to the last row!
            self.tableView.scrollToRow(at: bottomIndex, at: .bottom, animated: true)
        })
        
        // scroll down by 1 point: this causes the newly added cell to be dequeued and rendered.
        let contentOffset = self.tableView.contentOffset.y
        
        let newContentOffset = CGPoint(x: 0, y: contentOffset + 1)
        self.tableView.setContentOffset(newContentOffset, animated: true)
        
        CATransaction.commit()
    }
    func scrollToTop(){

        let topRow = 0
        let topIndex = IndexPath(row: topRow, section: 0)

        CATransaction.begin()
        CATransaction.setCompletionBlock({ () -> Void in
            // Now we can scroll to the last row!
            print("------> EditTimerViewController animation scroll to top start")
            self.tableView.scrollToRow(at: topIndex, at: .top, animated: true)
        })
        print("------> EditTimerViewController animation scroll to top end")

        CATransaction.commit()
    }
    func isTableViewTallerThanDeleteButton() -> Bool {
        //personal hotspot bar + nav bar + topcell + quick add + intervals
        let heightOfTableView = 88.0 + 171.0 + heightQuickAddSections() + heightIntervalsSection()
        let screenSize = UIScreen.main.bounds
        let deleteButtonYPosition = Double(screenSize.height) - 47.0
        
        if heightOfTableView >= deleteButtonYPosition {
            return true
        } else {
            return false
        }
    }
    func isScrollEnabled(){
        
        if isTableViewTallerThanDeleteButton() {
            tableView.isScrollEnabled = true
            deleteLabel.isHidden = true
            deleteButton.isHidden = true
            deleteButton.isEnabled = false
        } else {
            tableView.isScrollEnabled = false
            deleteLabel.isHidden = false
            deleteButton.isHidden = false
            deleteButton.isEnabled = true
        }
    }
}
