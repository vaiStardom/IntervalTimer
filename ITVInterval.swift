//
//  ITVInterval.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-30.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

////MOCKDATA:
////MOCKDATA:
//let intervals = [
//    ITVInterval(seconds: 120, indicator: Indicator.Blue)
//    , ITVInterval(seconds: 30, indicator: Indicator.Yellow)
//    , ITVInterval(seconds: 90, indicator: Indicator.Green)
//    , ITVInterval(seconds: 30, indicator: Indicator.Yellow)
//    , ITVInterval(seconds: 90, indicator: Indicator.Green)
//    , ITVInterval(seconds: 30, indicator: Indicator.Yellow)
//    , ITVInterval(seconds: 90, indicator: Indicator.Green)
//    , ITVInterval(seconds: 30, indicator: Indicator.Yellow)
//    , ITVInterval(seconds: 90, indicator: Indicator.Green)
//    , ITVInterval(seconds: 30, indicator: Indicator.Yellow)
//    , ITVInterval(seconds: 90, indicator: Indicator.Green)
//    , ITVInterval(seconds: 30, indicator: Indicator.Yellow)
//    , ITVInterval(seconds: 90, indicator: Indicator.Green)
//    , ITVInterval(seconds: 30, indicator: Indicator.Yellow)
//    , ITVInterval(seconds: 90, indicator: Indicator.Green)
//    , ITVInterval(seconds: 30, indicator: Indicator.Yellow)
//    , ITVInterval(seconds: 90, indicator: Indicator.Green)
//    , ITVInterval(seconds: 120, indicator: Indicator.Blue)
//]
//let intervalsHours = [
//    ITVInterval(seconds: 120000, indicator: Indicator.Blue)
//    , ITVInterval(seconds: 30000, indicator: Indicator.Yellow)
//    , ITVInterval(seconds: 90000, indicator: Indicator.Green)
//    , ITVInterval(seconds: 30000, indicator: Indicator.Yellow)
//    , ITVInterval(seconds: 90000, indicator: Indicator.Green)
//    , ITVInterval(seconds: 30, indicator: Indicator.Yellow)
//    , ITVInterval(seconds: 90, indicator: Indicator.Green)
//    , ITVInterval(seconds: 30, indicator: Indicator.Yellow)
//    , ITVInterval(seconds: 90, indicator: Indicator.Green)
//    , ITVInterval(seconds: 30, indicator: Indicator.Yellow)
//    , ITVInterval(seconds: 90, indicator: Indicator.Green)
//    , ITVInterval(seconds: 30, indicator: Indicator.Yellow)
//    , ITVInterval(seconds: 90000, indicator: Indicator.Green)
//    , ITVInterval(seconds: 30000, indicator: Indicator.Yellow)
//    , ITVInterval(seconds: 90, indicator: Indicator.Green)
//    , ITVInterval(seconds: 30, indicator: Indicator.Yellow)
//    , ITVInterval(seconds: 90000, indicator: Indicator.Green)
//    , ITVInterval(seconds: 120000, indicator: Indicator.Blue)
//]
//let intervalsSeconds = [
//    ITVInterval(seconds: 3, indicator: Indicator.Yellow)
//    , ITVInterval(seconds: 9, indicator: Indicator.Green)
//    , ITVInterval(seconds: 3, indicator: Indicator.Yellow)
//    , ITVInterval(seconds: 9, indicator: Indicator.Green)
//    , ITVInterval(seconds: 3, indicator: Indicator.Yellow)
//    , ITVInterval(seconds: 9, indicator: Indicator.Green)
//    , ITVInterval(seconds: 3, indicator: Indicator.Yellow)
//]

//public struct ITVInterval: Hashable, Equatable {
class ITVInterval: NSObject, NSCoding {
    
    // MARK: - Properties
    fileprivate var seconds: Double?
    fileprivate var indicator: Indicator?
    
    //MARK: - public get/set properties
    public var thisSeconds: Double? {
        get { return seconds}
        set {
            seconds = newValue
            UserDefaults.standard.set(newValue, forKey: "seconds")
            UserDefaults.standard.synchronize()
        }
    }
    public var thisIndicator: Indicator? {
        get { return indicator}
        set {
            indicator = newValue
            UserDefaults.standard.set(newValue?.rawValue, forKey: "indicator")
            UserDefaults.standard.synchronize()
        }
    }
    
    // MARK: - Initializers
    override private init() {
        if let theSeconds = UserDefaults.standard.value(forKey: "seconds") as? Double {
            seconds = theSeconds
        }
        
        if let theIndicatorRawValue = UserDefaults.standard.value(forKey: "indicator") as? Int {
            if let theIndicator = Indicator(rawValue: theIndicatorRawValue) {
                indicator = theIndicator
            }
        }
    }

    // MARK: - Initializers
    public init(seconds: Double?, indicator: Indicator?) {
        super.init()
        guard let theSeconds = seconds, theSeconds > 0 else {
            fatalError("seconds has to be greater than zero")
        }
        thisSeconds = theSeconds
        thisIndicator = indicator
    }
    
    //MARK: - NSCoding protocol methods
    func encode(with coder: NSCoder){
        coder.encode(thisSeconds, forKey: "seconds")
        
        let theIndicatorRawValue = thisIndicator?.rawValue
        coder.encode(theIndicatorRawValue, forKey: "indicator")
    }
    
    required init(coder decoder: NSCoder) {
        
        if let theSeconds = decoder.decodeObject(forKey: "seconds") as? Double {
            seconds = theSeconds
        }
        
        if let theIndicatorRawValue = UserDefaults.standard.value(forKey: "indicator") as? Int {
            if let theIndicator = Indicator(rawValue: theIndicatorRawValue) {
                indicator = theIndicator
            }
        }
    }
}
