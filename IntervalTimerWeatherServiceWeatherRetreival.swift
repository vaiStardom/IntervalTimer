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
    func getWeatherFor(_ cityId: Int) -> Bool? {
        guard let theUrl = URL(string: "\(providerUrl)id=\(cityId)&APPID=\(apiKey)") else {
            return nil
        }
        return getWeatherWith(theUrl)
    }
    
    //Second attempt to get weather for the city and country (ISO 3166) of user if possible
    //http://api.openweathermap.org/data/2.5/weather?q=Mataram,id&APPID=448af267f0d35a22b6e00178e163deb3
    //Mataram,id (ISO 3166)
    func getWeatherFor(_ cityName: String, in countryCode: String) -> Bool? {
        guard let theUrl = URL(string: "\(providerUrl)q=\(cityName),\(countryCode.lowercased())&APPID=\(apiKey)") else {
            return nil
        }
        return getWeatherWith(theUrl)
    }
    
    //Third, attempt to get weather for user using coordinates
    //api.openweathermap.org/data/2.5/weather?lat=-8.549790&lon=116.072037&APPID=448af267f0d35a22b6e00178e163deb3
    //http://api.openweathermap.org/data/2.5/weather?lat=-8.549790&lon=116.072037&APPID=448af267f0d35a22b6e00178e163deb3
    //-8.549790, 116.072037
    func getWeatherAt(latitude: Double, longitude: Double) -> Bool? {
        guard let theUrl = URL(string: "\(providerUrl)lat=\(latitude)&lon=\(longitude)&APPID=\(apiKey)") else {
            return nil
        }
        return getWeatherWith(theUrl)
    }
    
    private func getWeatherWith(_ url: URL) -> Bool? {
        
        guard let theUrl = url as URL? else {
            return nil
        }
        
        var didGetCurrentWeather: Bool?
        
        fromNetwork(with: theUrl) { (intervalTimerCurrentWeather) in
            
            guard let theCurrentWeather = intervalTimerCurrentWeather else {
                didGetCurrentWeather = false
                return
            }
            
            DispatchQueue.main.async {
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
                IntervalTimerUser.sharedInstance.thisCurrentWeather = theCurrentWeather
                NotificationCenter.default.post(name: Notification.Name(rawValue: "didGetCurrentWeather"), object: nil)
            }
        }
        return didGetCurrentWeather
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
            } catch let error as NSError {
                print("ERROR -> IntervalTimerWeatherService fromNetwork() -> \(error.localizedDescription)")
                completion(nil)
            }
        })
    }
}
