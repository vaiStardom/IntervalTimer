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
    static func getCityByCoordinates(){
        
        guard let theLatitude = IntervalTimerUser.sharedInstance.thisLatitude else {
            return
        }
        
        guard let theLongitude = IntervalTimerUser.sharedInstance.thisLongitude else {
            return
        }
        
        print("--------> IntervalTimerCity getCityByCoordinates()")
        let cityService = IntervalTimerCityService(apiKey: MapQuestApi.key, providerUrl: MapQuestApi.baseUrl)
        _ = cityService?.getCityAt(latitude: theLatitude, longitude: theLongitude)
    }
}
