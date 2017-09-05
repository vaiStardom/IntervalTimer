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
    fileprivate var temperatureUnit: TemperatureUnit = .celcius //TODO : delete from here and move to the timer class
    fileprivate var currentWeather: IntervalTimerCurrentWeather?
    fileprivate var lastWeatherUpdate: Date?
    fileprivate var shouldUpdateWeather: Bool? = true
        
    //MARK: - public get/set properties
    var thisTemperatureUnit: TemperatureUnit{
        get { return temperatureUnit}
        set {
            temperatureUnit = newValue
            UserDefaults.standard.set(newValue.rawValue, forKey: "temperatureUnit")
            UserDefaults.standard.synchronize()
            print("------> WROTE IntervalTimerUser temperatureUnit = \(temperatureUnit)")
        }
    }
    var thisCurrentWeather: IntervalTimerCurrentWeather? {
        get { return currentWeather}
        set {
            currentWeather = newValue
            if newValue != nil {
                if let theWeather = newValue {
                    let theWeatherData = NSKeyedArchiver.archivedData(withRootObject: theWeather)
                    UserDefaults.standard.set(theWeatherData, forKey: "notificationList")
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
            print("------> WROTE IntervalTimerUser lastWeatherUpdate = \(String(describing: lastWeatherUpdate))")
        }
    }
    var thisShouldUpdateWeather: Bool? {
        get {
            return shouldUpdateWeather
        }
        set {
            shouldUpdateWeather = newValue
            UserDefaults.standard.set(newValue, forKey: "shouldUpdateWeather")
            UserDefaults.standard.synchronize()
            print("------> WROTE IntervalTimerUser shouldUpdateWeather = \(String(describing: shouldUpdateWeather))")
        }
    }
    
    //MARK: - init()
    override private init() {
        self.temperatureUnit = TemperatureUnit(rawValue: UserDefaults.standard.integer(forKey: "temperatureUnit"))!
        //self.shouldUpdateWeather = UserDefaults.standard.bool(forKey: "shouldUpdateWeather")
        self.shouldUpdateWeather = true
        self.lastWeatherUpdate = UserDefaults.standard.object(forKey: "lastWeatherUpdate") as? Date
        self.currentWeather = UserDefaults.standard.object(forKey: "currentWeather") as? IntervalTimerCurrentWeather
    }
    
    //MARK: - NSCoding protocol methods
    func encode(with coder: NSCoder){
        coder.encode(self.thisTemperatureUnit, forKey: "temperatureUnit")
        coder.encode(self.thisCurrentWeather, forKey: "currentWeather")
        coder.encode(self.thisLastWeatherUpdate, forKey: "lastWeatherUpdate")
        coder.encode(self.thisShouldUpdateWeather, forKey: "shouldUpdateWeather")
    }
    
    required init(coder decoder: NSCoder) {
        if let theTemperatureUnit = decoder.decodeInteger(forKey: "temperatureUnit") as Int? {
            temperatureUnit = TemperatureUnit(rawValue: theTemperatureUnit)!
        }
        if let theCurrentWeather = UserDefaults.standard.value(forKey: "currentWeather") as? NSData {
            currentWeather = NSKeyedUnarchiver.unarchiveObject(with: theCurrentWeather as Data) as! IntervalTimerCurrentWeather?
        }
        if let theLastWeatherUpdate = decoder.decodeObject(forKey: "lastWeatherUpdate") as! Date? {
            lastWeatherUpdate = theLastWeatherUpdate
        }
        if let theShouldUpdateWeather = decoder.decodeBool(forKey: "shouldUpdateWeather") as Bool? {
            shouldUpdateWeather = theShouldUpdateWeather
        }
    }
}
