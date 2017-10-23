//
//  ITVCurrentWeatherRetreival.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-06.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

//MARK: - Weather Retreival Static Functions
extension ITVCurrentWeather {
    static func getWeatherByPriority() throws {
        
        print("------> ITVCurrentWeather getWeatherByPriority() thisDidCompleteLocationDetermination = \(String(describing: ITVCoreLocation.sharedInstance.thisDidCompleteLocationDetermination))")
        
        var errorGettingWeather: Error?
        if ITVCoreLocation.sharedInstance.thisDidCompleteLocationDetermination! {
            
            let request_WorkItem = DispatchWorkItem {//get city id by cl info failed, get alternative info from mapquest
            
                switch ITVUser.sharedInstance.weatherQueryPriority() {
                case WeatherQueryPriority.byCityId.rawValue:
                    print("------> ITVCurrentWeather getWeatherByPriority() byCityId")
                    do {
                        try getWeatherByCityId()
                        errorGettingWeather = nil
                    } catch let error {
                        print("------> ERROR ITVCurrentWeather getWeatherByPriority() byCityId -> \(error)")
                        errorGettingWeather = error
                    }
                case WeatherQueryPriority.byLocationName.rawValue:
                    print("------> ITVCurrentWeather getWeatherByPriority() byLocationName")
                    do {
                        try getWeatherByLocationName()
                        errorGettingWeather = nil
                    } catch let error {
                        print("------> ERROR ITVCurrentWeather getWeatherByPriority() byLocationName -> \(error)")
                        errorGettingWeather = error
                    }
                case WeatherQueryPriority.byCoordinates.rawValue:
                    print("------> ITVCurrentWeather getWeatherByPriority() byCoordinates")
                    do {
                        try getWeatherByCoordinates()
                        errorGettingWeather = nil
                    } catch let error {
                        print("------> ERROR ITVCurrentWeather getWeatherByPriority() byLocationName -> \(error)")
                        errorGettingWeather = error
                    }
                default:
                    //TODO: UI - > if user wanted to have the weather, and we cant get it, then show a no-connection error icon in place of the warning icon
                    //Msg option 1 - "It is impossible to determine your location at the moment and give you the weather."
                    //Msg option 2 - "...
                    print("------> ITVCurrentWeather getWeatherByPriority() unable to retreive temperature")
                    if ITVCoreLocation.sharedInstance.thisError != nil {
                        errorGettingWeather = ITVCoreLocation.sharedInstance.thisError
                    } else {
                        errorGettingWeather = ITVError.GetWeather_NoWeatherForUnknownReason(reason: "Weather priority was set to none and ITVCoreLocation.sharedInstance.thisError is nil")
                    }
                }
            }
            
            print("------> ITVCurrentWeather getWeatherByPriority() getWeather_WorkItem = request_WorkItem")
            getWeather_WorkItem = request_WorkItem
            print("------> ITVCurrentWeather getWeatherByPriority() executing getWeather_WorkItem")
            UTILITY_GLOBAL_DISPATCHQUEUE.async(execute: getWeather_WorkItem!)
            
            getWeather_WorkItem!.notify(queue: DispatchQueue.main) {
                print("------> ITVCurrentWeather getWeatherByPriority() getWeather_WorkItem completed")
            }
            
            //TODO: This is a buggy way of throwing the error, not sure it will ever be thrown since it is assigned async (see above)
            if errorGettingWeather != nil {
                throw errorGettingWeather!
            }
        }
    }
    
    static func cancelGetWeather() {
        //TODO: should I throw an error from here?
        print("------> ITVCurrentWeather cancelGetWeather()")
        if getWeather_WorkItem != nil {
            print("------> ITVCurrentWeather cancelGetWeather() canceling getWeather_WorkItem")
            getWeather_WorkItem?.cancel()
        }
    }
    
    static func getWeatherByCityId() throws {
        
        guard ITVUser.sharedInstance.thisShouldUpdateWeather else {
            throw ITVError.GetWeather_ShouldNotUpdateWeather(reason: "Should Update Weather = \(String(describing: ITVUser.sharedInstance.thisShouldUpdateWeather))")
        }
        
        guard let theCityId = ITVCoreLocation.sharedInstance.thisCityId else {
            throw ITVError.GetWeather_NoWeatherForCityId(reason: " CityId = \(String(describing: ITVCoreLocation.sharedInstance.thisCityId))")
        }
        
        print("------> ITVCurrentWeather getWeatherByCityId()")
        let weatherService = ITVWeatherService(apiKey: OpenWeatherApi.key, providerUrl: OpenWeatherApi.baseUrl)
        
        do{
            try weatherService?.getWeatherFor(theCityId)
        } catch let error {
            print("------> ERROR ITVCurrentWeather getWeatherByCityId() -> \(error)")
            //getting the weather by city ID did not succeed, try priority 2
            do {
                try getWeatherByLocationName()
            } catch let error {
                print("------> ERROR ITVCurrentWeather getWeatherByCityId() getWeatherByLocationName() -> \(error)")
            }
        }
    }
    static func getWeatherByLocationName() throws {
        guard ITVUser.sharedInstance.thisShouldUpdateWeather else {
            throw ITVError.GetWeather_ShouldNotUpdateWeather(reason: "Should Update Weather = \(String(describing: ITVUser.sharedInstance.thisShouldUpdateWeather))")
        }
        
        guard let theCityName = ITVCoreLocation.sharedInstance.thisCityName else {
            throw ITVError.GetWeather_NoWeatherForLocationName(reason: " City Name = \(String(describing: ITVCoreLocation.sharedInstance.thisCityName))")
        }
        
        guard let theCountryCode = ITVCoreLocation.sharedInstance.thisCountryCode else {
            throw ITVError.GetWeather_NoWeatherForLocationName(reason: " Country Code = \(String(describing: ITVCoreLocation.sharedInstance.thisCountryCode))")
        }
        
        print("------> ITVCurrentWeather getWeatherByLocationName() theCityName= \(theCityName), theCountryCode= \(theCountryCode)")
        
        let weatherService = ITVWeatherService(apiKey: OpenWeatherApi.key, providerUrl: OpenWeatherApi.baseUrl)
        
        do{
            try weatherService?.getWeatherFor(theCityName, in: theCountryCode)
        } catch let error {
            print("------> ERROR ITVCurrentWeather getWeatherByLocationName() -> \(error)")
            //getting the weather by city name and country code did not succeed, try with coordinates
            do {
                try getWeatherByCoordinates()
            } catch let error {
                print("------> ERROR ITVCurrentWeather getWeatherByLocationName() getWeatherByCoordinates() -> \(error)")
            }
        }
    }
    static func getWeatherByCoordinates() throws {
        
        guard ITVUser.sharedInstance.thisShouldUpdateWeather else {
            throw ITVError.GetWeather_ShouldNotUpdateWeather(reason: "Should Update Weather = \(String(describing: ITVUser.sharedInstance.thisShouldUpdateWeather))")
        }
        
        guard let theLatitude = ITVCoreLocation.sharedInstance.thisLatitude else {
            throw ITVError.GetWeather_NoWeatherForCoordinates(reason: " Latitude = \(String(describing: ITVCoreLocation.sharedInstance.thisLatitude))")
        }
        
        guard let theLongitude = ITVCoreLocation.sharedInstance.thisLongitude else {
            throw ITVError.GetWeather_NoWeatherForCoordinates(reason: " Longitude = \(String(describing: ITVCoreLocation.sharedInstance.thisLongitude))")
        }
        
        let weatherService = ITVWeatherService(apiKey: OpenWeatherApi.key, providerUrl: OpenWeatherApi.baseUrl)
        
        do{
            try weatherService?.getWeatherAt(latitude: theLatitude, longitude: theLongitude)
        } catch let error {
            print("------> ERROR ITVCurrentWeather getWeatherByCoordinates() -> \(error)")
        }
    }
}
