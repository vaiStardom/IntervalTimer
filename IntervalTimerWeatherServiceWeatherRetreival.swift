//
//  IntervalTimerWeatherServiceWeatherRetreival.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-20.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

//MARK: - Weather retreival management
extension IntervalTimerWeatherService {
    
    //TODO: Validate each weather retreival priority, by test cases:
    //case 1: a locality where there is no city id, but a city name and country code weather may be retreived
    //case 2: a locality where neither the city id, or locality name weather does not work, only coodinates
    
    //TODO: Controll the number of times we get theweather (since it may cost).
    //The control should be with these steps:
    //Get weather when timer starts.
    //If user uses several timers in a row, get weather when user has moved 1KM and/or when 3 hours have elapsed.
    
    //First, attempt to get weather for the city ID of user if possible using city.list.json
    //api.openweathermap.org/data/2.5/weather?id=1635882&APPID=448af267f0d35a22b6e00178e163deb3
    //http://api.openweathermap.org/data/2.5/weather?id=1635882&APPID=448af267f0d35a22b6e00178e163deb3
    func getWeatherFor(_ cityId: Int) throws {
        guard let theUrl = URL(string: "\(providerUrl)id=\(cityId)&APPID=\(apiKey)") else {
            throw GetWeatherError.urlIsNil(reason: " URL = \(providerUrl)id=\(cityId)&APPID=\(apiKey)")
        }
        do {
            try getWeatherWith(theUrl)
        } catch let error {
            print("------> ERROR IntervalTimerWeatherService getWeatherFor(cityId:) -> \(error)")
        }
    }
    
    //Second attempt to get weather for the city and country (ISO 3166) of user if possible
    //http://api.openweathermap.org/data/2.5/weather?q=Mataram,id&APPID=448af267f0d35a22b6e00178e163deb3
    //Mataram,id (ISO 3166)
    func getWeatherFor(_ cityName: String, in countryCode: String) throws {
        guard let theUrl = URL(string: "\(providerUrl)q=\(cityName),\(countryCode.lowercased())&APPID=\(apiKey)") else {
            throw GetWeatherError.urlIsNil(reason: " URL = \(providerUrl)q=\(cityName),\(countryCode.lowercased())&APPID=\(apiKey)")
        }
        do {
            try getWeatherWith(theUrl)
        } catch let error {
            print("------> ERROR IntervalTimerWeatherService getWeatherFor(cityId:) -> \(error)")
        }
    }
    
    //Third, attempt to get weather for user using coordinates
    //api.openweathermap.org/data/2.5/weather?lat=-8.549790&lon=116.072037&APPID=448af267f0d35a22b6e00178e163deb3
    //http://api.openweathermap.org/data/2.5/weather?lat=-8.549790&lon=116.072037&APPID=448af267f0d35a22b6e00178e163deb3
    //-8.549790, 116.072037
    func getWeatherAt(latitude: Double, longitude: Double) throws {
        guard let theUrl = URL(string: "\(providerUrl)lat=\(latitude)&lon=\(longitude)&APPID=\(apiKey)") else {
            throw GetWeatherError.urlIsNil(reason: " URL = \(providerUrl)lat=\(latitude)&lon=\(longitude)&APPID=\(apiKey)")
        }
        do {
            try getWeatherWith(theUrl)
        } catch let error {
            print("------> ERROR IntervalTimerWeatherService getWeatherFor(cityId:) -> \(error)")
        }
    }
    
    private func getWeatherWith(_ url: URL) throws {
        
        guard let theUrl = url as URL? else {
            throw GetWeatherError.urlIsNil(reason: " URL = \(url)")
        }
        
        var didGetCurrentWeather: Bool?
        
        fromNetwork(with: theUrl) { (intervalTimerCurrentWeather) in
            
            guard let theCurrentWeather = intervalTimerCurrentWeather else {
                didGetCurrentWeather = false
                return
            }
            
            guard theCurrentWeather.thisTemperature != nil else {
                print("------> IntervalTimerWeatherService getWeather() guard let theTemperature = nil")
                didGetCurrentWeather = false
                return
            }
            
            guard theCurrentWeather.thisIcon != nil else {
                print("------> IntervalTimerWeatherService getWeather() guard let theIcon = nil")
                didGetCurrentWeather = false
                return
            }
            
            didGetCurrentWeather = true
            DispatchQueue.main.async(execute: {
                print("------> IntervalTimerWeatherService getWeatherWith(url:) = \(String(describing: theCurrentWeather.thisTemperature))")
                IntervalTimerUser.sharedInstance.thisCurrentWeather = theCurrentWeather
                NotificationCenter.default.post(name: Notification.Name(rawValue: "didGetCurrentWeather"), object: nil)
            })
        }
        
        if didGetCurrentWeather == false {
            throw GetWeatherError.didNotGetWeather(reason: "Could not get weather from URL \(theUrl) ")
        }
    }
    
    private func fromNetwork(with url: URL, completion: @escaping (IntervalTimerCurrentWeather?) -> Void ){
        
        guard let theNetworkJson = IntervalTimerDownloadJSON(url: url) else {
            completion(nil)
            return
        }
        
        theNetworkJson.downloadJSON({ (json) in
            
            do {
                let theWeather = try IntervalTimerCurrentWeather(json: json!)
                guard theWeather.thisTemperature != nil else {
                    completion(nil)
                    return
                }
                guard theWeather.thisIcon != nil else {
                    completion(nil)
                    return
                }
                
                completion(theWeather)
            } catch let error {
                print("------> ERROR IntervalTimerWeatherService fromNetwork() -> \(error)")
                completion(nil)
            }
        })
    }
}
