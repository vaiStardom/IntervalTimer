//
//  EditIntervalViewControllerHelpers.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-09.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

extension EditIntervalViewController {
    func compareFieldsWithPassedInterval(){
        
        if let thePassedInterval = itvIntervalToEdit {
            setIfIsEdetingInterval(thePassedInterval)
        } else {
            isEditingAnInterval = isTotalSecondsDifferent(nil)
        }
        configureNavBar()
    }

    func setIfIsEdetingInterval(_ interval: ITVInterval){
        if isTotalSecondsDifferent(interval) || interval.thisIndicator != indicator {
            isEditingAnInterval = true
        } else {
            isEditingAnInterval = false
        }
    }
    
    func isTotalSecondsDifferent(_ interval: ITVInterval?) -> Bool {
        if let theInterval = interval {
            if totalSeconds() != theInterval.thisSeconds || indicator != theInterval.thisIndicator {
                return true
            } else {
                return false
            }
        } else {
            if totalSeconds() > 0 {
                return true
            } else {
                return false
            }
        }
    }
    
    func totalSeconds() -> Double {
        
        let hours2 = String(returnNumber(in: hourTextField2))
        let hours1 = String(returnNumber(in: hourTextField1))
        let secondsFromHours = TimeType.Hours.toSeconds(from: Int(hours2 + hours1))
        
        let minutes2 = String(returnNumber(in: minuteTextField2))
        let minutes1 = String(returnNumber(in: minuteTextField1))
        let secondsFromMinutes = TimeType.Minutes.toSeconds(from: Int(minutes2 + minutes1))
        
        let seconds2 = String(returnNumber(in: secondTextField2))
        let seconds1 = String(returnNumber(in: secondTextField1))
        let secondsFromSeconds = TimeType.Seconds.toSeconds(from: Int(seconds2 + seconds1))
        
        return secondsFromHours + secondsFromMinutes + secondsFromSeconds
    }
    
    func returnNumber(in textField: UITextField) -> Int {
        if let contents = textField.text {
            if !contents.isEmpty && contents != zeroWidthSpace && contents.containsOnlyCharactersIn(matchCharacter: allowedChars) {
                return Int(contents)!
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
    func setViewValues(with interval: ITVInterval){
        let hours = HOURS_OF(seconds: interval.thisSeconds!)
        let minutes = MINUTES_OF(seconds: interval.thisSeconds!)
        let seconds = SECONDS_OF(seconds: interval.thisSeconds!)
        
        hourTextField2.text = hours.isEmpty ? Litterals.EmptyString : String(describing: hours.first!)
        hourTextField1.text = hours.isEmpty ? Litterals.EmptyString : String(describing: hours.last!)
        minuteTextField2.text = minutes.isEmpty ? Litterals.EmptyString : String(describing: minutes.first!)
        minuteTextField1.text = minutes.isEmpty ? Litterals.EmptyString : String(describing: minutes.last!)
        secondTextField2.text = seconds.isEmpty ? Litterals.EmptyString : String(describing: seconds.first!)
        secondTextField1.text = seconds.isEmpty ? Litterals.EmptyString : String(describing: seconds.last!)
        
        aesthetics_manageSelectedColorIndicator(indicatorIndex: interval.thisIndicator.rawValue)
    }
}
