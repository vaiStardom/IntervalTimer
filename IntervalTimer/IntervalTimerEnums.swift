//
//  IntervalTimerEnums.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-02.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

//MARK: - CGRects
enum NavigationBarCgRect{
    static let Dummy = CGRect(x: 0, y: 0, width: 65, height: 44)
    static let AddImage = CGRect(x: 20, y: 13, width: 17.5, height: 17.5)
    static let BackImage = CGRect(x: 0, y: 13, width: 12, height: 21)
    static let BackLabel = CGRect(x: 18, y: 14, width: 55, height: 19)
    static let Buttons = CGRect(x: 0, y: 0, width: 65, height: 44)
    static let CancelButton = CGRect(x: 0, y: 0, width: 55, height: 44)
    static let CancelLabel = CGRect(x: 0, y: 14, width: 55, height: 19)
    static let EditLabel = CGRect(x: 0, y: 14, width: 30, height: 19)
    static let LeftLabel = CGRect(x: 0, y: 14, width: 55, height: 19)
    static let NewTimerTitle = CGRect(x: 0, y: 20, width: 86, height: 45)
}
//MARK: - CSV
enum CsvControls{
    static let ColumnDelimiter: String = "\t"
    static let LineSeperator: String = "\n"
}
//MARK: - Errors
enum CoreLocationError : Int {
    case LocationUnknown // location is currently unknown, but CL will keep trying
    case Denied // Access to location or ranging has been denied by the user
    case Network // general, network-related error
}
enum CsvError: Error {
    case readError(String)
    case missing(String)
}
enum GetCityIdError: Error {
    case cityNameIsNil(reason: String)
    case countryCodeIsNil(reason: String)
    case latitudeIsNil(reason: String)
    case longitudeIsNil(reason: String)
    case urlIsNil(reason: String)
    case noCityId(reason: String)
    case noCityName(reason: String)
}
enum HttpError: Error { //For a an http response code enum, look here: //https://gist.github.com/brennanMKE/482452bb9ac5f578907f413902753eec
    case unsucessfulHttpResponse(code: String)
}
enum JsonError: Error {
    case unsucessfulProcessing
    case missing(String)
    case missingTemperature
    case missingIcon
}
enum UrlError: Error {
    case unsucessfulUrl(reason: String)
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
enum IntervalImage{
    static let Red = "redIndicator"
    static let Green = "greenIndicator"
    static let Orange = "orangeIndicator"
    static let Blue = "blueIndicator"
    static let Yellow = "yellowIndicator"
    static let Purple = "purpleIndicator"
    static let RedUnselected = "redIndicatorUnselected"
    static let GreenUnselected = "greenIndicatorUnselected"
    static let OrangeUnselected = "orangeIndicatorUnselected"
    static let BlueUnselected = "blueIndicatorUnselected"
    static let YellowUnselected = "yellowIndicatorUnselected"
    static let PurpleUnselected = "purpleIndicatorUnselected"
}
//MARK: - Litterals
enum NavigationBarLitterals{
    static let Cancel = "Cancel"
    static let Edit = "Edit"
    static let BackToTimers = "Timers"
    static let Back = "Back"
    static let NewTimer = "Timer"
    static let NewInterval = "Interval"
}
//MARK: - MapQuest
enum MapQuestApi {
    static let key = "iaGiN8vTI73I5Kpa0YPrVVblLvjPAfYF"
    static let baseUrl = "http://open.mapquestapi.com/nominatim/v1/reverse.php?"
}
////MARK: - Queues
//enum QueueLabel{
//    static let ShouldUpdateWeather = REVERSE_DNS + ".shouldUpdateWeather"
//    static let GetCityId = REVERSE_DNS + ".getCityId"
//}
//MARK: - Weather
enum OpenWeatherApi {
    static let key = "448af267f0d35a22b6e00178e163deb3"
    static let baseUrl = "http://api.openweathermap.org/data/2.5/weather?"
}
enum TemperatureUnit: Int {
    case celcius = 0, fahrenheit, kelvin
}
enum WeatherDictionaryKey{
    static let temperature = "temp"
    static let weatherIcon = "icon"
}
enum WeatherQueryPriority: Int {
    case byCityId = 0, byLocationName, byCoordinates, none
}
