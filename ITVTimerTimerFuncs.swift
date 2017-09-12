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
    func totalTime() -> String {

        var timeLiteral = ""
        
        if let theIntervals = thisIntervals {
            var time = (0, 0, 0)
            var totalseconds = 0.0
            var hours: String?
            var minutes: String?
            var seconds: String?
            
            for interval in theIntervals {
                totalseconds += interval.thisSeconds!
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
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
