//
//  IntervalTimerUser.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-02.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import CoreLocation

//TODO: Use these guidlines for error handling:
/*
Ensure error types are clearly named across your codebase.
Use optionals where a single error state exists.
Use custom errors where more than one error state exists.
Don’t allow an error to propagate too far from its source.
*/
class IntervalTimerUser: NSObject {
    
    //MARK: - Singleton
    static let sharedInstance = IntervalTimerUser()
    
    //MARK: - fileprivate properties
    fileprivate var temperatureUnit: TemperatureUnit = .celcius
    fileprivate var cityName: String?
    fileprivate var countryCode: String?
    fileprivate var cityId: Int?
    fileprivate var latitude: Double?
    fileprivate var longitude: Double?
    fileprivate var currentWeather: IntervalTimerCurrentWeather?
    fileprivate var shouldUpdateWeather: Bool? = true
    fileprivate var didCompleteLocationDetermination: Bool? = false
    
    //MARK: - CoreLocation fileprivate properties
    fileprivate let geocoder = CLGeocoder()
    fileprivate var location: CLLocation?
    fileprivate var placemark: CLPlacemark?
    
    //MARK: - Lazy Vars
    fileprivate lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        _locationManager.activityType = .fitness
        _locationManager.distanceFilter = 1000.0 //updates at 1000 meters, since weather coulds change every 1KM
        _locationManager.allowsBackgroundLocationUpdates = true
        return _locationManager
    }()

    //MARK: - public get/set properties
    var thisTemperatureUnit: TemperatureUnit{
        get { return temperatureUnit}
        set {
            temperatureUnit = newValue
            UserDefaults.standard.set(newValue.rawValue, forKey: "temperatureUnit")
            UserDefaults.standard.synchronize()
        }
    }
    var thisCityName: String?{
        get { return cityName}
        set {
            cityName = newValue
            UserDefaults.standard.set(newValue, forKey: "cityName")
            UserDefaults.standard.synchronize()
        }
    }
    var thisCountryCode: String?{
        get { return countryCode}
        set {
            countryCode = newValue
            UserDefaults.standard.set(newValue, forKey: "countryCode")
            UserDefaults.standard.synchronize()
            
            getCityId()
        }
    }
    var thisCityId: Int?{
        get { return cityId}
        set {
            cityId = newValue
            UserDefaults.standard.set(newValue, forKey: "cityId")
            UserDefaults.standard.synchronize()
        }
    }
    var thisLatitude: Double?{
        get { return latitude}
        set {
            latitude = newValue
            UserDefaults.standard.set(newValue, forKey: "latitude")
            UserDefaults.standard.synchronize()
        }
    }
    var thisLongitude: Double?{
        get { return longitude}
        set {
            longitude = newValue
            UserDefaults.standard.set(newValue, forKey: "longitude")
            UserDefaults.standard.synchronize()
        }
    }
    var thisCurrentWeather: IntervalTimerCurrentWeather? {
        get { return currentWeather}
        set {
            currentWeather = newValue
        }
    }
    
    var thisShouldUpdateWeather: Bool? {
        get {
            return shouldUpdateWeather
        }
        set {
            shouldUpdateWeather = newValue
            UserDefaults.standard.set(newValue, forKey: "shouldUpdateWeather")
            UserDefaults.standard.synchronize()
        }
    }
    var thisDidCompleteLocationDetermination: Bool? {
        get { return didCompleteLocationDetermination }
        set {
            didCompleteLocationDetermination = newValue
            if newValue == true {
                //Send notificatin that we can update the weather
                NotificationCenter.default.post(name: Notification.Name(rawValue: "canAttemptWeatherUpdate"), object: nil)
            }
        }
    }
    
    
    //MARK: - init()
    private override init() {
        self.temperatureUnit = TemperatureUnit(rawValue: UserDefaults.standard.integer(forKey: "temperatureUnit"))!
    }
    
    //MARK: - NSCoding protocol methods
    func encode(with coder: NSCoder){
        coder.encode(self.thisTemperatureUnit, forKey: "temperatureUnit")
        coder.encode(self.thisCityName, forKey: "cityName")
        coder.encode(self.thisCountryCode, forKey: "countryCode")
        coder.encode(self.thisCityId, forKey: "cityId")
        coder.encode(self.thisLatitude, forKey: "latitude")
        coder.encode(self.thisLongitude, forKey: "longitude")
        coder.encode(self.thisShouldUpdateWeather, forKey: "shouldUpdateWeather")
    }
    required init(coder decoder: NSCoder) {
        if let theTemperatureUnit = decoder.decodeInteger(forKey: "temperatureUnit") as Int? {
            temperatureUnit = TemperatureUnit(rawValue: theTemperatureUnit)!
        }
        if let theCityName = decoder.decodeObject(forKey: "cityName") as! String? {
            cityName = theCityName
        }
        if let theCountryCode = decoder.decodeObject(forKey: "countryCode") as! String? {
            countryCode = theCountryCode
        }
        if let theCityId = decoder.decodeInteger(forKey: "cityId") as Int? {
            cityId = theCityId
        }
        if let theLatitude = decoder.decodeDouble(forKey: "latitude") as Double? {
            latitude = theLatitude
        }
        if let theLongitude = decoder.decodeDouble(forKey: "longitude") as Double? {
            longitude = theLongitude
        }
        if let theShouldUpdateWeather = decoder.decodeBool(forKey: "shouldUpdateWeather") as Bool? {
            shouldUpdateWeather = theShouldUpdateWeather
        }        
    }
}
//MARK: - Helpers
extension IntervalTimerUser {
    
    func weatherQueryPriority() -> Int {
    
        //priority 1 = byCityId
        if thisCityId != nil {
            return WeatherQueryPriority.byCityId.rawValue
        }
        
        //priority 2 = location name
        if thisCityName != nil && thisCountryCode != nil {
            return WeatherQueryPriority.byLocationName.rawValue
        }
        
        //priority 3 = coordinates
        if thisLatitude != nil && thisLongitude != nil {
            return WeatherQueryPriority.byCoordinates.rawValue
        }
        
        return WeatherQueryPriority.none.rawValue
    }
    
    func getCityId(){
        
        guard let theCityName = thisCityName else {
            thisCityId = nil
            return
        }
        
        guard let theCountryCode = thisCountryCode else {
            thisCityId = nil
            return
        }
        
        guard let theCityId = getCityIdFromCsv(file: "cityList.20170703", cityName: theCityName, countryCode: theCountryCode) else {
            thisCityId = nil
            return
        }
        
        IntervalTimerUser.sharedInstance.thisCityId = theCityId
        NotificationCenter.default.post(name: Notification.Name(rawValue: "didGetCityId"), object: nil)
    }
}
//MARK: - CoreLocation Management
extension IntervalTimerUser: CLLocationManagerDelegate {
    func firstTimeLocationUsage(){
        
        let authStatus = CLLocationManager.authorizationStatus()
        if authStatus == .notDetermined {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
        }
        
        if authStatus == .denied || authStatus == .restricted {
            //TODO: add any alert or inform the user to to enable location services
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let latestLocation = locations.last!
        if latestLocation.horizontalAccuracy < 0 { // if the lateral location is invalid, return
            return
        }
        
        //If location is nil or has moved
        if location == nil || location!.horizontalAccuracy > latestLocation.horizontalAccuracy {
            
            location = latestLocation
            print("---------> CoreLocation latitude: \(location?.coordinate.latitude ?? 0), longitude: \(location?.coordinate.longitude ?? 0)")
            
            if let theLatitude = location?.coordinate.latitude, let theLongitude = location?.coordinate.longitude {
                thisLatitude = theLatitude
                thisLongitude = theLongitude
                //NotificationCenter.default.post(name: Notification.Name(rawValue: "didGetLattitudeLongitude"), object: nil)
            } else {
                thisLatitude = nil
                thisLongitude = nil
            }
            
            //ReverseGeocoding
            geocoder.reverseGeocodeLocation(latestLocation, completionHandler: { (placemarks, error) in
                if error == nil, let placemark = placemarks, !placemark.isEmpty {
                    self.placemark = placemark.last
                }
                //Parse location information
                self.parsePlacemarks()
                
                //finished trying to determine location
                self.thisDidCompleteLocationDetermination = true
            })
        } else {
            thisDidCompleteLocationDetermination = false
        }
    }
    func parsePlacemarks() {
        
        guard let _ = location else {
            nilLocationName()
            return
        }
        
        guard let thePlacemark = placemark else {
            nilLocationName()
            return
        }

        // Apple refers to city name as locality, not city
        guard let theCityName = thePlacemark.locality else {
            nilLocationName()
            return
        }
        
        guard !theCityName.isEmpty else {
            nilLocationName()
            return
        }
        
        guard let theCountryShortName = thePlacemark.isoCountryCode else {
            nilLocationName()
            return
        }
        
        print("---------> CoreLocation city: \(theCityName)")
        print("---------> CoreLocation theIsoCountryShortName: \(theCountryShortName)")
        thisCityName = theCityName
        thisCountryCode = theCountryShortName
        //NotificationCenter.default.post(name: Notification.Name(rawValue: "didGetCityAndCountryShortName"), object: nil)
    }
    func nilLocationName(){
        thisCityName = nil
        thisCountryCode = nil
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //TODO: Handle core location errors
        print("---------> CoreLocation didFailwithError\(error)")
        stopUpdatingLocationManager()
    }
    //Called when a timer is running
    func startUpdatingLocationManager(){
        locationManager.startUpdatingLocation()
    }
    //Called when a timer has finished running
    func stopUpdatingLocationManager(){
        locationManager.stopUpdatingLocation()
    }
}
