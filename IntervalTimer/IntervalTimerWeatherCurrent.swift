//
//  IntervalTimerWeatherCurrent.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-02.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

//TODO: Change this to a struct, we dont want to pass around copies of this
class IntervalTimerCurrentWeather: NSObject {
    
    //MARK: - fileprivate properties
    fileprivate var kelvin: Double? //source (JSON) gives temperature in kelvins
    fileprivate var temperature: String?
    fileprivate var icon: String?
    
    //MARK: - public get/set properties
    var thisTemperature: String?{
        get {
            return convertTemperature(kelvins: thisKelvin, forUnits: IntervalTimerUser.sharedInstance.thisTemperatureUnit)
        }
    }
    var thisIcon: String?{
        get {
            return icon
        }
        set {
            icon = ICON_DICTIONARY[newValue!]
            UserDefaults.standard.set(newValue, forKey: "icon")
            UserDefaults.standard.synchronize()
        }
    }
    var thisKelvin: Double?{
        get { return kelvin}
        set {
            kelvin = newValue
            UserDefaults.standard.set(newValue, forKey: "kelvin")
            UserDefaults.standard.synchronize()
        }
    }
    
    //MARK: - Initializers
    init?(kelvin: Double?, icon: String?){
        guard  let theKelvin = kelvin else {
            return nil
        }
        
        guard let theIcon = icon else {
            return nil
        }
        
        self.kelvin = theKelvin
        self.icon = ICON_DICTIONARY[theIcon]
    }
    public init(json: [String: Any]) throws {
        
        guard let theMain = json["main"] as? [String: Any] else {
            throw JsonError.missing("json key main")
        }
        guard let theKelvin = theMain["temp"] as? Double else {
            throw JsonError.missing("json key temp")
        }
        guard let theWeatherArray = json["weather"] as? [[String: AnyObject]] else {
            throw JsonError.missing("json key weather")
        }
        guard let theIcon = theWeatherArray[0]["icon"] as? String else {
            throw JsonError.missing("json key icon")
        }
        self.kelvin = theKelvin
        self.icon = ICON_DICTIONARY[theIcon]
    }
    
    //MARK: - NSCoding protocol methods
    func encode(with coder: NSCoder){
        coder.encode(self.thisKelvin, forKey: "kelvin")
        coder.encode(self.thisIcon, forKey: "icon")
    }
    required init(coder decoder: NSCoder) {
        if let theKelvin = decoder.decodeDouble(forKey: "kelvin") as Double? {
            kelvin = theKelvin
        }
        if let theIcon = decoder.decodeObject(forKey: "icon") as! String? {
            icon = theIcon
        }
    }
}

//MARK: - Temperature conversions
extension IntervalTimerCurrentWeather{
    func convertTemperature(kelvins: Double?, forUnits temperatureUnit: TemperatureUnit?) -> String? {
        guard let theKelvin = kelvins else {
            return nil
        }
        
        guard let theTemperatureUnit = temperatureUnit else {
            return nil
        }
        
        switch theTemperatureUnit {
        case .kelvin :
            return "\(Int(theKelvin))\(DEGREE)K"
        case .fahrenheit:
            return "\(Int(theKelvin - 459.67))\(DEGREE)F"
        case .celcius:
            return "\(Int(theKelvin - 273.15))\(DEGREE)C"
        }
    }
}
//MARK: - Weather Retreival Static Functions
extension IntervalTimerCurrentWeather{
    static func getWeatherByPriority(){
        
        print("------> IntervalTimerCurrentWeather getWeatherByPriority() thisDidCompleteLocationDetermination = \(String(describing: IntervalTimerCoreLocation.sharedInstance.thisDidCompleteLocationDetermination))")
        
        if IntervalTimerCoreLocation.sharedInstance.thisDidCompleteLocationDetermination! {
            
            let getWeather_WorkItem = DispatchWorkItem {//get city id by cl info failed, get alternative info from mapquest
                switch IntervalTimerUser.sharedInstance.weatherQueryPriority() {
                case WeatherQueryPriority.byCityId.rawValue:
                    print("------> IntervalTimerCurrentWeather getWeatherByPriority() byCityId")
                    do {
                        try getWeatherByCityId()
                    } catch let error {
                        print("------> ERROR IntervalTimerCurrentWeather getWeatherByPriority() byCityId -> \(error)")
                    }
                case WeatherQueryPriority.byLocationName.rawValue:
                    print("------> IntervalTimerCurrentWeather getWeatherByPriority() byLocationName)")
                    do {
                        try getWeatherByLocationName()
                    } catch let error {
                        print("------> ERROR IntervalTimerCurrentWeather getWeatherByPriority() byLocationName -> \(error)")
                    }
                case WeatherQueryPriority.byCoordinates.rawValue:
                    print("------> IntervalTimerCurrentWeather getWeatherByPriority() byCoordinates)")
                    do {
                        try getWeatherByCoordinates()
                    } catch let error {
                        print("------> ERROR IntervalTimerCurrentWeather getWeatherByPriority() byLocationName -> \(error)")
                    }
                default:
                    //TODO: if user wanted to have the weather, and we cant get it, then show a no-connection error icon in place of the weather
                    //Msg option 1 - "It is impossible to determine your location at the moment and give you the weather."
                    //Msg option 2 - "...
                    print("------> IntervalTimerCurrentWeather getWeatherByPriority() unable to retreive temperature")
                }
            }
            
            UTILITY_GLOBAL_DISPATCHQUEUE.async(execute: getWeather_WorkItem)
            
            getWeather_WorkItem.notify(queue: DispatchQueue.main) {
                print("------> ERROR IntervalTimerCurrentWeather getWeatherByPriority() getWeather_WorkItem completed")
            }
        }
    }
    
    static func getWeatherByCityId() throws {
        
        guard let thisShouldUpdateWeeather = IntervalTimerUser.sharedInstance.thisShouldUpdateWeather, thisShouldUpdateWeeather else {
            throw GetWeatherError.shouldNotUpdateWeather(reason: "Should Update Weather = \(String(describing: IntervalTimerUser.sharedInstance.thisShouldUpdateWeather))")
        }
        
        guard let theCityId = IntervalTimerCoreLocation.sharedInstance.thisCityId else {
            throw GetWeatherError.noWeatherForCityId(reason: " CityId = \(String(describing: IntervalTimerCoreLocation.sharedInstance.thisCityId))")
        }
        
        print("------> IntervalTimerCurrentWeather getWeatherByCityId()")
        //TODO: allow this weather get attempt to complete
        let weatherService = IntervalTimerWeatherService(apiKey: OpenWeatherApi.key, providerUrl: OpenWeatherApi.baseUrl)

        do{
            try weatherService?.getWeatherFor(theCityId)
        } catch let error {
            print("------> ERROR IntervalTimerCurrentWeather getWeatherByCityId() -> \(error)")
            //getting the weather by city ID did not succeed, try priority 2
            do {
                try getWeatherByLocationName()
            } catch let error {
                print("------> ERROR IntervalTimerCurrentWeather getWeatherByCityId() getWeatherByLocationName() -> \(error)")
            }
        }
    }
    static func getWeatherByLocationName() throws {
        guard let thisShouldUpdateWeeather = IntervalTimerUser.sharedInstance.thisShouldUpdateWeather, thisShouldUpdateWeeather else {
            throw GetWeatherError.shouldNotUpdateWeather(reason: "Should Update Weather = \(String(describing: IntervalTimerUser.sharedInstance.thisShouldUpdateWeather))")
        }
        
        guard let theCityName = IntervalTimerCoreLocation.sharedInstance.thisCityName else {
            throw GetWeatherError.noWeatherForLocationName(reason: " City Name = \(String(describing: IntervalTimerCoreLocation.sharedInstance.thisCityName))")
        }
        
        guard let theCountryCode = IntervalTimerCoreLocation.sharedInstance.thisCountryCode else {
            throw GetWeatherError.noWeatherForLocationName(reason: " Country Code = \(String(describing: IntervalTimerCoreLocation.sharedInstance.thisCountryCode))")
        }
        
        print("------> IntervalTimerCurrentWeather getWeatherByLocationName() theCityName= \(theCityName), theCountryCode= \(theCountryCode)")

        let weatherService = IntervalTimerWeatherService(apiKey: OpenWeatherApi.key, providerUrl: OpenWeatherApi.baseUrl)
        
        do{
            try weatherService?.getWeatherFor(theCityName, in: theCountryCode)
        } catch let error {
            print("------> ERROR IntervalTimerCurrentWeather getWeatherByLocationName() -> \(error)")
            //getting the weather by city name and country code did not succeed, try with coordinates
            do {
                try getWeatherByCoordinates()
            } catch let error {
                print("------> ERROR IntervalTimerCurrentWeather getWeatherByLocationName() getWeatherByCoordinates() -> \(error)")
            }
        }
    }
    static func getWeatherByCoordinates() throws {
        
        guard let thisShouldUpdateWeeather = IntervalTimerUser.sharedInstance.thisShouldUpdateWeather, thisShouldUpdateWeeather else {
            throw GetWeatherError.shouldNotUpdateWeather(reason: "Should Update Weather = \(String(describing: IntervalTimerUser.sharedInstance.thisShouldUpdateWeather))")
        }
        
        guard let theLatitude = IntervalTimerCoreLocation.sharedInstance.thisLatitude else {
            throw GetWeatherError.noWeatherForCoordinates(reason: " Latitude = \(String(describing: IntervalTimerCoreLocation.sharedInstance.thisLatitude))")
        }
        
        guard let theLongitude = IntervalTimerCoreLocation.sharedInstance.thisLongitude else {
            throw GetWeatherError.noWeatherForCoordinates(reason: " Longitude = \(String(describing: IntervalTimerCoreLocation.sharedInstance.thisLongitude))")
        }
        
        let weatherService = IntervalTimerWeatherService(apiKey: OpenWeatherApi.key, providerUrl: OpenWeatherApi.baseUrl)
        
        do{
            try weatherService?.getWeatherAt(latitude: theLatitude, longitude: theLongitude)
        } catch let error {
            print("------> ERROR IntervalTimerCurrentWeather getWeatherByCoordinates() -> \(error)")
        }
    }
}
