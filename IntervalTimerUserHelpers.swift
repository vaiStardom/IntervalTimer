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
        if thisCityId != nil {
            return WeatherQueryPriority.byCityId.rawValue
        }
        
        //priority 2 = location name
        if thisCityName != nil && thisCountryCode != nil {
            return WeatherQueryPriority.byLocationName.rawValue
        }
        
        //priority 3 = coordinates
        if thisLatitude != nil && thisLongitude != nil {
            return WeatherQueryPriority.byCoordinates.rawValue
        }
        
        return WeatherQueryPriority.none.rawValue
    }
    
//    func getCityId(){
//        
//        self.thisDidAttemptGettingCityId = true
//        
//        guard let theCityName = thisCityName else {
//            thisCityId = nil
//            return
//        }
//        
//        guard let theCountryCode = thisCountryCode else {
//            thisCityId = nil
//            return
//        }
//        
//        DispatchQueue.global().async {
//            
//            //Get the city id with placemark locality, then manage via notifications
//            do {
//                let asyncCityId = try IntervalTimerCsv.sharedInstance.getCityIdFromCsv(file: "cityList.20170703", cityName: theCityName, countryCode: theCountryCode)
//                if asyncCityId == nil { //Get the city id with MapQuest
//                    IntervalTimerCity.getCityByCoordinates()
//                } else {
//                    DispatchQueue.main.async(execute: {
//                        let theCityId = asyncCityId
//                        self.thisCityId = theCityId
//                        self.thisDidAttemptGettingCityId = true
//                        //NotificationCenter.default.post(name: Notification.Name(rawValue: "didGetCityId"), object: nil)
//                    })
//                }
//            } catch let error {
//                print(error)
//            }
//        }
//    }
}
