//
//  IntervalTimerTimer.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-29.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

////MOCKDATA:
//let timers = [
//    ITVTimer(name: "Peak 8", showWeather: false, temperatureUnit: nil, intervals: intervals)
//    , ITVTimer(name: "Streches", showWeather: true, temperatureUnit: TemperatureUnit.Kelvin, intervals: intervalsHours)
//    , ITVTimer(name: "Legs", showWeather: true, temperatureUnit: TemperatureUnit.Fahrenheit, intervals: intervalsSeconds)
//    , ITVTimer(name: "Upperbody", showWeather: true, temperatureUnit: TemperatureUnit.Celcius, intervals: intervals)
//    , ITVTimer(name: "Arms", showWeather: false, temperatureUnit: nil, intervals: intervalsHours)
//    , ITVTimer(name: "Crossfit", showWeather: true, temperatureUnit: TemperatureUnit.Kelvin, intervals: intervalsSeconds)
//    , ITVTimer(name: "Park run", showWeather: true, temperatureUnit: TemperatureUnit.Fahrenheit, intervals: intervals)
//    , ITVTimer(name: "Beach run", showWeather: true, temperatureUnit: TemperatureUnit.Celcius, intervals: intervalsHours)
//    , ITVTimer(name: "Mountain run", showWeather: false, temperatureUnit: nil, intervals: intervalsSeconds)
//]

//public struct ITVTimer: Hashable, Equatable {
public struct ITVTimer {

//    private static let idGenerator = ITVHashableIdGenerator()
    
    // MARK: - Properties
//    fileprivate let id: Int
    fileprivate var name: String?
    fileprivate var showWeather: Bool?
    fileprivate var temperatureUnit: TemperatureUnit = TemperatureUnit.Celcius
    
    //this should be a dictionary of [Order:Interval] (the order/or rank of the interval will be managed in this class
    //the index of this array could also seve has the order as well...
    private var intervals: [ITVInterval]?
    
    //MARK: - public get/set properties
//    public var hashValue: Int{
//        return id
//    }
    
    public var thisName: String? {
        get { return name}
        set {
            name = newValue
        }
    }
    public var thisShowWeather: Bool? {
        get { return showWeather}
        set {
            showWeather = newValue
        }
    }
    public var thisTemperatureUnit: TemperatureUnit {
        get { return temperatureUnit}
        set {
            temperatureUnit = newValue
        }
    }
    public var thisIntervals: [ITVInterval]? {
        get { return intervals}
        set {
            intervals = newValue
        }
    }
    
    // MARK: - Initializers
    public init(name: String?, showWeather: Bool?, temperatureUnit: TemperatureUnit?, intervals: [ITVInterval]?) {
        guard let theName = name else {
            //TODO: add these fatal errors to the initializers of all oher structs and classes
            fatalError("name must contain a value")
        }
        guard let theShowWeather = showWeather else {
            fatalError("showWeather must contain a value")
        }
//        guard let theIntervals = intervals else {
//            fatalError("intervals must contain a value")
//        }
        
//        self.id = ITVTimer.idGenerator.generate()
        self.thisName = theName
        self.thisShowWeather = theShowWeather
        self.thisIntervals = intervals
        
        if let theTemperatureUnit = temperatureUnit {
            self.thisTemperatureUnit = theTemperatureUnit
        } else {
            self.thisTemperatureUnit = TemperatureUnit.Celcius
        }
    }
    
//    public static func ==(lhs: ITVTimer, rhs: ITVTimer) -> Bool  {
//        return lhs == rhs
//    }
}
//public func ==(itvTimer1: ITVTimer, itvTimer2: ITVTimer) -> Bool {
//    return itvTimer1 === itvTimer2
//}

extension ITVTimer: CustomStringConvertible { //this extension allows for better debugging
    public var description: String {
        let name = (self.thisName != nil ? self.thisName! : "nil")
        let showWeather = (self.thisShowWeather != nil ? self.thisShowWeather : nil)
        let temperatureUnit = (self.thisTemperatureUnit != nil ? self.thisTemperatureUnit : nil)
        let itvIntervals = (self.thisIntervals != nil ? self.thisIntervals! : nil)
        let string = "Name -> \(name) showWeather -> \(showWeather) temperatureUnit -> \(temperatureUnit) itvIntervals -> \(itvIntervals)"
        return string
    }
}
