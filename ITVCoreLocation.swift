//
//  IntervalTimerCoreLocation.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-21.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import CoreLocation

class ITVCoreLocation: NSObject, CLLocationManagerDelegate {
    
    //MARK: - Singleton
    static let sharedInstance = ITVCoreLocation()
    
    //MARK: - Fileprivate properties
    fileprivate var cityId: Int?
    fileprivate var cityName: String?
    fileprivate var countryCode: String?
    fileprivate var didCompleteLocationDetermination: Bool? = false
    fileprivate var error: Error?
    fileprivate var firstTimeLocationService: Date? = nil
    fileprivate var latitude: Double?
    fileprivate var longitude: Double?
    fileprivate var location: CLLocation?
    fileprivate var placemark: CLPlacemark?
    
    let thisGeocoder = CLGeocoder()
    
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
    var thisCityId: Int?{
        get {
            return cityId
        }
        set {
            cityId = newValue
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.ITVCoreLocation_cityId)
            UserDefaults.standard.synchronize()
            
            checkIfLocationDeterminationIsComplete()
        }
    }
    var thisCityName: String?{
        get { return cityName}
        set {
            cityName = newValue
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.ITVCoreLocation_cityName)
            UserDefaults.standard.synchronize()
        }
    }
    var thisCountryCode: String?{
        get { return countryCode}
        set {
            countryCode = newValue
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.ITVCoreLocation_countryCode)
            UserDefaults.standard.synchronize()
        }
    }
    
    var thisDidCompleteLocationDetermination: Bool? {
        get { return didCompleteLocationDetermination }
        set {
            didCompleteLocationDetermination = newValue
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.ITVCoreLocation_didCompleteLocationDetermination)
            UserDefaults.standard.synchronize()
            
            if newValue == true {
                //Send notificatin that we can update the weather
                print("------> IntervalTimerCoreLocation thisDidCompleteLocationDetermination was set to true")
                NotificationCenter.default.post(name: Notification.Name(rawValue: Notifications.canAttemptWeatherUpdate), object: nil)
            }
        }
    }
    var thisError: Error?{
        get { return error }
        set {
            error = newValue
        }
    }

    var thisFirstTimeLocationService: Date?{
        get { return firstTimeLocationService }
        set {
            firstTimeLocationService = newValue
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.ITVCoreLocation_firstTimeLocationService)
            UserDefaults.standard.synchronize()
        }
    }
    var thisLatitude: Double?{
        get { return latitude}
        set {
            latitude = newValue
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.ITVCoreLocation_latitude)
            UserDefaults.standard.synchronize()
        }
    }
    var thisLongitude: Double?{
        get { return longitude}
        set {
            longitude = newValue
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.ITVCoreLocation_longitude)
            UserDefaults.standard.synchronize()
        }
    }
    
    var thisLocationManager: CLLocationManager{
        get { return locationManager}
    }
    
    var thisLocation: CLLocation? {
        get { return location}
        set {
            location = newValue
        }
    }
    var thisPlacemark: CLPlacemark? {
        get { return placemark}
        set {
            placemark = newValue
        }
    }
    
    //MARK: - init()
    override private init(){}
    
    //MARK: - NSCoding protocol methods
    func encode(with coder: NSCoder){
        coder.encode(self.thisCityId, forKey: UserDefaultsKey.ITVCoreLocation_cityId)
        coder.encode(self.thisCityName, forKey: UserDefaultsKey.ITVCoreLocation_cityName)
        coder.encode(self.thisCountryCode, forKey: UserDefaultsKey.ITVCoreLocation_countryCode)
        coder.encode(self.thisDidCompleteLocationDetermination, forKey: UserDefaultsKey.ITVCoreLocation_didCompleteLocationDetermination)
        coder.encode(self.thisFirstTimeLocationService, forKey: UserDefaultsKey.ITVCoreLocation_firstTimeLocationService)
        coder.encode(self.thisLatitude, forKey: UserDefaultsKey.ITVCoreLocation_latitude)
        coder.encode(self.thisLongitude, forKey: UserDefaultsKey.ITVCoreLocation_longitude)
        
    }
    required init(coder decoder: NSCoder) {
        if let theCityId = decoder.decodeInteger(forKey: UserDefaultsKey.ITVCoreLocation_cityId) as Int? {
            cityId = theCityId
        }
        if let theCityName = decoder.decodeObject(forKey: UserDefaultsKey.ITVCoreLocation_cityName) as! String? {
            cityName = theCityName
        }
        if let theCountryCode = decoder.decodeObject(forKey: UserDefaultsKey.ITVCoreLocation_countryCode) as! String? {
            countryCode = theCountryCode
        }
        if let theDidCompleteLocationDetermination = decoder.decodeBool(forKey: UserDefaultsKey.ITVCoreLocation_didCompleteLocationDetermination) as Bool? {
            didCompleteLocationDetermination = theDidCompleteLocationDetermination
        }
        if let theFirstTimeLocationService = decoder.decodeObject(forKey: UserDefaultsKey.ITVCoreLocation_firstTimeLocationService) as! Date? {
            firstTimeLocationService = theFirstTimeLocationService
        }
        if let theLatitude = decoder.decodeDouble(forKey: UserDefaultsKey.ITVCoreLocation_latitude) as Double? {
            latitude = theLatitude
        }
        if let theLongitude = decoder.decodeDouble(forKey: UserDefaultsKey.ITVCoreLocation_longitude) as Double? {
            longitude = theLongitude
        }
    }
}
