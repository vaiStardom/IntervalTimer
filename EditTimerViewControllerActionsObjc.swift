//
//  EditTimerViewControllerActions.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-22.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

@objc extension EditTimerViewController {
    
    func selectedTemperatureUnit() {
        if let theTopCell = topCell() {
            let temperature = getTemperatureUnit(from: theTopCell.temperatureSegmentedControl).temperature(kelvins: ITVUser.sharedInstance.thisCurrentWeather?.thisKelvin)
            theTopCell.weatherTemperatureLabel.text = temperature
            didUserModifyTimerTopCell()
        }
    }
    
    func cancel(){
        dismiss(animated: true, completion: nil)
    }
    func save(){
        print("------> EditTimerViewController save()")
        
        if let theTopCell = topCell() {
            timerName = theTopCell.timerNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            isShowWeather = theTopCell.showWeatherSwitch.isOn
            temperatureUnit = getTemperatureUnit(from: theTopCell.temperatureSegmentedControl)
        }
        
        guard let theTimerName = timerName?.trimmingCharacters(in: .whitespacesAndNewlines), !theTimerName.isEmpty else {
            ITVWarningForUser.sharedInstance.thisUserWarning = UserWarning.MissingTimerName
            SHOW_USER_WARNING(type: ITVWarningForUser.sharedInstance.thisUserWarning)
            return
        }
        
        if let theTimerIndex = itvTimerIndex, ITVUser.sharedInstance.thisTimers?[theTimerIndex] != nil { //this was a selected timer
            
            //TODO: understand why the encoding is not called when updating the new values individualy and why we have to replace the timer with theNewTimer
            let theNewTimer = ITVTimer(name: theTimerName, showWeather: isShowWeather, temperatureUnit: temperatureUnit, intervals: intervals)
            ITVUser.sharedInstance.thisTimers?[theTimerIndex] = theNewTimer
            
        } else {
            //this is a new timer
            let theNewTimer = ITVTimer(name: theTimerName, showWeather: isShowWeather, temperatureUnit: temperatureUnit, intervals: intervals)
            ITVUser.sharedInstance.thisTimers?.append(theNewTimer)
        }
        
        if self.updateTimersProtocolDelegate != nil {
            self.updateTimersProtocolDelegate?.didUpdateTimers()
        }
        
        dismiss(animated: true, completion: nil)
    }
    func deleteTimer(){
        print("------> Delete Timer")
        //TODO: warning to ask for confirmation for deleting the timer
        
        guard let theTimerIndex = itvTimerIndex, ITVUser.sharedInstance.thisTimers?[theTimerIndex] != nil else {
            return
        }
        
        ITVUser.sharedInstance.thisTimers?.remove(at: theTimerIndex)
        
        dismiss(animated: true, completion: nil)
    }
    
    func addThisInterval(_ theButton: UIButton){
        
        print("------> EditTimerViewController addThisInterval(theButton:) intervals.count BEFORE = \(intervals?.count)")
        print("------> EditTimerViewController addThisInterval(theButton:) tableView.rows.count BEFORE = \(getAllRowCount())")
        guard var theNewIntervals = intervals  else {
            return
        }
        
        theNewIntervals.append(uniqueTimers[theButton.tag].0)
        intervals = []
        intervals = theNewIntervals
        
        print("------> EditTimerViewController addThisInterval(theButton:) intervals.count AFTER = \(intervals?.count)")
        //        if itvUnsavedTimersIntervals == nil {
        //            itvUnsavedTimersIntervals = []
        //        }
        //        itvUnsavedTimersIntervals = intervals
        
        let newRowIndex = (intervals?.count)! + 1
        let indexPathNewForRow = IndexPath(row: newRowIndex, section: 0)
        
        print("------> EditTimerViewController addThisInterval(theButton:) newRowIndex = \(newRowIndex)")
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({ () -> Void in
            // This block runs after the animations between CATransaction.begin
            // and CATransaction.commit are finished.
            
            self.tableView.scrollToBottom()
        })
        
        tableView.reloadData()
        
        print("------> EditTimerViewController addThisInterval(theButton:) tableView.rows.count AFTER = \(self.getAllRowCount())")
        
        self.isScrollEnabled()
        
        CATransaction.commit()
        
        self.isEditing = true
        self.configureNavBar()
    }
    
    func editIntervals(){
        
        self.isEditing = !self.isEditing
        
        if self.isEditing { //user wants to edit
            if let theFirstAddIntervalsCell = firstAddIntervalsCell() {
                theFirstAddIntervalsCell.editLabel.text = "Save"
            }
            if let theSecondAddIntervalsCell = secondAddIntervalsCell() {
                theSecondAddIntervalsCell.editLabel.text = "Save"
            }
            tableView.isEditing = self.isEditing
        } else { //user wants to save his edits
            if let theFirstAddIntervalsCell = firstAddIntervalsCell() {
                theFirstAddIntervalsCell.editLabel.text = "Edit"
            }
            if let theSecondAddIntervalsCell = secondAddIntervalsCell() {
                theSecondAddIntervalsCell.editLabel.text = "Edit"
            }
            tableView.isEditing = self.isEditing
            
            //scroll to top and reload table
            CATransaction.begin()
            CATransaction.setCompletionBlock({ () -> Void in
                // This block runs after the animations between CATransaction.begin
                // and CATransaction.commit are finished.
                
                self.tableView.scrollToTop()
            })
            
            tableView.reloadData()
            
            print("------> EditTimerViewController addThisInterval(theButton:) tableView.rows.count AFTER = \(self.getAllRowCount())")
            
            self.isScrollEnabled()
            
            CATransaction.commit()

        }
        
        
        configureNavBar()
    }
    
    func addInterval(){
        itvSelectedIntervalIndex = nil
        performSegue(withIdentifier: "EditTimerToEditInterval", sender: nil)
    }
    
    func showWeatherSwitched(_ theSwitch: UISwitch){
        if theSwitch.isOn {
            aesthetics_startLoadingWeather()
            showWeather()
        } else {
            //TODO: if switched OFF and weather has not finished loading, then cancel weather loading (cancel network calls)
            activityIndicatorStop()
            aesthetics_hideWeatherViews()
            aesthetics_showWeatherDescription()
        }
        didUserModifyTimerTopCell()
        
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
