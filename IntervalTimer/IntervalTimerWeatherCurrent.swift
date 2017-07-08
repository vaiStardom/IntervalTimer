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
    fileprivate var kelvin: Double? //source (JSON) gives temperature in kelvins
    fileprivate var temperature: String?
    fileprivate var icon: String?
    
    //MARK: - public get/set properties
    var thisTemperature: String?{
        get {
            return convertTemperature(kelvins: thisKelvin, forUnits: IntervalTimerUser.sharedInstance.thisTemperatureUnit)
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
    var thisKelvin: Double?{
        get { return kelvin}
        set {
            kelvin = newValue
            UserDefaults.standard.set(newValue, forKey: "kelvin")
            UserDefaults.standard.synchronize()
        }
    }
    
    //MARK: - Initializer
    init?(kelvin: Double?, icon: String?){
        guard  let theKelvin = kelvin else {
            return nil
        }
        
        guard let theIcon = icon else {
            return nil
        }
        
        self.kelvin = theKelvin
        self.icon = ICON_DICTIONARY[theIcon]
    }
    
    //MARK: - NSCoding protocol methods
    func encode(with coder: NSCoder){
        coder.encode(self.thisKelvin, forKey: "kelvin")
        coder.encode(self.thisIcon, forKey: "icon")
    }
    required init(coder decoder: NSCoder) {
        if let theKelvin = decoder.decodeDouble(forKey: "kelvin") as Double? {
            kelvin = theKelvin
        }
        if let theIcon = decoder.decodeObject(forKey: "icon") as! String? {
            icon = theIcon
        }
    }
}

//MARK: - Temperature conversions
extension IntervalTimerCurrentWeather{
    func convertTemperature(kelvins: Double?, forUnits temperatureUnit: TemperatureUnit?) -> String? {
        guard let theKelvin = kelvins else {
            return nil
        }
        
        guard let theTemperatureUnit = temperatureUnit else {
            return nil
        }
        
        switch theTemperatureUnit {
        case .kelvin :
            return "\(Int(theKelvin))\(DEGREE)K"
        case .fahrenheit:
            return "\(Int(theKelvin - 459.67))\(DEGREE)F"
        case .celcius:
            return "\(Int(theKelvin - 273.15))\(DEGREE)C"
        }
    }
}
