//
//  IntervalTimerWeatherService.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-02.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

class IntervalTimerWeatherService {
    
    fileprivate var apiKey: String                      //448af267f0d35a22b6e00178e163deb3
    fileprivate var weatherProviderUrlString: String
    fileprivate var baseUrl: URL?
    
    var thisApiKey: String {
        get { return apiKey }
    }

    var thisBaseUrl: URL? {
        get { return baseUrl }
    }

    var thisWeatherProviderUrlString: String {
        get { return weatherProviderUrlString }
    }

    init(apiKey: String, weatherProviderUrlString: String) {
        self.apiKey = apiKey
        self.weatherProviderUrlString = weatherProviderUrlString
        self.baseUrl = URL(string: "\(thisWeatherProviderUrlString)\(thisApiKey)")
    }
    
//    func getForecast(latitude: Double, longitude: Double, completion: @escaping 


}
