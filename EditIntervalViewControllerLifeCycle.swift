//
//  EditIntervalViewControllerLifeCycle.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-30.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

//MARK: Life-cycle
extension EditIntervalViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        
//        secondTextField1.becomeFirstResponder()
        
        hourTextField2.delegate = self
        hourTextField1.delegate = self
        minuteTextField2.delegate = self
        minuteTextField1.delegate = self
        secondTextField2.delegate = self
        secondTextField1.delegate = self
        
        hourTextField2.clearsOnBeginEditing = true
        
        dictTextFieldValues = [
            0:zeroWidthSpace,
            1:zeroWidthSpace,
            2:zeroWidthSpace,
            3:zeroWidthSpace,
            4:zeroWidthSpace,
            5:zeroWidthSpace]

        textFields.append(hourTextField2)
        textFields.append(hourTextField1)
        textFields.append(minuteTextField2)
        textFields.append(minuteTextField1)
        textFields.append(secondTextField2)
        textFields.append(secondTextField1)
        
        aesthetics_initial()
        
        if let theTimerIndex = itvTimerIndex, ITVUser.sharedInstance.thisTimers?[theTimerIndex] != nil {
            if let theIntervalIndex = itvIntervalIndex, ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisIntervals?[theIntervalIndex] != nil { //user is editing an interval inside a saved timer
                if let theInterval = ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisIntervals?[theIntervalIndex] {
                    setViewValues(with: theInterval)
                }
            } else { //user is adding an interval to a saved timer
                aesthetics_unselectAllIndicators()
            }
        } else { //this interval is for an unsaved timer
            if let theIntervalIndex = itvIntervalIndex, itvUnsavedTimersIntervals?[theIntervalIndex] != nil {
                if let theInterval = itvUnsavedTimersIntervals?[theIntervalIndex] { //user is editing an interval of an unsaved timer
                    setViewValues(with: theInterval)
                } else {
                    aesthetics_unselectAllIndicators()
                }
            } else { //user is adding an interval to an unsaved timer
                aesthetics_unselectAllIndicators()
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        secondTextField1.becomeFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
