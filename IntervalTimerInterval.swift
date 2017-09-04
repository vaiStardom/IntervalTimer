//
//  IntervalTimerInterval.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-30.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

//MOCKDATA:
let intervals = [
    IntervalTimerInterval(seconds: 120, color: IntervalTimerColors.IntervalBlue)
    , IntervalTimerInterval(seconds: 30, color: IntervalTimerColors.IntervalYellow)
    , IntervalTimerInterval(seconds: 90, color: IntervalTimerColors.IntervalGreen)
    , IntervalTimerInterval(seconds: 30, color: IntervalTimerColors.IntervalYellow)
    , IntervalTimerInterval(seconds: 90, color: IntervalTimerColors.IntervalGreen)
    , IntervalTimerInterval(seconds: 30, color: IntervalTimerColors.IntervalYellow)
    , IntervalTimerInterval(seconds: 90, color: IntervalTimerColors.IntervalGreen)
    , IntervalTimerInterval(seconds: 30, color: IntervalTimerColors.IntervalYellow)
    , IntervalTimerInterval(seconds: 90, color: IntervalTimerColors.IntervalGreen)
    , IntervalTimerInterval(seconds: 30, color: IntervalTimerColors.IntervalYellow)
    , IntervalTimerInterval(seconds: 90, color: IntervalTimerColors.IntervalGreen)
    , IntervalTimerInterval(seconds: 30, color: IntervalTimerColors.IntervalYellow)
    , IntervalTimerInterval(seconds: 90, color: IntervalTimerColors.IntervalGreen)
    , IntervalTimerInterval(seconds: 30, color: IntervalTimerColors.IntervalYellow)
    , IntervalTimerInterval(seconds: 90, color: IntervalTimerColors.IntervalGreen)
    , IntervalTimerInterval(seconds: 30, color: IntervalTimerColors.IntervalYellow)
    , IntervalTimerInterval(seconds: 90, color: IntervalTimerColors.IntervalGreen)
    , IntervalTimerInterval(seconds: 120, color: IntervalTimerColors.IntervalBlue)
]
let intervalsHours = [
    IntervalTimerInterval(seconds: 120000, color: IntervalTimerColors.IntervalBlue)
    , IntervalTimerInterval(seconds: 30000, color: IntervalTimerColors.IntervalYellow)
    , IntervalTimerInterval(seconds: 90000, color: IntervalTimerColors.IntervalGreen)
    , IntervalTimerInterval(seconds: 30000, color: IntervalTimerColors.IntervalYellow)
    , IntervalTimerInterval(seconds: 90000, color: IntervalTimerColors.IntervalGreen)
    , IntervalTimerInterval(seconds: 30, color: IntervalTimerColors.IntervalYellow)
    , IntervalTimerInterval(seconds: 90, color: IntervalTimerColors.IntervalGreen)
    , IntervalTimerInterval(seconds: 30, color: IntervalTimerColors.IntervalYellow)
    , IntervalTimerInterval(seconds: 90, color: IntervalTimerColors.IntervalGreen)
    , IntervalTimerInterval(seconds: 30, color: IntervalTimerColors.IntervalYellow)
    , IntervalTimerInterval(seconds: 90, color: IntervalTimerColors.IntervalGreen)
    , IntervalTimerInterval(seconds: 30, color: IntervalTimerColors.IntervalYellow)
    , IntervalTimerInterval(seconds: 90000, color: IntervalTimerColors.IntervalGreen)
    , IntervalTimerInterval(seconds: 30000, color: IntervalTimerColors.IntervalYellow)
    , IntervalTimerInterval(seconds: 90, color: IntervalTimerColors.IntervalGreen)
    , IntervalTimerInterval(seconds: 30, color: IntervalTimerColors.IntervalYellow)
    , IntervalTimerInterval(seconds: 90000, color: IntervalTimerColors.IntervalGreen)
    , IntervalTimerInterval(seconds: 120000, color: IntervalTimerColors.IntervalBlue)
]
let intervalsSeconds = [
    IntervalTimerInterval(seconds: 3, color: IntervalTimerColors.IntervalYellow)
    , IntervalTimerInterval(seconds: 9, color: IntervalTimerColors.IntervalGreen)
    , IntervalTimerInterval(seconds: 3, color: IntervalTimerColors.IntervalYellow)
    , IntervalTimerInterval(seconds: 9, color: IntervalTimerColors.IntervalGreen)
    , IntervalTimerInterval(seconds: 3, color: IntervalTimerColors.IntervalYellow)
    , IntervalTimerInterval(seconds: 9, color: IntervalTimerColors.IntervalGreen)
    , IntervalTimerInterval(seconds: 3, color: IntervalTimerColors.IntervalYellow)
]

public struct IntervalTimerInterval {
    
    // MARK: - Properties
    private var seconds: Double?
    private var color: UIColor?
    
    //MARK: - public get/set properties
    public var thisSeconds: Double? {
        get { return seconds}
        set {
            seconds = newValue
        }
    }
    public var thisColor: UIColor? {
        get { return color}
        set {
            color = newValue
        }
    }
    
    // MARK: - Initializers
    public init(seconds: Double?, color: UIColor?) {
        guard let theSeconds = seconds, theSeconds > 0 else {
            return
        }
        guard let theColor = color else {
            return
        }
        thisSeconds = theSeconds
        thisColor = theColor
    }
}
