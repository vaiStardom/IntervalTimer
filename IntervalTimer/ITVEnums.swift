//
//  ITVEnums.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-02.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

//MARK: - CGRects
enum NavigationBarCgRect{
    static let AddImage = CGRect(x: 20, y: 13, width: 17.5, height: 17.5)
    static let BackImage = CGRect(x: 0, y: 13, width: 12, height: 21)
    static let BackLabel = CGRect(x: 18, y: 14, width: 55, height: 19)
    static let Buttons = CGRect(x: 0, y: 0, width: 65, height: 44)
    static let CancelButton = CGRect(x: 0, y: 0, width: 55, height: 44)
    static let CancelLabel = CGRect(x: 0, y: 14, width: 55, height: 19)
    static let Dummy = CGRect(x: 0, y: 0, width: 65, height: 44)
    static let EditLabel = CGRect(x: 0, y: 14, width: 30, height: 19)
    static let LeftLabel = CGRect(x: 0, y: 14, width: 65, height: 19)
    static let NewTimerTitle = CGRect(x: 0, y: 20, width: 86, height: 45)
    static let TimersEditLabel = CGRect(x: 40, y: 13, width: 30, height: 19)
    static let TimersLeftLabel = CGRect(x: 0, y: 14, width: 65, height: 19)
}
//MARK: - CSV
enum CsvControls{
    static let ColumnDelimiter: String = "\t"
    static let LineSeperator: String = "\n"
}
//MARK: - Errors
enum ITVError: Error {
    case CSV_ReadError(String)
    case CSV_Missing(String)
    case GetCityId_CityNameIsNil(reason: String)
    case GetCityId_CountryCodeIsNil(reason: String)
    case GetCityId_LatitudeIsNil(reason: String)
    case GetCityId_LongitudeIsNil(reason: String)
    case GetCityId_UrlIsNil(reason: String)
    case GetCityId_NoCityId(reason: String)
    case GetCityId_NoCityName(reason: String)
    case GetWeather_NoWeatherForCityId(reason: String)
    case GetWeather_NoWeatherForLocationName(reason: String)
    case GetWeather_NoWeatherForCoordinates(reason: String)
    case GetWeather_NoWeatherForUnknownReason(reason: String)
    case GetWeather_ShouldNotUpdateWeather(reason: String)
    case GetWeather_DidNotGetWeather(reason: String)
    case GetWeather_UrlIsNil(reason: String)
    case Http_UnsucessfulHttpResponse(code: String) //For a an http response code enum, look here: //https://gist.github.com/brennanMKE/482452bb9ac5f578907f413902753eec
    case JSON_UnsucessfulProcessing
    case JSON_Missing(String)
    case JSON_MissingTemperature
    case JSON_MissingIcon
    case URL_UnsucessfulUrl(reason: String)
    case Reachability_notReachable(reason: String)
}

enum UserWarning: Int {
    case AirPlaneModeEnabled
    case LocationManagerDidFail
    case LocationServicesDisabled
    case NoInternet
    case MissingTimerName
}
//MARK: - Fonts
enum SystemFont{
    static let Bold15: UIFont = UIFont.systemFont(ofSize: 15, weight: UIFontWeightBold)
    static let Bold17: UIFont = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
    static let Heavy35: UIFont = UIFont.systemFont(ofSize: 35, weight: UIFontWeightHeavy)
    static let HeavyMonospaced35: UIFont = UIFont.monospacedDigitSystemFont(ofSize: 35, weight: UIFontWeightHeavy)
    static let Light52: UIFont = UIFont.systemFont(ofSize: 52, weight: UIFontWeightLight)
    static let Regular13: UIFont = UIFont.systemFont(ofSize: 13, weight: UIFontWeightRegular)
    static let Regular15: UIFont = UIFont.systemFont(ofSize: 15, weight: UIFontWeightRegular)
    static let Regular17: UIFont = UIFont.systemFont(ofSize: 17, weight: UIFontWeightRegular)
    static let Regular19: UIFont = UIFont.systemFont(ofSize: 19, weight: UIFontWeightRegular)
    static let Regular28: UIFont = UIFont.systemFont(ofSize: 28, weight: UIFontWeightRegular)
    static let RegularMonospaced17: UIFont = UIFont.monospacedDigitSystemFont(ofSize: 17, weight: UIFontWeightRegular)
    static let SemiBold17: UIFont = UIFont.systemFont(ofSize: 17, weight: UIFontWeightSemibold)
    static let Thin60: UIFont = UIFont.systemFont(ofSize: 60, weight: UIFontWeightThin)
    static let UltralightMonospaced71: UIFont = UIFont.monospacedDigitSystemFont(ofSize: 71, weight: UIFontWeightUltraLight)
    static let UltralightMonospaced94: UIFont = UIFont.monospacedDigitSystemFont(ofSize: 94, weight: UIFontWeightUltraLight)
    static let UltralightMonospaced117: UIFont = UIFont.monospacedDigitSystemFont(ofSize: 117, weight: UIFontWeightUltraLight)
    static let Ultralight65: UIFont = UIFont.systemFont(ofSize: 65, weight: UIFontWeightUltraLight)
    static let Ultralight117: UIFont = UIFont.systemFont(ofSize: 117, weight: UIFontWeightUltraLight)
}
enum NavigationBarFont{
    static let LeftRight = SystemFont.Regular17
    static let Title = SystemFont.Regular28
    static let Temperature = SystemFont.Regular17
}
enum ViewFont{
    static let ContentLabel = SystemFont.Regular17
    static let Content = SystemFont.Regular28
    static let EditTime = SystemFont.Light52
    static let TimerHours =  SystemFont.UltralightMonospaced71
    static let TimerMinutes = SystemFont.UltralightMonospaced94
    static let TimerSeconds = SystemFont.UltralightMonospaced117
    static let TimerMilliseconds = SystemFont.HeavyMonospaced35
    static let TimerName = SystemFont.Heavy35
    static let TimerTemperature = SystemFont.Regular17
    static let TimersName = SystemFont.Thin60
    static let WarningBold = SystemFont.Bold17
}
enum WidgetFont{
    static let TimersName = SystemFont.Regular19
    static let Time = SystemFont.Ultralight65
    static let Temperature = SystemFont.Regular13
}
enum NotificationFont{
    static let Title = SystemFont.Regular15
    static let Time = SystemFont.Regular15
    static let TimerName = SystemFont.Regular15
}
//MARK: - Image names
enum NavigationBarImage{
    static let Add = "barButtonAdd"
    static let Back = "barButtonBack"
}
public enum Indicator: Int {
    case Red = 0 //this order has to stay this way...
    case Green
    case Yellow
    case Blue
    case White
    case Pink
    case none
    
    func uiColor() -> UIColor {
        switch self {
        case .Blue:
            return UIColor(red: 45.0/255.0, green: 255.0/255.0, blue: 254.0/255.0, alpha: 1.0)
        case .Green:
            return UIColor(red: 0.0/255.0, green: 255.0/255.0, blue: 58.0/255.0, alpha: 1.0)
        case .Pink:
            return UIColor(red: 252.0/255.0, green: 34.0/255.0, blue: 211.0/255.0, alpha: 1.0)
        case .Red:
            return UIColor(red: 255.0/255.0, green: 17.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        case .Yellow:
            return UIColor(red: 255.0/255.0, green: 251.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        case .White:
            return UIColor(red: 243.0/255.0, green: 243.0/255.0, blue: 243.0/255.0, alpha: 1.0)
        case .none:
            return UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        }
    }
}
//MARK: - JSON Keys
enum JsonKeys{
    static let ITVCity_address = "address"
    static let ITVCity_city = "city"
    static let ITVCurrentWeather_icon = "icon"
    static let ITVCurrentWeather_main = "main"
    static let ITVCurrentWeather_temp = "temp"
    static let ITVCurrentWeather_weather = "weather"
}

//MARK: - MapQuest
enum MapQuestApi {
    static let key = "iaGiN8vTI73I5Kpa0YPrVVblLvjPAfYF"
    static let baseUrl = "http://open.mapquestapi.com/nominatim/v1/reverse.php?"
}
//MARK: - Reachability
enum ReachabilityStatus {
    case notReachable
    case reachableViaWWAN
    case reachableViaWiFi
}
//MARK: - Time types
enum TimeType: Int {
    case Seconds
    case Minutes
    case Hours    
    func toSeconds(from: Int?) -> Double {
        if let theFrom = from {
            let theTime = Double(theFrom)
            if theTime <= 0 {
                return 0.0
            } else {
                switch self {
                case .Seconds:
                    return theTime
                case .Minutes:
                    return theTime * 60.0
                case .Hours:
                    return theTime * 3600.0
                }
            }
        } else {
            return 0.0
        }
    }
}
//MARK: - UserDefaultKeys
enum UserDefaultsKey {
    static let ITVCoreLocation_cityId = "cityId"
    static let ITVCoreLocation_cityName = "cityName"
    static let ITVCoreLocation_countryCode = "countryCode"
    static let ITVCoreLocation_didCompleteLocationDetermination = "didCompleteLocationDetermination"
    static let ITVCoreLocation_firstTimeLocationService = "firstTimeLocationService"
    static let ITVCoreLocation_latitude = "latitude"
    static let ITVCoreLocation_longitude = "longitude"
    
    static let ITVCurrentWeather_icon = "icon"
    static let ITVCurrentWeather_kelvin = "kelvin"
    
    static let ITVInterval_indicator = "indicator"
    static let ITVInterval_seconds = "seconds"
    
    static let ITVTimer_name = "name"
    static let ITVTimer_showWeather = "showWeather"
    static let ITVTimer_temperatureUnit = "temperatureUnit"
    static let ITVTimer_intervals = "intervals"
    
    static let ITVUser_currentWeather = "currentWeather"
    static let ITVUser_lastWeatherUpdate = "lastWeatherUpdate"
    static let ITVUser_timers = "timers"
    
    
}
//MARK: - View Litterals
enum Litterals{
    static let Back = "Back"
    static let Cancel = "Cancel"
    static let Edit = "Edit"
    static let NewTimer = "Timer"
    static let NewInterval = "Interval"
    static let Save = "Save"
    static let TimerNamePlaceholder = "Enter name"
    static let Timers = "Timers:"
}
//MARK: - Weather
enum OpenWeatherApi {
    static let key = "448af267f0d35a22b6e00178e163deb3"
    static let baseUrl = "http://api.openweathermap.org/data/2.5/weather?"
}
public enum TemperatureUnit: Int { //has to be public for its use as a property of ITVTimer class
    case Kelvin = 0
    case Fahrenheit
    case Celcius
    
    func temperature(kelvins: Double?) -> String? {
        guard let theKelvins = kelvins else {
            return nil
        }
        switch self {
        case .Kelvin :
            return "\(Int(theKelvins))K"
        case .Fahrenheit:
            return "\(Int((theKelvins*(9/5)) - 459.67))\(DEGREE)F"
        case .Celcius:
            return "\(Int(theKelvins - 273.15))\(DEGREE)C"
        }
    }
}
enum WeatherDictionaryKey{
    static let temperature = "temp"
    static let weatherIcon = "icon"
}
enum WeatherQueryPriority: Int {
    case byCityId = 0
    case byLocationName
    case byCoordinates
    case none
}
