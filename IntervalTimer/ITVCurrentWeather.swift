//
//  ITVCurrentWeather.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-02.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

//TODO: Change this to a struct, we dont want to pass around copies of this
class ITVCurrentWeather: NSObject, NSCoding {
    
    //MARK: - fileprivate properties
    fileprivate var icon: String?
    fileprivate var kelvin: Double? //source (JSON) gives temperature in kelvins
    fileprivate var temperature: String?
    
    //MARK: - public get/set properties
    var thisIcon: String?{
        get {
            return icon
        }
        set {
            icon = ICON_DICTIONARY[newValue!]
            UserDefaults.standard.set(icon, forKey: UserDefaultsKey.ITVCurrentWeather_icon)
            UserDefaults.standard.synchronize()
        }
    }
    var thisKelvin: Double?{
        get { return kelvin}
        set {
            kelvin = newValue
            if let theKelvin = newValue {
                UserDefaults.standard.set(theKelvin, forKey: UserDefaultsKey.ITVCurrentWeather_kelvin)
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    //MARK: - Initializers
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
    public init(json: [String: Any]) throws {
        
        guard let theMain = json[JsonKeys.ITVCurrentWeather_main] as? [String: Any] else {
            throw ITVError.JSON_Missing("json key \(JsonKeys.ITVCurrentWeather_main)")
        }
        guard let theKelvin = theMain[JsonKeys.ITVCurrentWeather_temp] as? Double else {
            throw ITVError.JSON_Missing("json key \(JsonKeys.ITVCurrentWeather_temp)")
        }
        guard let theWeatherArray = json[JsonKeys.ITVCurrentWeather_weather] as? [[String: AnyObject]] else {
            throw ITVError.JSON_Missing("json key \(JsonKeys.ITVCurrentWeather_weather)")
        }
        guard let theIcon = theWeatherArray[0][JsonKeys.ITVCurrentWeather_icon] as? String else {
            throw ITVError.JSON_Missing("json key \(JsonKeys.ITVCurrentWeather_icon)")
        }
        self.kelvin = theKelvin
        self.icon = ICON_DICTIONARY[theIcon]
    }
    
    //MARK: - NSCoding protocol methods
    func encode(with coder: NSCoder){
        coder.encode(self.thisIcon, forKey: UserDefaultsKey.ITVCurrentWeather_icon)
        coder.encode(self.thisKelvin, forKey: UserDefaultsKey.ITVCurrentWeather_kelvin)
        
    }
    required init(coder decoder: NSCoder) {
        if let theKelvin = decoder.decodeObject(forKey: UserDefaultsKey.ITVCurrentWeather_kelvin) as! Double? {
            kelvin = theKelvin
        }
        if let theIcon = decoder.decodeObject(forKey: UserDefaultsKey.ITVCurrentWeather_icon) as! String? {
            icon = theIcon
        }
    }
}
