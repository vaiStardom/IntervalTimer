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
            UserDefaults.standard.set(icon, forKey: "icon")
            UserDefaults.standard.synchronize()
        }
    }
    var thisKelvin: Double?{
        get { return kelvin}
        set {
            kelvin = newValue
            if let theKelvin = newValue {
                UserDefaults.standard.set(theKelvin, forKey: "kelvin")
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
        
        guard let theMain = json["main"] as? [String: Any] else {
            throw ITVError.JSON_Missing("json key main")
        }
        guard let theKelvin = theMain["temp"] as? Double else {
            throw ITVError.JSON_Missing("json key temp")
        }
        guard let theWeatherArray = json["weather"] as? [[String: AnyObject]] else {
            throw ITVError.JSON_Missing("json key weather")
        }
        guard let theIcon = theWeatherArray[0]["icon"] as? String else {
            throw ITVError.JSON_Missing("json key icon")
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
        if let theKelvin = decoder.decodeObject(forKey: "kelvin") as! Double? {
            kelvin = theKelvin
        }
        if let theIcon = decoder.decodeObject(forKey: "icon") as! String? {
            icon = theIcon
        }
    }
}
