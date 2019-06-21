//
//  Timer.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2019-06-21.
//  Copyright © 2019 Paul Addy. All rights reserved.
//

import Foundation

struct Timer {
    
    let name: String
    let intervals: [Interval]
    
    struct Interval {
    
        let seconds: Double
        let indicator: Indicator
        
        struct Indicator {
            
        }
    }
    
}
