//
//  IntervalTimerWeatherCurrent.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-02.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

class IntervalTimerCurrentWeather: NSObject {
    
    //MARK: - fileprivate properties
    fileprivate var temperature: Double?
    fileprivate var icon: String?
    
    //MARK: - public get/set properties
    var thisTemperature: Double?{
        get { return temperature}
        set {
            temperature = newValue
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
        //        self.temperature = temperature
        //        self.icon = ICON_DICTIONARY[icon]
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







//Using city ID
//http://api.openweathermap.org/data/2.5/weather?id=1635882&APPID=448af267f0d35a22b6e00178e163deb3
//{
//    "coord": {
//        "lon": 116.12,
//        "lat": -8.58
//    },
//    "weather": [{
//    "id": 800,
//    "main": "Clear",
//    "description": "clear sky",
//    "icon": "01d"
//    }],
//    "base": "stations",
//    "main": {
//        "temp": 304.15,
//        "pressure": 1012,
//        "humidity": 52,
//        "temp_min": 304.15,
//        "temp_max": 304.15
//    },
//    "visibility": 10000,
//    "wind": {
//        "speed": 2.1,
//        "deg": 140
//    },
//    "clouds": {
//        "all": 0
//    },
//    "dt": 1498968000,
//    "sys": {
//        "type": 1,
//        "id": 8001,
//        "message": 0.0179,
//        "country": "ID",
//        "sunrise": 1498948235,
//        "sunset": 1498990118
//    },
//    "id": 1635882,
//    "name": "Mataram",
//    "cod": 200
//}

//Using city name
//http://api.openweathermap.org/data/2.5/weather?q=Mataram,id&APPID=448af267f0d35a22b6e00178e163deb3
//{
//    "coord": {
//        "lon": 116.12,
//        "lat": -8.58
//    },
//    "weather": [{
//    "id": 800,
//    "main": "Clear",
//    "description": "clear sky",
//    "icon": "01d"
//    }],
//    "base": "stations",
//    "main": {
//        "temp": 304.15,
//        "pressure": 1012,
//        "humidity": 52,
//        "temp_min": 304.15,
//        "temp_max": 304.15
//    },
//    "visibility": 10000,
//    "wind": {
//        "speed": 2.1,
//        "deg": 140
//    },
//    "clouds": {
//        "all": 0
//    },
//    "dt": 1498968000,
//    "sys": {
//        "type": 1,
//        "id": 8001,
//        "message": 0.0154,
//        "country": "ID",
//        "sunrise": 1498948235,
//        "sunset": 1498990117
//    },
//    "id": 1635882,
//    "name": "Mataram",
//    "cod": 200
//}


//Using coordinates
//{
//    "coord": {
//        "lon": 116.07,
//        "lat": -8.55
//    },
//    "weather": [{
//    "id": 800,
//    "main": "Clear",
//    "description": "clear sky",
//    "icon": "01d"
//    }],
//    "base": "stations",
//    "main": {
//        "temp": 304.15,
//        "pressure": 1012,
//        "humidity": 52,
//        "temp_min": 304.15,
//        "temp_max": 304.15
//    },
//    "visibility": 10000,
//    "wind": {
//        "speed": 2.1,
//        "deg": 140
//    },
//    "clouds": {
//        "all": 0
//    },
//    "dt": 1498968000,
//    "sys": {
//        "type": 1,
//        "id": 8001,
//        "message": 0.0154,
//        "country": "ID",
//        "sunrise": 1498948244,
//        "sunset": 1498990133
//    },
//    "id": 7545578,
//    "name": "Jempongwareng",
//    "cod": 200
//}
