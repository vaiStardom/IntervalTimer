//
//  IntervalTimerWeatherService.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-02.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

struct IntervalTimerWeatherService {
    
    fileprivate var apiKey: String                      //448af267f0d35a22b6e00178e163deb3
    fileprivate var providerUrl: String                 //http://api.openweathermap.org/data/2.5/weather?
    
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
    func getWeatherFor(_ cityId: Int) -> IntervalTimerCurrentWeather? {
        guard let theUrl = URL(string: "\(providerUrl)id=\(cityId)&APPID=\(apiKey)") else {
            return nil
        }
        return getWeatherWith(theUrl)
    }
    
    //Second attempt to get weather for the city and country (ISO 3166) of user if possible
    //http://api.openweathermap.org/data/2.5/weather?q=Mataram,id&APPID=448af267f0d35a22b6e00178e163deb3
    //Mataram,id (ISO 3166)
    func getWeatherFor(_ cityName: String, in countryCode: String) -> IntervalTimerCurrentWeather? {
        guard let theUrl = URL(string: "\(providerUrl)g=\(cityName),\(countryCode)id&APPID=\(apiKey)") else {
            return nil
        }
        return getWeatherWith(theUrl)
    }
    
    //Third, attempt to get weather for user using coordinates
    //api.openweathermap.org/data/2.5/weather?lat=-8.549790&lon=116.072037&APPID=448af267f0d35a22b6e00178e163deb3
    //http://api.openweathermap.org/data/2.5/weather?lat=-8.549790&lon=116.072037&APPID=448af267f0d35a22b6e00178e163deb3
    //-8.549790, 116.072037
    func getWeatherAt(latitude: Double, longitude: Double) -> IntervalTimerCurrentWeather? {
        guard let theUrl = URL(string: "\(providerUrl)lat=\(latitude)&lon=\(longitude)&APPID=\(apiKey)") else {
            return nil
        }
        return getWeatherWith(theUrl)
    }
    
    private func getWeatherWith(_ url: URL) -> IntervalTimerCurrentWeather? {
        
        guard let theUrl = url as URL? else {
            return nil
        }
        
        var currentWeather: IntervalTimerCurrentWeather?
        
        fromNetwork(with: theUrl) { (intervalTimerCurrentWeather) in
            
            guard let theCurrentWeather = intervalTimerCurrentWeather else {
                currentWeather = nil
                return
            }
            
            DispatchQueue.main.sync {
                guard theCurrentWeather.thisTemperature != nil else {
                    print("---------> IntervalTimerWeatherService getWeather() guard let theTemperature = nil")
                    currentWeather = nil
                    return
                }
                
                guard theCurrentWeather.thisIcon != nil else {
                    print("---------> IntervalTimerWeatherService getWeather() guard let theIcon = nil")
                    currentWeather = nil
                    return
                }
                
                print("---------> IntervalTimerWeatherService theTemperature = \(String(describing: theCurrentWeather.thisTemperature))")
                print("---------> IntervalTimerWeatherService theIcon = \(String(describing: theCurrentWeather.thisIcon))")
                
                currentWeather = theCurrentWeather
                IntervalTimerUser.sharedInstance.thisCurrentWeather = theCurrentWeather
                NotificationCenter.default.post(name: Notification.Name(rawValue: "didGetCurrentWeather"), object: nil)
            }
        }
        return currentWeather
    }
    
    private func fromNetwork(with url: URL, completion: @escaping (IntervalTimerCurrentWeather?) -> Void ){
        
        guard let theNetworkJson = IntervalTimerNetworkJSON(url: url) else {
            completion(nil)
            return
        }
        
        theNetworkJson.downloadJSON({ (jsonDictionary) in
            
            print("---------> IntervalTimerWeatherService fromNetwork theUrl = \(url)")
            let json4Swift_Base_list = Json4Swift_Base(dictionary: jsonDictionary! as NSDictionary)
            
            guard let theTemperature = json4Swift_Base_list?.main?.temp else {
                //throw JsonError.missingTemperature
                completion(nil)
                return
            }
            
            guard let theIcon = json4Swift_Base_list?.weather?.first?.icon else {
                //throw JsonError.missingIcon
                completion(nil)
                return
            }
            
            guard let theCurrentWeather = IntervalTimerCurrentWeather(kelvin: theTemperature, icon: theIcon) else {
                completion(nil)
                return
            }
            
            completion(theCurrentWeather)
            
        })
    }
}
