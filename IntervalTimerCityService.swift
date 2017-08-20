//
//  IntervalTimerCityService.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-31.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

struct IntervalTimerCityService {
    
    //MARK: - fileprivate properties
    internal let cityWord = " city"
    internal var apiKey: String       //NOMINATIM - MapQuest //iaGiN8vTI73I5Kpa0YPrVVblLvjPAfYF
    internal var providerUrl: String  //NOMINATIM - MapQuest //http://open.mapquestapi.com/nominatim/v1/reverse.php?
    
    //MARK: - public get/set properties
    var thisApiKey: String {
        get { return apiKey }
    }
    
    var thisProviderUrl: String {
        get { return providerUrl }
    }
    
    //MARK: - Initializers
    init?(apiKey: String, providerUrl: String) {
        guard let theApiKey = apiKey as String? else {
            return nil
        }
        guard let theProviderUrl = providerUrl as String? else {
            return nil
        }
        self.apiKey = theApiKey
        self.providerUrl = theProviderUrl
    }
}

