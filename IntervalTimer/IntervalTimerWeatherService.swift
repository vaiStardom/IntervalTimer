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
    fileprivate var providerUrl: String                 //http://api.openweathermap.org/data/2.5/weather?
    
    var thisApiKey: String {
        get { return apiKey }
    }
    var thisProviderUrl: String {
        get { return providerUrl }
    }
    
    init(apiKey: String, providerUrl: String) {
        self.apiKey = apiKey
        self.providerUrl = providerUrl
    }
}
//MARK: - Weather retreival management
extension IntervalTimerWeatherService {
    
    //TODO: Controll the number of times we get theweather (since it may cost).
    //The control should be with these steps:
    //Get weather when timer starts.
    //If user uses several timers in a row, get weather when user has moved 1KM and/or when 3 hours have elapsed.
    
    
    //First, attempt to get weather for the city ID of user if possible using city.list.json
    //api.openweathermap.org/data/2.5/weather?id=1635882&APPID=448af267f0d35a22b6e00178e163deb3
    //http://api.openweathermap.org/data/2.5/weather?id=1635882&APPID=448af267f0d35a22b6e00178e163deb3
    //{
    //    "id": 1635882,
    //    "name": "Mataram",
    //    "country": "ID",
    //    "coord": {
    //        "lon": 116.116669,
    //        "lat": -8.58333
    //    }
    //},
    func getWeatherFor(_ cityId: Int) -> Double? {
        if let theUrl = URL(string: "\(providerUrl)id=\(cityId)&APPID=\(apiKey)"){
            return getWeatherWith(theUrl)
        } else {
            return nil
        }
    }
    
    //Second attempt to get weather for the city and country (ISO 3166) of user if possible
    //http://api.openweathermap.org/data/2.5/weather?q=Mataram,id&APPID=448af267f0d35a22b6e00178e163deb3
    //Mataram,id (ISO 3166)
    func getWeatherFor(_ cityName: String, in countryCode: String) -> Double? {
        if let theUrl = URL(string: "\(providerUrl)g=\(cityName),\(countryCode)id&APPID=\(apiKey)"){
            return getWeatherWith(theUrl)
        } else {
            return nil
        }
    }
    
    //Third, attempt to get weather for user using coordinates
    //api.openweathermap.org/data/2.5/weather?lat=-8.549790&lon=116.072037&APPID=448af267f0d35a22b6e00178e163deb3
    //http://api.openweathermap.org/data/2.5/weather?lat=-8.549790&lon=116.072037&APPID=448af267f0d35a22b6e00178e163deb3
    //-8.549790, 116.072037
    func getWeatherAt(latitude: Double, longitude: Double) -> Double? {
        if let theUrl = URL(string: "\(providerUrl)lat=\(latitude)&lon=\(longitude)&APPID=\(apiKey)"){
            return getWeatherWith(theUrl)
        } else {
            return nil
        }
    }
    
    private func getWeatherWith(_ url: URL) -> Double? {
        var temperature: Double?
        
        fromNetwork(with: url) { (intervalTimerCurrentWeather) in
            if let theCurrentWeather = intervalTimerCurrentWeather {
                DispatchQueue.main.sync {
                    if let theTemperature = theCurrentWeather.thisTemperature, let theIcon = theCurrentWeather.thisIcon {
                        print("---------> IntervalTimerWeatherService theTemperature = \(theTemperature)")
                        print("---------> IntervalTimerWeatherService theIcon = \(theIcon)")
                        temperature = theTemperature
                    } else {
                        print("---------> IntervalTimerWeatherService getWeather() = nil")
                        temperature = nil
                    }
                }
            } else {
                temperature = nil
            }
        }
        return temperature
    }
    
    private func fromNetwork(with url: URL, completion: @escaping (IntervalTimerCurrentWeather?) -> Void ){
        let networkJson = IntervalTimerNetworkJSON(url: url)
        networkJson.downloadJSON({ (jsonDictionary) in
            
            print("---------> IntervalTimerWeatherService fromNetwork theUrl = \(url)")
            let json4Swift_Base_list = Json4Swift_Base(dictionary: jsonDictionary! as NSDictionary)
            
            guard let theTemperature = json4Swift_Base_list?.main?.temp else {
                completion(nil)
                return
            }
            
            guard let theIcon = json4Swift_Base_list?.weather?.first?.icon else {
                completion(nil)
                return
            }
            
            if let currentWeather = IntervalTimerCurrentWeather(temperature: theTemperature, icon: theIcon){
                completion(currentWeather)
            } else {
                completion(nil)
            }
        })
    }
}
