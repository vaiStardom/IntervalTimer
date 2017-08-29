//
//  IntervalTimerUserHelpers.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-21.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

//MARK: - Helpers
extension IntervalTimerUser {
    
    func weatherQueryPriority() -> Int {
        
        //priority 1 = byCityId
        if IntervalTimerCoreLocation.sharedInstance.thisCityId != -1 {
            return WeatherQueryPriority.byCityId.rawValue
        }
        
        //priority 2 = location name
        if !IntervalTimerCoreLocation.sharedInstance.thisCityName!.isEmpty && !IntervalTimerCoreLocation.sharedInstance.thisCountryCode!.isEmpty {
            return WeatherQueryPriority.byLocationName.rawValue
        }
        
        //priority 3 = coordinates
        if IntervalTimerCoreLocation.sharedInstance.thisLatitude != -1 && IntervalTimerCoreLocation.sharedInstance.thisLongitude != -1 {
            return WeatherQueryPriority.byCoordinates.rawValue
        }
        
        return WeatherQueryPriority.none.rawValue
    }
}
