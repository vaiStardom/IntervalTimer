//
//  IntervalTimerTimerTimeFunctions.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-30.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

//MARK: - Time functions
extension ITVTimer{
    //This is to show the progress of the entire timer
    func intervalQuotas() -> Dictionary<Int, Double>? {
        var intervalQuotas: Dictionary<Int, Double> = [:]
        
        if let theIntervals = thisIntervals, theIntervals.count > 0  {
            guard let theTotalSeconds = self.totalSeconds() else {
                return nil
            }
            
            for (index, interval) in theIntervals.enumerated() {
                intervalQuotas[index] = interval.thisSeconds!/theTotalSeconds
            }
            return intervalQuotas
        } else {
            return nil
        }
    }
    func totalTimeHMS() -> String {

        var timeLiteral = ""
        
        if let theIntervals = thisIntervals, theIntervals.count > 0  {
            var time = (0, 0, 0)
            var totalseconds = 0.0
            var hours: String?
            var minutes: String?
            var seconds: String?
            
            for interval in theIntervals {
                totalseconds += interval.thisSeconds!
            }
            
            if totalseconds == 0 {
                timeLiteral = "no intervals"
            }
            
            time = secondsToHoursMinutesSeconds(seconds : Int(totalseconds))
            
            if time.0 > 0 {
                hours = " \(time.0) h"
            }
            
            if time.1 > 0 {
                minutes = " \(time.1) m"
            }
            
            if time.2 > 0 {
                seconds = " \(time.2) s"
            }
            
            if hours != nil {
                timeLiteral += hours!
            }
            if minutes != nil {
                timeLiteral += minutes!
            }
            if seconds != nil {
                timeLiteral += seconds!
            }
        
        } else {
            timeLiteral = "no intervals"
        }
        
        return timeLiteral
    }
    func totalSeconds() -> Double? {
        if let theIntervals = thisIntervals, theIntervals.count > 0  {
            var totalSeconds = 0.0
            
            for interval in theIntervals {
                totalSeconds += interval.thisSeconds!
            }
            return totalSeconds
        } else {
            return nil
        }
    }
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
