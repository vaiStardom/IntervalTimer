//
//  IntervalTimerWeatherCurrent.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-02.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

//TODO: Change this to a struct, we dont want to pass around copies of this
class IntervalTimerCurrentWeather: NSObject {
    
    //MARK: - fileprivate properties
    fileprivate var temperature: Double?
    fileprivate var icon: String?
    
    //MARK: - public get/set properties
    var thisTemperature: Double?{
        get { return temperature}
        set {
            temperature = convertTemperature(kelvins: newValue!, forUnits: IntervalTimerUser.sharedInstance.thisTemperatureUnit)
            UserDefaults.standard.set(newValue, forKey: "temperature")
            UserDefaults.standard.synchronize()
        }
    }
    var thisIcon: String?{
        get { return icon}
        set {
            icon = newValue
            UserDefaults.standard.set(newValue, forKey: "icon")
            UserDefaults.standard.synchronize()
        }
    }
    
    //MARK: - Initializer
    init?(temperature: Double?, icon: String?){
        if let theTemperature = temperature, let theIcon = icon {
            self.temperature = theTemperature
            self.icon = ICON_DICTIONARY[theIcon]
        } else {
            return nil
        }
    }
    
    //MARK: - NSCoding protocol methods
    func encode(with coder: NSCoder){
        coder.encode(self.thisTemperature, forKey: "temperature")
        coder.encode(self.thisIcon, forKey: "icon")
    }
    required init(coder decoder: NSCoder) {
        if let theTemperature = decoder.decodeDouble(forKey: "temperature") as Double? {
            temperature = theTemperature
        }
        if let theIcon = decoder.decodeObject(forKey: "icon") as! String? {
            icon = theIcon
        }
    }
}
//MARK: - Temperature conversions
extension IntervalTimerCurrentWeather{
    func convertTemperature(kelvins: Double, forUnits temperatureUnit: TemperatureUnit) -> Double {
        switch temperatureUnit {
        case .kelvin :
            return kelvins
        case .fahrenheit:
            return kelvins - 459.67
        case .celcius:
            return kelvins - 273.15
        }
    }
}
