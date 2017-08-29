//
//  IntervalTimerCoreLocation.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-21.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import CoreLocation

private let _sharedInstance = IntervalTimerCoreLocation()
class IntervalTimerCoreLocation: NSObject, CLLocationManagerDelegate {
    
    //MARK: - Singleton
    //static let sharedInstance = IntervalTimerCoreLocation()
    //The private global _sharedInstance variable is used to initialize IntervalTimerUser lazily.
    //This happens only on the first access here.
    //The public sharedManager variable returns the private sharedInstance variable.
    //Swift ensures that this operation is thread safe.
    class var sharedInstance: IntervalTimerCoreLocation {
        return _sharedInstance
    }
    
    //MARK: - CoreLocation fileprivate properties
    fileprivate var cityId: Int?
    fileprivate var cityName: String?
    fileprivate var countryCode: String?
    fileprivate var didCompleteLocationDetermination: Bool? = false
    fileprivate var didCityIdRetreivalFail: Bool? = false
    fileprivate var didCityInfoRetreivalFail: Bool? = false
    fileprivate var firstTimeLocationService: Date? = nil
    fileprivate var latitude: Double?
    fileprivate var longitude: Double?
    
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
    var thisCityId: Int?{
        get {
            return cityId
        }
        set {
            cityId = newValue
            UserDefaults.standard.set(newValue, forKey: "cityId")
            UserDefaults.standard.synchronize()
            
            checkIfLocationDeterminationIsComplete()
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
        }
    }
    
    var thisDidCompleteLocationDetermination: Bool? {
        get { return didCompleteLocationDetermination }
        set {
            didCompleteLocationDetermination = newValue
            UserDefaults.standard.set(newValue, forKey: "didCompleteLocationDetermination")
            UserDefaults.standard.synchronize()
            
            if newValue == true {
                //Send notificatin that we can update the weather
                print("------> IntervalTimerCoreLocation thisDidCompleteLocationDetermination was set to true")
                NotificationCenter.default.post(name: Notification.Name(rawValue: "canAttemptWeatherUpdate"), object: nil)
            }
        }
    }
    var thisFirstTimeLocationService: Date?{
        get { return firstTimeLocationService }
        set {
            firstTimeLocationService = newValue
            UserDefaults.standard.set(newValue, forKey: "firstTimeLocationService")
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
    
    //MARK: - init()
    override init(){}
    
    //MARK: - NSCoding protocol methods
    func encode(with coder: NSCoder){
        coder.encode(self.thisCityId, forKey: "cityId")
        coder.encode(self.thisCityName, forKey: "cityName")
        coder.encode(self.thisCountryCode, forKey: "countryCode")
        coder.encode(self.thisDidCompleteLocationDetermination, forKey: "didCompleteLocationDetermination")
        coder.encode(self.thisFirstTimeLocationService, forKey: "firstTimeLocationService")
        coder.encode(self.thisLatitude, forKey: "latitude")
        coder.encode(self.thisLongitude, forKey: "longitude")
        
    }
    required init(coder decoder: NSCoder) {
        if let theCityName = decoder.decodeObject(forKey: "cityName") as! String? {
            cityName = theCityName
        }
        if let theCountryCode = decoder.decodeObject(forKey: "countryCode") as! String? {
            countryCode = theCountryCode
        }
        if let theCityId = decoder.decodeInteger(forKey: "cityId") as Int? {
            cityId = theCityId
        }
        if let theDidCompleteLocationDetermination = decoder.decodeBool(forKey: "didCompleteLocationDetermination") as Bool? {
            didCompleteLocationDetermination = theDidCompleteLocationDetermination
        }
        if let theFirstTimeLocationService = decoder.decodeObject(forKey: "firstTimeLocationService") as! Date? {
            firstTimeLocationService = theFirstTimeLocationService
        }
        if let theLatitude = decoder.decodeDouble(forKey: "latitude") as Double? {
            latitude = theLatitude
        }
        if let theLongitude = decoder.decodeDouble(forKey: "longitude") as Double? {
            longitude = theLongitude
        }
    }
    
    func getCityId(){
        guard !thisCityName!.isEmpty, thisCityName != nil else {
            thisCityId = -1
            return
        }
        guard !countryCode!.isEmpty, thisCountryCode != nil else {
            thisCityId = -1
            return
        }
        let getCityId_WorkItem = DispatchWorkItem {
            do {
                try IntervalTimerCsv.sharedInstance.getCityId(cityName: self.thisCityName!, countryCode: self.thisCountryCode!)
                self.didCityIdRetreivalFail = false
            } catch let error {
                print("------> ERROR IntervalTimerCoreLocation getCityId() getCityId_WorkItem -> \(error)")
                self.didCityIdRetreivalFail = true
            }
        }
        
        let getNewCityName_WorkItem = DispatchWorkItem {//get city id by cl info failed, get alternative info from mapquest
            do {
                try IntervalTimerCity.getCityAlternativeInfoByCoordinates()
                self.didCityInfoRetreivalFail = false
            } catch let error {
                print("------> ERROR IntervalTimerCoreLocation getCityId() getNewCityName_WorkItem -> \(error)")
                self.didCityInfoRetreivalFail = true
            }
        }
        
        UTILITY_GLOBAL_DISPATCHQUEUE.async(execute: getCityId_WorkItem)
        
        getCityId_WorkItem.notify(queue: DispatchQueue.main) {
            if self.didCityIdRetreivalFail == true {
                UTILITY_GLOBAL_DISPATCHQUEUE.async(execute: getNewCityName_WorkItem)
            }
        }

        getNewCityName_WorkItem.notify(queue: DispatchQueue.main) {
            print("------> IntervalTimerCoreLocation getCityId() getNewCityName_WorkItem completed, didCityInfoRetreivalFail = \(String(describing: self.didCityInfoRetreivalFail))")
            if self.didCityInfoRetreivalFail == false {
                NotificationCenter.default.addObserver(self, selector: #selector(self.didGetNewCityName(_:)), name:NSNotification.Name(rawValue: "didGetNewCityName"), object: nil)
            }
        }
    }
    func didGetNewCityName(_ notification: Notification){

        let getNewCityNameCityId_WorkItem = DispatchWorkItem {
            do {
                try IntervalTimerCsv.sharedInstance.getCityId(cityName: self.thisCityName!, countryCode: self.thisCountryCode!)
                self.didCityIdRetreivalFail = false
            } catch let error {
                print("------> ERROR IntervalTimerCoreLocation didGetNewCityName(notification:) getNewCityNameCityId_WorkItem -> \(error)")
                self.didCityIdRetreivalFail = true
            }
        }

        UTILITY_GLOBAL_DISPATCHQUEUE.async(execute: getNewCityNameCityId_WorkItem)
        getNewCityNameCityId_WorkItem.notify(queue: DispatchQueue.main) {
            if self.didCityIdRetreivalFail == true {
                self.thisCityId = -1
            }
        }
    }
    
    func checkIfLocationDeterminationIsComplete(){

        //TODO: Validate that the weather retreival is functionning properly by priority
        guard thisCityId != nil
            , thisCountryCode != nil
            , thisCityName != nil
            , thisLongitude != nil
            , thisLatitude != nil else {
            thisDidCompleteLocationDetermination = false
            return
        }
        thisDidCompleteLocationDetermination = true
    }
    
    func firstTimeLocationUsage(){
        
        //TODO: Record date time of enable location services
        thisFirstTimeLocationService = Date()
        
        let authStatus = CLLocationManager.authorizationStatus()
        if authStatus == .notDetermined {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
        }
        
        if authStatus == .denied || authStatus == .restricted {
            //TODO: add the new alert screen to ask the user to enable location services (and possibly design a new screen that show if location services are at all possible on current device)
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
            print("------> IntervalTimerCoreLocation locationManager(manager:didUpdateLocations:) -> latitude: \(location?.coordinate.latitude ?? 0), longitude: \(location?.coordinate.longitude ?? 0)")
            
            if let theLatitude = location?.coordinate.latitude, let theLongitude = location?.coordinate.longitude {
                thisLatitude = theLatitude
                thisLongitude = theLongitude
            } else {
                thisLatitude = nil
                thisLongitude = nil
            }

            //            //ReverseGeocoding to get location name using BADAPPLES
            //            //BADAPPLE: forced to use GoogleMap API to get ENGLISH city name, bypassing userdefaults
            //            //TODO: Other possible BADAPPLES https://stackoverflow.com/questions/31331093/clgeocoder-returns-wrong-results-when-city-name-is-equal-to-some-countrys-name
            geocoder.reverseGeocodeLocation(latestLocation, completionHandler: { (placemarks, error) in
                if error == nil, let placemark = placemarks, !placemark.isEmpty {
                    self.placemark = placemark.last
                }
                //Parse location information
                self.parsePlacemarks()
            })
            
        } else {
            //TODO: What do we do here in this condition?
            //thisDidCompleteLocationDetermination = false
        }
    }
    func parsePlacemarks() {
        
        guard let _ = location else {
            print("------> IntervalTimerCoreLocation parsePlacemarks() CLLocation = nil")
            nilLocationName()
            return
        }
        
        guard let thePlacemark = placemark else {
            print("------> IntervalTimerCoreLocation parsePlacemarks() CLPlacemark = nil")
            nilLocationName()
            return
        }
        
        guard let theCityName = thePlacemark.locality, !theCityName.isEmpty else {
            print("------> IntervalTimerCoreLocation parsePlacemarks() CLPlacemark.locality = nil or empty")
            nilLocationName()
            return
        }
        
        guard let theCountryShortName = thePlacemark.isoCountryCode, !theCountryShortName.isEmpty else {
            print("------> IntervalTimerCoreLocation parsePlacemarks() CLPlacemark.isoCountryCode = nil or empty")
            nilLocationName()
            return
        }
        
        thisCityName = theCityName
        thisCountryCode = theCountryShortName
        
        getCityId()
    }
    
    func nilLocationName(){
        print("------> IntervalTimerCoreLocation nilLocationName()")
        thisCityName = ""
        thisCountryCode = ""
        thisCityId = -1
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //TODO: Handle core location errors
        //TODO: Stop the loading progression, and replace it with the warning icon
        //TODO: Handle diabled location services for app error: present a nice alert view to advise the user to enable location services
        //TODO: error code 0 -> reset location settings (i tried juust clearing the ram)
        //TODO: error code 1 -> Code 1 occurs when the user has denied your app access to location services.
        //TODO: if the weather is not updated after 1minute, than put the warning icon to warn user that the network is not working, do the same thing if insufficient data exists to determine a location
        
        print("------> ERROR IntervalTimerCoreLocation locationManager(manager:didFailWithError:) -> \(error.localizedDescription)")
        stopUpdatingLocationManager()
        
        let theError = error as NSError
        switch (theError.code) {
        case CoreLocationError.LocationUnknown.rawValue: //location is currently unknown
            print("------> ERROR Location is currently unknown. Code: \(theError.code). Message: \(theError.localizedDescription).")
        case CoreLocationError.Denied.rawValue:
            print("------> ERROR Access to location has been denied by the user. Code: \(theError.code). Message: \(theError.localizedDescription).")
        case CoreLocationError.Network.rawValue:
            print("------> ERROR Network-related error. Code: \(theError.code). Message: \(theError.localizedDescription).")
        default:
            print("------> ERROR Failed location default error. Code: \(theError.code). Message: \(theError.localizedDescription).")
        }
        
    }

    func requestLocation(){
        locationManager.requestLocation()
    }

    //Called when a timer has finished running
    func stopUpdatingLocationManager(){
        locationManager.stopUpdatingLocation() //will cancel any requested location updates
    }
}
