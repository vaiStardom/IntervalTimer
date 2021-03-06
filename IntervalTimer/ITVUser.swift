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
class ITVUser: NSObject, NSCoding  {
    
    //MARK: - Singleton
    static let sharedInstance = ITVUser()

    //MARK: - fileprivate properties
    fileprivate var currentWeather: ITVCurrentWeather?
    fileprivate var lastWeatherUpdate: Date? = nil
    fileprivate var timers: [ITVTimer]? = []
    
    //MARK: - public get/set properties
    var thisCurrentWeather: ITVCurrentWeather? {
        get { return currentWeather}
        set {
            currentWeather = newValue
            if newValue != nil {
                if let theWeather = newValue {
                    let theWeatherData: Data = NSKeyedArchiver.archivedData(withRootObject: theWeather)
                    UserDefaults.standard.set(theWeatherData, forKey: UserDefaultsKey.ITVUser_currentWeather)
                    UserDefaults.standard.synchronize()
                    print("------> WROTE ITVUser currentWeather = \(String(describing: currentWeather))")
                }
                thisLastWeatherUpdate = Date()
            }
        }
    }
    var thisLastWeatherUpdate: Date? {
        get { return lastWeatherUpdate}
        set {
            lastWeatherUpdate = newValue
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.ITVUser_lastWeatherUpdate)
            UserDefaults.standard.synchronize()
        }
    }
    var thisShouldUpdateWeather: Bool {
        get {
//            return true
            if let theHours = hoursSince(from: thisLastWeatherUpdate, to: Date()){
                print("------> ITVUser thisShouldUpdateWeather hours since : \(theHours)")
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
    var thisTimers: [ITVTimer]? {
        get { return timers}
        set {
            timers = newValue
            if newValue != nil {
                if let theTimers = newValue {
                    let theTimersData: Data = NSKeyedArchiver.archivedData(withRootObject: theTimers)
                    UserDefaults.standard.set(theTimersData, forKey: UserDefaultsKey.ITVUser_timers)
                    UserDefaults.standard.synchronize()
                }
            }
        }
    }
    
    //MARK: - init()
    private override init() {
        
        self.lastWeatherUpdate = UserDefaults.standard.object(forKey: UserDefaultsKey.ITVUser_lastWeatherUpdate) as? Date
        
        if let theCurrentWeather = UserDefaults.standard.value(forKey: UserDefaultsKey.ITVUser_currentWeather) as! Data? {
            self.currentWeather = NSKeyedUnarchiver.unarchiveObject(with: theCurrentWeather) as? ITVCurrentWeather
        }
        
        if let theTimers = UserDefaults.standard.value(forKey: UserDefaultsKey.ITVUser_timers) as! Data?, !theTimers.isEmpty {
            self.timers = NSKeyedUnarchiver.unarchiveObject(with: theTimers) as? [ITVTimer]
        }
    }
    
    //MARK: - NSCoding protocol methods
    func encode(with coder: NSCoder){
        coder.encode(self.thisCurrentWeather, forKey: UserDefaultsKey.ITVUser_currentWeather)
        coder.encode(self.thisLastWeatherUpdate, forKey: UserDefaultsKey.ITVUser_lastWeatherUpdate)
        coder.encode(self.thisTimers, forKey: UserDefaultsKey.ITVUser_timers)
    }
    
    required init(coder decoder: NSCoder) {
        if let theCurrentWeather = decoder.decodeObject(forKey: UserDefaultsKey.ITVUser_currentWeather) as! ITVCurrentWeather? {
            currentWeather = theCurrentWeather
        }
        if let theLastWeatherUpdate = decoder.decodeObject(forKey: UserDefaultsKey.ITVUser_lastWeatherUpdate) as! Date? {
            lastWeatherUpdate = theLastWeatherUpdate
        }
        if let theTimers = decoder.decodeObject(forKey: UserDefaultsKey.ITVUser_timers) as! [ITVTimer]? {
            timers = theTimers
        }
    }
}
