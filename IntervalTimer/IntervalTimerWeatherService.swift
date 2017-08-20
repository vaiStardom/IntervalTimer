//
//  IntervalTimerWeatherService.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-02.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

struct IntervalTimerWeatherService {
    
    internal var apiKey: String                      //448af267f0d35a22b6e00178e163deb3
    internal var providerUrl: String                 //http://api.openweathermap.org/data/2.5/weather?
    
    var thisApiKey: String {
        get { return apiKey }
    }
    var thisProviderUrl: String {
        get { return providerUrl }
    }
    
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
