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
    ITVTimer(name: "Peak 8", showWeather: true, temperatureUnit: nil, intervals: intervals)
    , ITVTimer(name: "Streches", showWeather: false, temperatureUnit: TemperatureUnit.kelvin, intervals: intervalsHours)
    , ITVTimer(name: "Legs", showWeather: true, temperatureUnit: TemperatureUnit.fahrenheit, intervals: intervalsSeconds)
    , ITVTimer(name: "Upperbody", showWeather: false, temperatureUnit: TemperatureUnit.celcius, intervals: intervals)
    , ITVTimer(name: "Arms", showWeather: true, temperatureUnit: nil, intervals: intervalsHours)
    , ITVTimer(name: "Crossfit", showWeather: false, temperatureUnit: TemperatureUnit.kelvin, intervals: intervalsSeconds)
    , ITVTimer(name: "Park run", showWeather: true, temperatureUnit: TemperatureUnit.fahrenheit, intervals: intervals)
    , ITVTimer(name: "Beach run", showWeather: false, temperatureUnit: TemperatureUnit.celcius, intervals: intervalsHours)
    , ITVTimer(name: "Mountain run", showWeather: true, temperatureUnit: nil, intervals: intervalsSeconds)
]

public struct ITVTimer {
        
    // MARK: - Properties
    fileprivate var name: String?
    fileprivate var showWeather: Bool?
    fileprivate var temperatureUnit: TemperatureUnit? = TemperatureUnit.celcius
    
    //this should be a dictionary of [Order:Interval] (the order/or rank of the interval will be managed in this class
    //the index of this array could also seve has the order as well...
    private var intervals: [ITVInterval]?
    
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
    public var thisIntervals: [ITVInterval]? {
        get { return intervals}
        set {
            intervals = newValue
        }
    }
    
    // MARK: - Initializers
    public init(name: String?, showWeather: Bool?, temperatureUnit: TemperatureUnit? = TemperatureUnit.celcius, intervals: [ITVInterval]?) {
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
