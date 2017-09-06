//
//  IntervalTimerTimerTimeFunctions.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-30.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

//MARK: - Time functions
extension IntervalTimerTimer{
    func totalTime() -> String {

        var time = (0, 0, 0)
        var totalseconds = 0.0
        var timeLiteral = ""
        var hours: String?
        var minutes: String?
        var seconds: String?
        
        for interval in thisIntervals! {
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
        
        return timeLiteral
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
