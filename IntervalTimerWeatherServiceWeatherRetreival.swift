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
            throw ITVError.GetWeather_UrlIsNil(reason: " URL = \(providerUrl)id=\(cityId)&APPID=\(apiKey)")
//            throw GetWeatherError.urlIsNil(reason: " URL = \(providerUrl)id=\(cityId)&APPID=\(apiKey)")
        }
        do {
            try getWeatherWith(theUrl)
        } catch let error {
            print("------> ERROR IntervalTimerWeatherService getWeatherFor(cityId:) -> \(error)")
            throw error
        }
    }
    
    //Second attempt to get weather for the city and country (ISO 3166) of user if possible
    //http://api.openweathermap.org/data/2.5/weather?q=Mataram,id&APPID=448af267f0d35a22b6e00178e163deb3
    //Mataram,id (ISO 3166)
    func getWeatherFor(_ cityName: String, in countryCode: String) throws {
        guard let theUrl = URL(string: "\(providerUrl)q=\(cityName),\(countryCode.lowercased())&APPID=\(apiKey)") else {
            throw ITVError.GetWeather_UrlIsNil(reason: " URL = \(providerUrl)q=\(cityName),\(countryCode.lowercased())&APPID=\(apiKey)")
//            throw GetWeatherError.urlIsNil(reason: " URL = \(providerUrl)q=\(cityName),\(countryCode.lowercased())&APPID=\(apiKey)")
        }
        do {
            try getWeatherWith(theUrl)
        } catch let error {
            print("------> ERROR IntervalTimerWeatherService getWeatherFor(cityId:) -> \(error)")
            throw error
        }
    }
    
    //Third, attempt to get weather for user using coordinates
    //api.openweathermap.org/data/2.5/weather?lat=-8.549790&lon=116.072037&APPID=448af267f0d35a22b6e00178e163deb3
    //http://api.openweathermap.org/data/2.5/weather?lat=-8.549790&lon=116.072037&APPID=448af267f0d35a22b6e00178e163deb3
    //-8.549790, 116.072037
    func getWeatherAt(latitude: Double, longitude: Double) throws {
        guard let theUrl = URL(string: "\(providerUrl)lat=\(latitude)&lon=\(longitude)&APPID=\(apiKey)") else {
            throw ITVError.GetWeather_UrlIsNil(reason: " URL = \(providerUrl)lat=\(latitude)&lon=\(longitude)&APPID=\(apiKey)")
//            throw GetWeatherError.urlIsNil(reason: " URL = \(providerUrl)lat=\(latitude)&lon=\(longitude)&APPID=\(apiKey)")
        }
        do {
            try getWeatherWith(theUrl)
        } catch let error {
            print("------> ERROR IntervalTimerWeatherService getWeatherFor(cityId:) -> \(error)")
            throw error
        }
    }

    private func getWeatherWith(_ url: URL) throws {
        
        guard let theUrl = url as URL? else {
            throw ITVError.GetWeather_UrlIsNil(reason: " URL = \(url)")
//            throw GetWeatherError.urlIsNil(reason: " URL = \(url)")
        }
        
        var didGetCurrentWeather = true
        var error: Error?
        fromNetwork(with: theUrl) { (itvWeatherServiceHandler) in
            
            guard itvWeatherServiceHandler.1 == nil else {
                error = itvWeatherServiceHandler.1
                didGetCurrentWeather = false
                return
            }
            
            guard let theCurrentWeather = itvWeatherServiceHandler.0 else {
                error = ITVError.GetWeather_DidNotGetWeather(reason: "Could not create the weather object.")
//                error = GetWeatherError.didNotGetWeather(reason: "Could not create the weather object.")
                didGetCurrentWeather = false
                return
            }
            
            guard theCurrentWeather.thisTemperature != nil else {
                print("------> IntervalTimerWeatherService getWeather() guard let theTemperature = nil")
                error = ITVError.GetWeather_DidNotGetWeather(reason: "The temperature is nil.")
//                error = GetWeatherError.didNotGetWeather(reason: "The temperature is nil.")
                didGetCurrentWeather = false
                return
            }
            
            guard theCurrentWeather.thisIcon != nil else {
                print("------> IntervalTimerWeatherService getWeather() guard let theIcon = nil")
                error = ITVError.GetWeather_DidNotGetWeather(reason: "The icon is nil.")
//                error = GetWeatherError.didNotGetWeather(reason: "The icon is nil.")
                didGetCurrentWeather = false
                return
            }
            
            didGetCurrentWeather = true
            DispatchQueue.main.async(execute: {
                print("------> IntervalTimerWeatherService getWeatherWith(url:) = \(String(describing: theCurrentWeather.thisTemperature))")
                ITVUser.sharedInstance.thisCurrentWeather = theCurrentWeather
                NotificationCenter.default.post(name: Notification.Name(rawValue: "didGetCurrentWeather"), object: nil)
            })
        }
        
        if didGetCurrentWeather == false, error != nil {
            throw error!
            //throw GetWeatherError.didNotGetWeather(reason: "Could not get weather from URL \(theUrl) ")
        }
    }

//    private func getWeatherWith(_ url: URL) throws {
//        
//        guard let theUrl = url as URL? else {
//            throw GetWeatherError.urlIsNil(reason: " URL = \(url)")
//        }
//        
//        var didGetCurrentWeather: Bool?
//        
//        fromNetwork(with: theUrl) { (intervalTimerCurrentWeather) in
//            
//            guard let theCurrentWeather = intervalTimerCurrentWeather else {
//                didGetCurrentWeather = false
//                return
//            }
//            
//            guard theCurrentWeather.thisTemperature != nil else {
//                print("------> IntervalTimerWeatherService getWeather() guard let theTemperature = nil")
//                didGetCurrentWeather = false
//                return
//            }
//            
//            guard theCurrentWeather.thisIcon != nil else {
//                print("------> IntervalTimerWeatherService getWeather() guard let theIcon = nil")
//                didGetCurrentWeather = false
//                return
//            }
//            
//            didGetCurrentWeather = true
//            DispatchQueue.main.async(execute: {
//                print("------> IntervalTimerWeatherService getWeatherWith(url:) = \(String(describing: theCurrentWeather.thisTemperature))")
//                ITVUser.sharedInstance.thisCurrentWeather = theCurrentWeather
//                
//                NotificationCenter.default.post(name: Notification.Name(rawValue: "didGetCurrentWeather"), object: nil)
//            })
//        }
//        
//        if didGetCurrentWeather == false {
//            throw GetWeatherError.didNotGetWeather(reason: "Could not get weather from URL \(theUrl) ")
//        }
//    }
    
    //MARK: - Typealias
    typealias ITVWeatherServiceHandler = ((ITVCurrentWeather?, Error?) -> Void)
    
    private func fromNetwork(with url: URL, completion: @escaping ITVWeatherServiceHandler){
        
        guard let theNetworkJson = IntervalTimerDownloadJSON(url: url) else {
//            completion(nil, JsonError.missing("The JSON is nil."))
            completion(nil, ITVError.JSON_Missing("The JSON is nil."))
            return
        }
        
        theNetworkJson.downloadJSON({ (jsonHandler) in
            
            guard jsonHandler.1 == nil else {
                completion(nil, jsonHandler.1)
                return
            }
            
            do {
                let theWeather = try ITVCurrentWeather(json: jsonHandler.0!)
                completion(theWeather, nil)
            } catch let error {
                print("------> ERROR IntervalTimerWeatherService fromNetwork() -> \(error)")
                completion(nil, error)
            }
        })
    }
    
//    private func fromNetwork(with url: URL, completion: @escaping (IntervalTimerCurrentWeather?) -> Void ){
//        
//        guard let theNetworkJson = IntervalTimerDownloadJSON(url: url) else {
//            completion(nil)
//            return
//        }
//        
//        theNetworkJson.downloadJSON({ (json) in
//            
//            do {
//                let theWeather = try IntervalTimerCurrentWeather(json: json!)
//                guard theWeather.thisTemperature != nil else {
//                    completion(nil)
//                    return
//                }
//                guard theWeather.thisIcon != nil else {
//                    completion(nil)
//                    return
//                }
//                
//                completion(theWeather)
//            } catch let error {
//                print("------> ERROR IntervalTimerWeatherService fromNetwork() -> \(error)")
//                completion(nil)
//            }
//        })
//    }
}
