//
//  EditTimerViewControllerActions.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-22.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

@objc extension EditTimerViewController {
    
    func back(){
//        print("------> EditTimerViewController back()")
        _ = navigationController?.popViewController(animated: true)
    }
    func cancel(){
        _ = navigationController?.popViewController(animated: true)
    }
    func save(){
        print("------> EditTimerViewController save()")
        
        if let theTimerName = topCell().timerNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !theTimerName.isEmpty  {
            let theTemperatureUnit = getTemperatureUnit(from: topCell().temperatureSegmentedControl)
            let theShowWeather = topCell().showWeatherSwitch.isOn

            if let theTimerIndex = itvTimerIndex, ITVUser.sharedInstance.thisTimers?[theTimerIndex] != nil {
                //this was a selected timer

                //TODO: understand why the encoding is not called when updating the new values individualy and why we have to replace the timer with theNewTimer
                let thisTimersIntervals = ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisIntervals
                let theNewTimer = ITVTimer(name: theTimerName, showWeather: theShowWeather, temperatureUnit: theTemperatureUnit, intervals: thisTimersIntervals)
                ITVUser.sharedInstance.thisTimers?[theTimerIndex] = theNewTimer

            } else {
                //this is a new timer
                if let theNewTimersIntervals = itvUnsavedTimersIntervals {
                    let theNewTimer = ITVTimer(name: theTimerName, showWeather: theShowWeather, temperatureUnit: theTemperatureUnit, intervals: theNewTimersIntervals)
                    ITVUser.sharedInstance.thisTimers?.append(theNewTimer)
                } else {
                    let theNewTimer = ITVTimer(name: theTimerName, showWeather: theShowWeather, temperatureUnit: theTemperatureUnit, intervals: nil)
                    ITVUser.sharedInstance.thisTimers?.append(theNewTimer)
                }
            }

            if self.updateTimersProtocolDelegate != nil {
                self.updateTimersProtocolDelegate?.didUpdateTimers()
            }

            _ = navigationController?.popViewController(animated: true)

        } else {
            //TODO: Alert user that he must name the timer.
            ITVWarningForUser.sharedInstance.thisUserWarning = UserWarning.MissingTimerName
            SHOW_USER_WARNING(type: ITVWarningForUser.sharedInstance.thisUserWarning)
        }
    }
    func deleteTimer(){
        print("------> Delete Timer")
    }
    func addThisInterval(_ theButton: UIButton){
        
        intervals?.append(uniqueTimers[theButton.tag].0)
        
        let rowNumber = (intervals?.count)! + 2
        let indexPathForRow = IndexPath(row: rowNumber, section: 0)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({ () -> Void in
            // This block runs after the animations between CATransaction.begin
            // and CATransaction.commit are finished.
            self.scrollToBottom()
        })
        
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPathForRow], with: .automatic)
        tableView.endUpdates()
        
        CATransaction.commit()
        
        print("------> Add this interval: \(String(describing: uniqueTimers[theButton.tag].0.thisSeconds))")
    }
    
    func scrollToBottom(){
        
        let bottomRow = tableView.numberOfRows(inSection: 0) - 1
        let bottomMessageIndex = IndexPath(row: bottomRow, section: 0)
        
        guard (intervals?.count)! > 0 else {
            return
        }
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({ () -> Void in
            // Now we can scroll to the last row!
            self.tableView.scrollToRow(at: bottomMessageIndex, at: .bottom, animated: true)
        })
        
        // scroll down by 1 point: this causes the newly added cell to be dequeued and rendered.
        let contentOffset = self.tableView.contentOffset.y
        
        let newContentOffset = CGPoint(x: 0, y: contentOffset + 1)
        self.tableView.setContentOffset(newContentOffset, animated: true)
        
        CATransaction.commit()
    }
    
    func editIntervals(){
        print("------> Edit intervals")
    }
    
    func addInterval(){
        itvIntervalIndex = nil
        performSegue(withIdentifier: "EditTimerToEditInterval", sender: nil)
    }
    
    func switched(_ theSwitch: UISwitch){
        if theSwitch.isOn {
            registerNotifications() //will register at first weather use
            aesthetics_startLoadingWeather()
            showWeather()
        } else {
            //TODO: if switched OFF and weather has not finished loading, then cancel weather loading (cancel network calls)
            activityIndicatorStop()
            aesthetics_hideWeatherViews()
            aesthetics_showWeatherDescription()
        }
        didUserModifyATimer()

        if theSwitch.isOn {
            print("------> Switched on")
        } else {
            print("------> Switched off")
        }
    }
    
    func showWarning(){
        print("------> Show weather warning button tapped")
    }
    
}
