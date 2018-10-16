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
    var isFavourite: Bool?
    
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

    public var thisIsFavourite: Bool {
        get { return isFavourite! }
        set {
            isFavourite = newValue
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
    
    init(name: String?, showWeather: Bool?, temperatureUnit: TemperatureUnit?, isFavourite: Bool?, intervals: [ITVInterval]?) {
        guard let theName = name else {
            fatalError("name cannot be nil.")
        }
        guard let theShowWeather = showWeather else {
            fatalError("showWeather cannot be nil.")
        }
        guard let theIsFavourite = isFavourite else {
            fatalError("isFavourite cannot be nil.")
        }
        guard let theTemperatureUnit = temperatureUnit else {
            fatalError("temperatureUnit cannot be nil.")
        }
        
        self.name = theName
        self.showWeather = theShowWeather
        self.temperatureUnit = theTemperatureUnit
        self.isFavourite = theIsFavourite
        self.intervals = intervals
    }
    
    //MARK: - NSCoding protocol methods
    required convenience init?(coder decoder: NSCoder) {
        
        let theName = decoder.decodeObject(forKey: UserDefaultsKey.ITVTimer_name) as? String ?? ""
        print("\(Date())------> ITVTimer DECODE init?(decoder:) thisName \(theName)")
        
        let theShowWeather = decoder.decodeBool(forKey: UserDefaultsKey.ITVTimer_showWeather) as Bool?
        let theIsFavourite = decoder.decodeBool(forKey: UserDefaultsKey.ITVTimer_isFavourite) as Bool?
        let theTemperatureUnitRawValue = decoder.decodeInteger(forKey: UserDefaultsKey.ITVTimer_temperatureUnit) as Int?
        let theTemperatureUnit = TemperatureUnit(rawValue: (theTemperatureUnitRawValue != nil ? theTemperatureUnitRawValue! : 2))
        let theIntervals = decoder.decodeObject(forKey: UserDefaultsKey.ITVTimer_intervals) as! [ITVInterval]?
        
        self.init(name: theName, showWeather: theShowWeather, temperatureUnit: theTemperatureUnit, isFavourite: theIsFavourite, intervals: theIntervals)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(thisName, forKey: UserDefaultsKey.ITVTimer_name)
        coder.encode(thisShowWeather, forKey: UserDefaultsKey.ITVTimer_showWeather)
        coder.encode(thisIsFavourite, forKey: UserDefaultsKey.ITVTimer_isFavourite)
        coder.encode(thisTemperatureUnit.rawValue, forKey: UserDefaultsKey.ITVTimer_temperatureUnit)
        coder.encode(thisIntervals, forKey: UserDefaultsKey.ITVTimer_intervals)
    }
}
