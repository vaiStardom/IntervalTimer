//
//  IntervalTimerTimer.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-29.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

class ITVTimer: NSObject, NSCoding {

    // MARK: - Properties
    var name: String?
    var showWeather: Bool?
    var temperatureUnit: TemperatureUnit? = TemperatureUnit.Celcius
    
    //this should be a dictionary of [Order:Interval] (the order/or rank of the interval will be managed in this class
    //the index of this array could also seve has the order as well...
    var intervals: [ITVInterval]? = []
    
    //MARK: - public get/set properties
    public var thisName: String? {
        get { return name}
        set {
            name = newValue
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.ITVTimer_name)
            UserDefaults.standard.synchronize()
        }
    }
    
    public var thisShowWeather: Bool {
        get {
            if showWeather == nil {
                return false
            } else {
                return showWeather!
            }
        }
        set {
            showWeather = newValue
        }
    }
    
    public var thisTemperatureUnit: TemperatureUnit {
        get { return temperatureUnit! }
        set {
            temperatureUnit = newValue
        }
    }
    public var thisIntervals: [ITVInterval]? {
        get { return intervals}
        set {
            intervals = newValue
            if newValue != nil {
                if let theIntervals = newValue {
                    let theIntervalsData: Data = NSKeyedArchiver.archivedData(withRootObject: theIntervals)
                    UserDefaults.standard.set(theIntervalsData, forKey: UserDefaultsKey.ITVTimer_intervals)
                    UserDefaults.standard.synchronize()
                }
            }

        }
    }
    
    init(name: String?, showWeather: Bool?, temperatureUnit: TemperatureUnit?, intervals: [ITVInterval]?) {
        guard let theName = name else {
            fatalError("------> ERROR ITVTimer name must contain a value")
        }
        guard let theShowWeather = showWeather else {
            fatalError("------> ERROR ITVTimer showWeather must contain a value")
        }
        guard let theTemperatureUnit = temperatureUnit else {
            fatalError("------> ERROR ITVTimer temperatureUnit must contain a value")
        }
        
        self.name = theName
        self.showWeather = theShowWeather
        self.temperatureUnit = theTemperatureUnit
        self.intervals = intervals
    }
    
    //MARK: - NSCoding protocol methods
    required convenience init?(coder decoder: NSCoder) {
        
        let theName = decoder.decodeObject(forKey: UserDefaultsKey.ITVTimer_name) as? String ?? ""
        print("\(Date())------> ITVTimer DECODE init?(decoder:) thisName \(theName)")
        
        let theShowWeather = decoder.decodeBool(forKey: UserDefaultsKey.ITVTimer_showWeather) as Bool?
        let theTemperatureUnitRawValue = decoder.decodeInteger(forKey: UserDefaultsKey.ITVTimer_temperatureUnit) as Int?
        let theTemperatureUnit = TemperatureUnit(rawValue: (theTemperatureUnitRawValue != nil ? theTemperatureUnitRawValue! : 2))
        let theIntervals = decoder.decodeObject(forKey: UserDefaultsKey.ITVTimer_intervals) as! [ITVInterval]?
        
        self.init(name: theName, showWeather: theShowWeather, temperatureUnit: theTemperatureUnit, intervals: theIntervals)        
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(thisName, forKey: UserDefaultsKey.ITVTimer_name)
        coder.encode(thisShowWeather, forKey: UserDefaultsKey.ITVTimer_showWeather)
        coder.encode(thisTemperatureUnit.rawValue, forKey: UserDefaultsKey.ITVTimer_temperatureUnit)
        coder.encode(thisIntervals, forKey: UserDefaultsKey.ITVTimer_intervals)
    }
}
