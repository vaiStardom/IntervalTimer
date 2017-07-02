//
//  IntervalTimerUser.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-02.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import CoreLocation

class IntervalTimerUser: NSObject {
    
    //MARK: - Singleton
    static let sharedInstance = IntervalTimerUser()
    
    //MARK: - fileprivate properties
    fileprivate var temperatureUnit: TemperatureUnit = .celcius
    fileprivate var city: String?
    fileprivate var isoCountryCode: String?
    fileprivate var cityId: Int?
    fileprivate var latitude: Double?
    fileprivate var longitude: Double?

    //MARK: - public get/set properties
    var thisTemperatureUnit: TemperatureUnit{
        get { return temperatureUnit}
        set {
            temperatureUnit = newValue
            UserDefaults.standard.set(newValue.rawValue, forKey: "temperatureUnit")
            UserDefaults.standard.synchronize()
        }
    }
    var thisCity: String?{
        get { return city}
        set {
            city = newValue
            UserDefaults.standard.set(newValue, forKey: "city")
            UserDefaults.standard.synchronize()
        }
    }
    var thisIsoCountryCode: String?{
        get { return isoCountryCode}
        set {
            isoCountryCode = newValue
            UserDefaults.standard.set(newValue, forKey: "isoCountryCode")
            UserDefaults.standard.synchronize()
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

    //MARK: - init()
    private override init() {
        self.temperatureUnit = TemperatureUnit(rawValue: UserDefaults.standard.integer(forKey: "temperatureUnit"))!
    }
    
    //MARK: - NSCoding protocol methods
    func encode(with coder: NSCoder){
        coder.encode(self.thisTemperatureUnit, forKey: "temperatureUnit")
        coder.encode(self.thisCity, forKey: "city")
        coder.encode(self.thisIsoCountryCode, forKey: "isoCountryCode")
        coder.encode(self.thisCityId, forKey: "cityId")
        coder.encode(self.thisLatitude, forKey: "latitude")
        coder.encode(self.thisLongitude, forKey: "longitude")
    }
    required init(coder decoder: NSCoder) {
        if let theTemperatureUnit = decoder.decodeInteger(forKey: "temperatureUnit") as Int? {
            temperatureUnit = TemperatureUnit(rawValue: theTemperatureUnit)!
        }
        if let theCity = decoder.decodeObject(forKey: "city") as! String? {
            city = theCity
        }
        if let theIsoCountryCode = decoder.decodeObject(forKey: "isoCountryCode") as! String? {
            isoCountryCode = theIsoCountryCode
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
        startUpdatingLocationManager()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let latestLocation = locations.last!
        if latestLocation.horizontalAccuracy < 0 { // if the lateral location is invalid, return
            return
        }
        
        
        // if it location is nil or it has been moved
        if location == nil || location!.horizontalAccuracy > latestLocation.horizontalAccuracy {
            
            location = latestLocation
            print("latitude: \(location?.coordinate.latitude ?? 0), longitude: \(location?.coordinate.longitude ?? 0)")
            //stopUpdatingLocationManager()
            
            //ReverseGeocoding
            geocoder.reverseGeocodeLocation(latestLocation, completionHandler: { (placemarks, error) in
                if error == nil, let placemark = placemarks, !placemark.isEmpty {
                    self.placemark = placemark.last
                }
                //Parse location information
                self.parsePlacemarks()
            })
        }
    }
    func parsePlacemarks() {
        if let _ = location {
            if let placemark = placemark {
                // Apple refers to city name as locality, not city
                if let city = placemark.locality, !city.isEmpty {
                    print("city: \(city)")
                }
                // isoCountryCode
                if let countryShortName = placemark.isoCountryCode {
                    print("----> countryShortName: \(countryShortName)")
                }
            }
        } else {
            //TODO: add some more check's if for some reason location manager is nil
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailwithError\(error)")
        stopUpdatingLocationManager()
    }
    func startUpdatingLocationManager(){
        locationManager.startUpdatingLocation()
    }
    func stopUpdatingLocationManager(){
        locationManager.stopUpdatingLocation()
    }
}
