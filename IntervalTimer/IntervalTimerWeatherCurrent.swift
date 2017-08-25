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
            print("------> IntervalTimerCurrentWeather getWeatherByPriority() weatherQueryPriority() = \(IntervalTimerUser.sharedInstance.weatherQueryPriority())")
            
            switch IntervalTimerUser.sharedInstance.weatherQueryPriority() {
            case WeatherQueryPriority.byCityId.rawValue:
                getWeatherByCityId()
            case WeatherQueryPriority.byLocationName.rawValue:
                getWeatherByLocationName()
            case WeatherQueryPriority.byCoordinates.rawValue:
                getWeatherByCoordinates()
            default:
                //TODO: if user wanted to have the weather, and we cant get it, then show a no-connection error icon in place of the weather
                //Msg option 1 - "It is impossible to determine your location at the moment and give you the weather."
                //Msg option 2 - "...
                print("------> IntervalTimerCurrentWeather getWeatherByPriority() unable to retreive temperature")
            }
        }
    }
    
    static func getWeatherByCityId(){
        
        guard let thisShouldUpdateWeeather = IntervalTimerUser.sharedInstance.thisShouldUpdateWeather, thisShouldUpdateWeeather else {
            return
        }
        
        guard let theCityId = IntervalTimerUser.sharedInstance.thisCityId else {
            return
        }
        
        print("------> IntervalTimerCurrentWeather getWeatherByCityId()")
        //TODO: allow this weather get attempt to complete
        let weatherService = IntervalTimerWeatherService(apiKey: OpenWeatherApi.key, providerUrl: OpenWeatherApi.baseUrl)
        
        guard let didGetCurrentWeather = weatherService?.getWeatherFor(theCityId) else {
            return
        }
        
        if !didGetCurrentWeather {
            //getting the weather by city ID did not succeed, try priority 2
            //NotificationCenter.default.post(name: Notification.Name(rawValue: "didGetCityAndCountryShortName"), object: nil)
            getWeatherByLocationName()
        }
    }
    static func getWeatherByLocationName(){
        guard let thisShouldUpdateWeeather = IntervalTimerUser.sharedInstance.thisShouldUpdateWeather, thisShouldUpdateWeeather else {
            return
        }
        
        guard let theCityName = IntervalTimerUser.sharedInstance.thisCityName else {
            return
        }
        
        guard let theCountryCode = IntervalTimerUser.sharedInstance.thisCountryCode else {
            return
        }
        
        print("------> IntervalTimerCurrentWeather getWeatherByLocationName() theCityName= \(theCityName), theCountryCode= \(theCountryCode)")
        
        let weatherService = IntervalTimerWeatherService(apiKey: OpenWeatherApi.key, providerUrl: OpenWeatherApi.baseUrl)
        let didGetCurrentWeather = weatherService?.getWeatherFor(theCityName, in: theCountryCode)
        
        if didGetCurrentWeather == nil || !didGetCurrentWeather! {
            //getting the weather by city name and country code did not succeed
            getWeatherByCoordinates()
        }
    }
    static func getWeatherByCoordinates(){
        
        guard let thisShouldUpdateWeeather = IntervalTimerUser.sharedInstance.thisShouldUpdateWeather, thisShouldUpdateWeeather else {
            return
        }
        
        guard let theLatitude = IntervalTimerUser.sharedInstance.thisLatitude else {
            return
        }
        
        guard let theLongitude = IntervalTimerUser.sharedInstance.thisLongitude else {
            return
        }
        
        let weatherService = IntervalTimerWeatherService(apiKey: OpenWeatherApi.key, providerUrl: OpenWeatherApi.baseUrl)
        _ = weatherService?.getWeatherAt(latitude: theLatitude, longitude: theLongitude)
        
    }
}
