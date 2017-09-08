//
//  ITVUser.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-02.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

//TODO: Use these guidlines for error handling:
/*
 Ensure error types are clearly named across your codebase.
 Use optionals where a single error state exists.
 Use custom errors where more than one error state exists.
 Don’t allow an error to propagate too far from its source.
 */

//TODO: Geocoding is a time and resource intensive task, whenever possible, pre-geocode known locations
//People usually workout in the same place or area. 
//Start saving coordinates and checking if the coordinates are always whithing the same radius, say 50KM.
//Your radius will be a geofence of 50 KM radiua, check to see if its possible to query cities whithin a radius.
//Also check if there is an existing city id in this same radius. 
//Once a usual radius(area) is determined and that a city id is retreived, we would not need to look in the csv file for the id anymore.
//Also if there are NO identifialble city ids in this radius, then stop reverse geocoding and only get weather using coordinates
//TODO: Protect this singletons from concurrency
//TODO: Rename all interval timer classes and structs to ITV
class ITVUser: NSObject, NSCoding {
    
    //MARK: - Singleton
    static let sharedInstance = ITVUser()

    //MARK: - fileprivate properties
    fileprivate var currentWeather: ITVCurrentWeather?
    fileprivate var lastWeatherUpdate: Date?
    fileprivate var temperatureUnit: TemperatureUnit = .celcius //TODO : delete from here and move to the timer class
    fileprivate var timers: [ITVTimer]?
    
    //MARK: - public get/set properties
    var thisCurrentWeather: ITVCurrentWeather? {
        get { return currentWeather}
        set {
            currentWeather = newValue
            if newValue != nil {
                if let theWeather = newValue {
                    let theWeatherData = NSKeyedArchiver.archivedData(withRootObject: theWeather)
                    UserDefaults.standard.set(theWeatherData, forKey: "currentWeather")
                    UserDefaults.standard.synchronize()
                    print("------> WROTE IntervalTimerUser currentWeather = \(String(describing: currentWeather))")
                }
                thisLastWeatherUpdate = Date()
            }
        }
    }
    var thisLastWeatherUpdate: Date? {
        get { return lastWeatherUpdate}
        set {
            lastWeatherUpdate = newValue
            UserDefaults.standard.set(newValue, forKey: "lastWeatherUpdate")
            UserDefaults.standard.synchronize()
//            print("------> WROTE IntervalTimerUser lastWeatherUpdate = \(String(describing: lastWeatherUpdate))")
        }
    }
    var thisShouldUpdateWeather: Bool {
        get {
            if let theHours = hoursSince(from: thisLastWeatherUpdate, to: Date()){
                if theHours > 1 {
                    return true
                } else {
                    return false
                }
            } else {
                return true
            }
        }
    }
    var thisTemperatureUnit: TemperatureUnit{
        get { return temperatureUnit}
        set {
            temperatureUnit = newValue
            UserDefaults.standard.set(newValue.rawValue, forKey: "temperatureUnit")
            UserDefaults.standard.synchronize()
            print("------> WROTE IntervalTimerUser temperatureUnit = \(temperatureUnit)")
        }
    }
    var thisTimers: [ITVTimer]? {
        get { return timers}
        set {
            timers = newValue
            if newValue != nil {
                if let theTimers = newValue {
                    let theTimersData = NSKeyedArchiver.archivedData(withRootObject: theTimers)
                    UserDefaults.standard.set(theTimersData, forKey: "timers")
                    UserDefaults.standard.synchronize()
                }
            }
        }
    }
    
    //MARK: - init()
    override private init() {
        self.temperatureUnit = TemperatureUnit(rawValue: UserDefaults.standard.integer(forKey: "temperatureUnit"))!
        self.lastWeatherUpdate = UserDefaults.standard.object(forKey: "lastWeatherUpdate") as? Date
        if let theCurrentWeather = UserDefaults.standard.value(forKey: "currentWeather") as? NSData {
            self.currentWeather = NSKeyedUnarchiver.unarchiveObject(with: theCurrentWeather as Data) as? ITVCurrentWeather
        }
        if let theTimers = UserDefaults.standard.value(forKey: "timers") as? NSData {
            self.timers = NSKeyedUnarchiver.unarchiveObject(with: theTimers as Data) as? [ITVTimer]
        }
    }
    
    //MARK: - NSCoding protocol methods
    func encode(with coder: NSCoder){
        coder.encode(self.thisCurrentWeather, forKey: "currentWeather")
        coder.encode(self.thisLastWeatherUpdate, forKey: "lastWeatherUpdate")
        coder.encode(self.thisTemperatureUnit, forKey: "temperatureUnit")
        coder.encode(self.thisTimers, forKey: "timers")
    }
    
    required init(coder decoder: NSCoder) {
        if let theCurrentWeather = UserDefaults.standard.value(forKey: "currentWeather") as? NSData {
            currentWeather = NSKeyedUnarchiver.unarchiveObject(with: theCurrentWeather as Data) as! ITVCurrentWeather?
        }
        if let theLastWeatherUpdate = decoder.decodeObject(forKey: "lastWeatherUpdate") as! Date? {
            lastWeatherUpdate = theLastWeatherUpdate
        }
        if let theTemperatureUnit = decoder.decodeInteger(forKey: "temperatureUnit") as Int? {
            temperatureUnit = TemperatureUnit(rawValue: theTemperatureUnit)!
        }
        if let theTimers = UserDefaults.standard.value(forKey: "timers") as? NSData {
            timers = NSKeyedUnarchiver.unarchiveObject(with: theTimers as Data) as! [ITVTimer]?
        }
    }
}
