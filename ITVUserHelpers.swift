//
//  ITVUserHelpers.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-21.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

//MARK: - Helpers
extension ITVUser {
    func weatherQueryPriority() -> Int {
        
        //priority 1 = byCityId
        if ITVCoreLocation.sharedInstance.thisCityId != -1 {
            return WeatherQueryPriority.byCityId.rawValue
        }
        
        //priority 2 = location name
        if ITVCoreLocation.sharedInstance.thisCityName != nil
            && !ITVCoreLocation.sharedInstance.thisCityName!.isEmpty
            && ITVCoreLocation.sharedInstance.thisCountryCode != nil
            && !ITVCoreLocation.sharedInstance.thisCountryCode!.isEmpty {
            return WeatherQueryPriority.byLocationName.rawValue
        }
        
        //priority 3 = coordinates
        if ITVCoreLocation.sharedInstance.thisLatitude != -1 && ITVCoreLocation.sharedInstance.thisLongitude != -1 {
            return WeatherQueryPriority.byCoordinates.rawValue
        }
        
        return WeatherQueryPriority.none.rawValue
    }
}
