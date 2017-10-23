//
//  IntervalTimerCoreLocationHelpers.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-01.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import CoreLocation

//MARK: - Helpers
extension ITVCoreLocation{
    func requestLocation(){
        thisLocationManager.requestLocation()
    }
    //Called when a timer has finished running
    func stopUpdatingLocationManager(){
        thisLocationManager.stopUpdatingLocation() //will cancel any requested location updates
    }
    func nilLocationName(){
        print("------> IntervalTimerCoreLocation nilLocationName()")
        thisCityName = nil
        thisCountryCode = nil
        thisCityId = -1
    }
    func getCityId() {
        guard !thisCityName!.isEmpty, thisCityName != nil else {
            thisCityId = -1
            return
        }
        guard !thisCountryCode!.isEmpty, thisCountryCode != nil else {
            thisCityId = -1
            return
        }
        
        let group = DispatchGroup()
        print("------> 1 - IntervalTimerCoreLocation getCityId() entering group")
        group.enter()
        DispatchQueue.main.async {
            print("------> 2 - IntervalTimerCoreLocation getCityId() starting work")
            ITVCsv.sharedInstance.getCityId(cityName: self.thisCityName!, countryCode: self.thisCountryCode!) { (itvCsvErrorHandler) in
                print("------> 3 - IntervalTimerCoreLocation getCityId() work ended")
                guard itvCsvErrorHandler == nil else {
                    print("------> 4 - IntervalTimerCoreLocation getCityId() error = \(String(describing: itvCsvErrorHandler))")
                    self.thisError = itvCsvErrorHandler
                    print("------> 5 - IntervalTimerCoreLocation getCityId() leaving group because of error")
                    group.leave()
                    return
                }
                self.thisError = nil
                print("------> 5 - IntervalTimerCoreLocation getCityId() leaving group (no errors)")
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("------> 6 - IntervalTimerCoreLocation getCityId() group complete")
            if self.thisError != nil {
                print("------> 7 - IntervalTimerCoreLocation getCityId() looking for alternative location name")
                //get alternative information for city name
                self.getNewCityName()
            }
        }
    }
    func getNewCityName(){
        let group = DispatchGroup()
        print("------> 1 - IntervalTimerCoreLocation getNewCityName() entering group")
        NotificationCenter.default.addObserver(self, selector: #selector(self.didGetNewCityName(_:)), name:NSNotification.Name(rawValue: Notifications.didGetNewCityName), object: nil)
        group.enter()
        DispatchQueue.main.async {
            print("------> 2 - IntervalTimerCoreLocation getNewCityName() starting work")
            ITVCity.getAlternativeLocationNameByCoordinates() { (itvNewCityErrorHandler) in
                print("------> 3 - IntervalTimerCoreLocation getNewCityName() work ended")
                guard itvNewCityErrorHandler == nil else {
                    print("------> 4 - IntervalTimerCoreLocation getNewCityName() error = \(String(describing: itvNewCityErrorHandler))")
                    self.thisError = itvNewCityErrorHandler
                    print("------> 5 - IntervalTimerCoreLocation getNewCityName() leaving group because of error")
                    group.leave()
                    return
                }
                self.thisError = nil
                print("------> 6 - IntervalTimerCoreLocation getNewCityName() leaving group (no errors)")
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("------> 7 - IntervalTimerCoreLocation getNewCityName() work completed")
            if self.thisError != nil {
                print("------> 8 - IntervalTimerCoreLocation getNewCityName() there was no error")
            } else {
                
            }
        }
    }
    @objc func didGetNewCityName(_ notification: Notification){
        
        print("------> IntervalTimerCoreLocation didGetNewCityName(notification:) notification received")
        guard !thisCityName!.isEmpty, thisCityName != nil else {
            thisCityId = -1
            return
        }
        guard !thisCountryCode!.isEmpty, thisCountryCode != nil else {
            thisCityId = -1
            return
        }
        
        let group = DispatchGroup()
        print("------> 1 - IntervalTimerCoreLocation didGetNewCityName(notification:) entering group")
        group.enter()
        DispatchQueue.main.async {
            print("------> 2 - IntervalTimerCoreLocation didGetNewCityName(notification:) starting work")
            ITVCsv.sharedInstance.getCityId(cityName: self.thisCityName!, countryCode: self.thisCountryCode!) { (itvCsvErrorHandler) in
                print("------> 3 - IntervalTimerCoreLocation didGetNewCityName(notification:) work ended")
                guard itvCsvErrorHandler != nil else {
                    print("------> 4 - IntervalTimerCoreLocation didGetNewCityName(notification:) error = \(String(describing: itvCsvErrorHandler))")
                    self.thisError = itvCsvErrorHandler
                    print("------> 5 - IntervalTimerCoreLocation didGetNewCityName(notification:) leaving group because of error")
                    group.leave()
                    return
                }
                self.thisError = nil
                print("------> 5 - IntervalTimerCoreLocation didGetNewCityName(notification:) leaving group (no errors)")
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("------> 6 - IntervalTimerCoreLocation didGetNewCityName(notification:) group complete")
            if self.thisCityId == nil {
                self.thisCityId = -1
            }
        }
    }
    
    func checkIfLocationDeterminationIsComplete(){
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
    
    func configureLocationServices(){
        
        let authStatus = CLLocationManager.authorizationStatus()
        if authStatus == .notDetermined {
            thisLocationManager.delegate = self
            thisLocationManager.requestWhenInUseAuthorization()
        } else {
            if authStatus == .restricted || authStatus == .denied{
                ITVWarningForUser.sharedInstance.thisUserWarning = UserWarning.LocationServicesDisabled
            }
        }
    }
    
    func isLocationServicesAndNetworkAvailable() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined:
                configureLocationServices()
                return false
            case .restricted, .denied:
                ITVWarningForUser.sharedInstance.thisUserWarning = UserWarning.LocationServicesDisabled
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                if currentReachabilityStatus != .notReachable {
                    return true
                } else {
                    ITVWarningForUser.sharedInstance.thisUserWarning = UserWarning.NoInternet
                    return false
                }
            }
        } else {
            ITVWarningForUser.sharedInstance.thisUserWarning = UserWarning.LocationServicesDisabled
            return false
        }
    }
}
