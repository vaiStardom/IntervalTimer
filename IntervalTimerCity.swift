//
//  IntervalTimerCity.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-31.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

public struct IntervalTimerCity {
    
    // MARK: - Properties
    private var name: String?
    
    //MARK: - public get/set properties
    public var thisName: String? {
        get { return name}
        set {
            name = newValue
        }
    }
    
    // MARK: - Initializers
    public init(name: String) {
        self.name = name
    }
    
    public init(json: [String: Any]) throws {
        guard let theAddress = json["address"] as? [String: String] else {
            throw JsonError.missing("json key address")
        }
        guard let theCity = theAddress["city"] else {
            throw JsonError.missing("json key city")
        }
        self.name = theCity
    }
}
//MARK: - Weather Retreival Static Functions
extension IntervalTimerCity{
    
    static func getCityAlternativeInfoByCoordinates() throws {
        
        print("------> IntervalTimerCity getCityAlternativeInfoByCoordinates()")
        guard let theLatitude = IntervalTimerCoreLocation.sharedInstance.thisLatitude else {
            print("------> IntervalTimerCity getCityAlternativeInfoByCoordinates() GetCityIdError.latitudeIsNil")
            throw GetCityIdError.latitudeIsNil(reason: "Latitude is nil")
        }
        
        guard let theLongitude = IntervalTimerCoreLocation.sharedInstance.thisLongitude else {
            print("------> IntervalTimerCity getCityAlternativeInfoByCoordinates() GetCityIdError.longitudeIsNil")
            throw GetCityIdError.longitudeIsNil(reason: "Longitude is nil")
        }
        
        var didGetCityName: Bool?
        let cityService = IntervalTimerCityService(apiKey: MapQuestApi.key, providerUrl: MapQuestApi.baseUrl)
        
        do {
            try cityService?.getCityNameAt(latitude: theLatitude, longitude: theLongitude)
        } catch let error {
            print("------> ERROR IntervalTimerCity getCityAlternativeInfoByCoordinates() -> \(error)")
            didGetCityName = false
        }
        
        if let theDidGetCityName = didGetCityName, theDidGetCityName == false {
            throw GetCityIdError.noCityName(reason: "No city name found at latitude \(theLatitude) and longitude \(theLongitude)")
        }
    }
}
