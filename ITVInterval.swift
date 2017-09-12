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
public struct ITVInterval {
    
//    private static let idGenerator = ITVHashableIdGenerator()
    
    // MARK: - Properties
//    fileprivate let id: Int
    fileprivate var seconds: Double?
    fileprivate var indicator: Indicator?
    
    //MARK: - public get/set properties
//    public var hashValue: Int{
//        return id
//    }

    public var thisSeconds: Double? {
        get { return seconds}
        set {
            seconds = newValue
        }
    }
    public var thisIndicator: Indicator? {
        get { return indicator}
        set {
            indicator = newValue
        }
    }
    
    // MARK: - Initializers
    public init(seconds: Double?, indicator: Indicator?) {
        guard let theSeconds = seconds, theSeconds > 0 else {
            fatalError("seconds has to be greater than zero")
        }
//        self.id = ITVInterval.idGenerator.generate()
        thisSeconds = theSeconds
        thisIndicator = indicator
    }
    
//    public static func ==(lhs: ITVInterval, rhs: ITVInterval) -> Bool  {
//        return lhs == rhs
//    }
}
