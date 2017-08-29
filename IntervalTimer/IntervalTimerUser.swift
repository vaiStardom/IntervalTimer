//
//  IntervalTimerUser.swift
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


private let _sharedInstance = IntervalTimerUser()
class IntervalTimerUser: NSObject {
    
    //MARK: - Singleton
    //The private global _sharedInstance variable is used to initialize IntervalTimerUser lazily. 
    //This happens only on the first access here.
    //The public sharedManager variable returns the private sharedInstance variable. 
    //Swift ensures that this operation is thread safe.
    class var sharedInstance: IntervalTimerUser {
        return _sharedInstance
    }

    //MARK: - fileprivate properties
    fileprivate var temperatureUnit: TemperatureUnit = .celcius
    fileprivate var currentWeather: IntervalTimerCurrentWeather?
    fileprivate var shouldUpdateWeather: Bool? = true
        
    //MARK: - public get/set properties
    var thisTemperatureUnit: TemperatureUnit{
        get { return temperatureUnit}
        set {
            temperatureUnit = newValue
            UserDefaults.standard.set(newValue.rawValue, forKey: "temperatureUnit")
            UserDefaults.standard.synchronize()
        }
    }
    var thisCurrentWeather: IntervalTimerCurrentWeather? {
        get { return currentWeather}
        set {
            currentWeather = newValue
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
        }
    }
    
    //MARK: - init()
    override init() {
        self.temperatureUnit = TemperatureUnit(rawValue: UserDefaults.standard.integer(forKey: "temperatureUnit"))!
    }
    
    //MARK: - NSCoding protocol methods
    func encode(with coder: NSCoder){
        coder.encode(self.thisTemperatureUnit, forKey: "temperatureUnit")
        coder.encode(self.thisShouldUpdateWeather, forKey: "shouldUpdateWeather")
    }
    required init(coder decoder: NSCoder) {
        if let theTemperatureUnit = decoder.decodeInteger(forKey: "temperatureUnit") as Int? {
            temperatureUnit = TemperatureUnit(rawValue: theTemperatureUnit)!
        }
        if let theShouldUpdateWeather = decoder.decodeBool(forKey: "shouldUpdateWeather") as Bool? {
            shouldUpdateWeather = theShouldUpdateWeather
        }
    }
}
