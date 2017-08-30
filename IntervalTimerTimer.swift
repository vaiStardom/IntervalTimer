//
//  IntervalTimerTimer.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-29.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

//MOCKDATA:
let timers = [
    IntervalTimerTimer(name: "Peak 8", showWeather: true, temperatureUnit: nil, intervals: intervals)
    , IntervalTimerTimer(name: "Streches", showWeather: false, temperatureUnit: TemperatureUnit.kelvin, intervals: intervals)
    , IntervalTimerTimer(name: "Legs", showWeather: true, temperatureUnit: TemperatureUnit.fahrenheit, intervals: intervals)
    , IntervalTimerTimer(name: "Upperbody", showWeather: false, temperatureUnit: TemperatureUnit.celcius, intervals: intervals)
    , IntervalTimerTimer(name: "Arms", showWeather: true, temperatureUnit: nil, intervals: intervals)
    , IntervalTimerTimer(name: "Crossfit", showWeather: false, temperatureUnit: TemperatureUnit.kelvin, intervals: intervals)
    , IntervalTimerTimer(name: "Park run", showWeather: true, temperatureUnit: TemperatureUnit.fahrenheit, intervals: intervals)
    , IntervalTimerTimer(name: "Beach run", showWeather: false, temperatureUnit: TemperatureUnit.celcius, intervals: intervals)
    , IntervalTimerTimer(name: "Mountain run", showWeather: true, temperatureUnit: nil, intervals: intervals)
]

public struct IntervalTimerTimer {
        
    // MARK: - Properties
    fileprivate var name: String?
    fileprivate var showWeather: Bool?
    fileprivate var temperatureUnit: TemperatureUnit? = TemperatureUnit.celcius
    
    //this should be a dictionary of [Order:Interval] (the order/or rank of the interval will be managed in this class
    //the index of this array could also seve has the order as well...
    private var intervals: [IntervalTimerInterval]?
    
    //MARK: - public get/set properties
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
    public var thisTemperatureUnit: TemperatureUnit? {
        get { return temperatureUnit}
        set {
            temperatureUnit = newValue
        }
    }
    public var thisIntervals: [IntervalTimerInterval]? {
        get { return intervals}
        set {
            intervals = newValue
        }
    }
    
    // MARK: - Initializers
    public init(name: String?, showWeather: Bool?, temperatureUnit: TemperatureUnit? = TemperatureUnit.celcius, intervals: [IntervalTimerInterval]?) {
        guard let theName = name else {
            //TODO: add these fatal errors to the initializers of all oher structs and classes
            fatalError("name must contain a value")
        }
        guard let theShowWeather = showWeather else {
            fatalError("showWeather must contain a value")
        }
        guard let theIntervals = intervals else {
            fatalError("intervals must contain a value")
        }
        self.thisName = theName
        self.thisShowWeather = theShowWeather
        self.thisTemperatureUnit = temperatureUnit
        self.thisIntervals = theIntervals
    }
}
extension IntervalTimerTimer{
//        fileprivate var totalTime: Double? //this is the sum of seconds of its interval arrays
    func totalTime(){
        //TODO: return the total time of this timer
    }
}
