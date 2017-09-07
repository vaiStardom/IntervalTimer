//
//  ITVCurrentWeatherHelpers.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-06.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

//MARK: - Temperature conversions
extension ITVCurrentWeather{
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
