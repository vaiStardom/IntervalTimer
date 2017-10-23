//
//  ITVCityRetreival.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-07.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

//MARK: - City Retreival Static Functions
extension ITVCity{
    
    static func getAlternativeLocationNameByCoordinates(completion: @escaping ITVNewCityErrorHandler) {
        
        var errorMessage: Error?
        
        print("\(Date())------> IntervalTimerCity getCityAlternativeInfoByCoordinates()")
        guard let theLatitude = ITVCoreLocation.sharedInstance.thisLatitude else {
            print("------> IntervalTimerCity getCityAlternativeInfoByCoordinates() GetCityIdError.latitudeIsNil")
            errorMessage = ITVError.GetCityId_LatitudeIsNil(reason: "Latitude is nil")
            completion(errorMessage)
            return
        }
        
        guard let theLongitude = ITVCoreLocation.sharedInstance.thisLongitude else {
            print("------> IntervalTimerCity getCityAlternativeInfoByCoordinates() GetCityIdError.longitudeIsNil")
            errorMessage = ITVError.GetCityId_LongitudeIsNil(reason: "Longitude is nil")
            completion(errorMessage)
            return
        }
        
        let cityService = ITVCityService(apiKey: MapQuestApi.key, providerUrl: MapQuestApi.baseUrl)
        do {
            try cityService?.getCityNameAt(latitude: theLatitude, longitude: theLongitude)
        } catch let error {
            print("------> ERROR IntervalTimerCity getCityAlternativeInfoByCoordinates() -> \(error)")
            errorMessage = ITVError.GetCityId_NoCityName(reason: "No city name found at latitude \(theLatitude) and longitude \(theLongitude). Error is \(error)")
            completion(errorMessage)
            return
        }
    }
}
