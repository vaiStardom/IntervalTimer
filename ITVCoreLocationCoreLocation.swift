//
//  IntervalTimerCoreLocationCoreLocation.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-01.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import CoreLocation

extension ITVCoreLocation {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let latestLocation = locations.last!
        if latestLocation.horizontalAccuracy < 0 { // if the lateral location is invalid, return
            return
        }
        
        //If location is nil or has moved
        if thisLocation == nil || thisLocation!.horizontalAccuracy > latestLocation.horizontalAccuracy {
            
            thisLocation = latestLocation
            print("------> IntervalTimerCoreLocation locationManager(manager:didUpdateLocations:) -> latitude: \(thisLocation?.coordinate.latitude ?? 0), longitude: \(thisLocation?.coordinate.longitude ?? 0)")
            
            if let theLatitude = thisLocation?.coordinate.latitude, let theLongitude = thisLocation?.coordinate.longitude {
                thisLatitude = theLatitude
                thisLongitude = theLongitude
                reverseGeocodeLocation(latestLocation)
            } else {
                thisLatitude = nil
                thisLongitude = nil
                
                ITVWarningForUser.sharedInstance.thisUserWarning = UserWarning.LocationManagerDidFail
                ITVWarningForUser.sharedInstance.thisMessage = "ERROR in locationManager(manager:didUpdateLocations). No latitude or longitude in the last CLLocation object."
            }
        } //Else -> Nothing to do, as it only means the user simply did not move yet
    }
    func reverseGeocodeLocation(_ location: CLLocation?){
        guard let theLocation = location else {
            print("------> ERROR IntervalTimerCoreLocation reverseGeocodeLocation(location:) CLLocation = nil")
            nilLocationName()
            return
        }
        
        let group = DispatchGroup()
        print("------> 1 - IntervalTimerCoreLocation reverseGeocodeLocation(location:) entering group")
        group.enter()
        DispatchQueue.main.async {
            self.thisGeocoder.reverseGeocodeLocation(theLocation, completionHandler: { (placemarks, error) in
                print("------> 2 - IntervalTimerCoreLocation reverseGeocodeLocation(location:) cheking for errors")
                if error == nil, let placemark = placemarks, !placemark.isEmpty {
                    self.thisPlacemark = placemark.last
                    //Parse location information
                    print("------> 3 - IntervalTimerCoreLocation reverseGeocodeLocation(location:) Parsing location information")
                    self.parsePlacemark()
                } else {
                    //Unable to get the rest of the location data, this should set didcompletelocationdetermination to true
                    print("------> ERROR IntervalTimerCoreLocation reverseGeocodeLocation(location:) error: \(String(describing: error))")
                    self.nilLocationName()
                }
                print("------> 4 - IntervalTimerCoreLocation reverseGeocodeLocation(location:) leaving group")
                group.leave()
            })
        }

        group.notify(queue: .main) {
            print("------> 5 - IntervalTimerCoreLocation reverseGeocodeLocation(location:) reverseGeocodeLocation_WorkItem did complete")
            if self.thisCityName != nil && self.thisCountryCode != nil {
                print("------> 6 - IntervalTimerCoreLocation reverseGeocodeLocation(location:) reverseGeocodeLocation_WorkItem did complete called getCityId()")
                self.getCityId()
            } else {
                print("------> 7 - IntervalTimerCoreLocation reverseGeocodeLocation(location:) reverseGeocodeLocation_WorkItem did complete no location names available or CLPlacemark was nil")
                self.thisDidCompleteLocationDetermination = true
            }
        }
    }
    func parsePlacemark() {
        
        guard let _ = thisLocation else {
            print("------> ERROR IntervalTimerCoreLocation parsePlacemarks() CLLocation = nil")
            nilLocationName()
            return
        }
        
        guard let thePlacemark = thisPlacemark else {
            print("------> ERROR IntervalTimerCoreLocation parsePlacemarks() CLPlacemark = nil")
            nilLocationName()
            return
        }
        
        guard let theCityName = thePlacemark.locality, !theCityName.isEmpty else {
            print("------> ERROR IntervalTimerCoreLocation parsePlacemarks() CLPlacemark.locality = nil or empty")
            nilLocationName()
            return
        }
        
        guard let theCountryShortName = thePlacemark.isoCountryCode, !theCountryShortName.isEmpty else {
            print("------> ERROR IntervalTimerCoreLocation parsePlacemarks() CLPlacemark.isoCountryCode = nil or empty")
            nilLocationName()
            return
        }
        
        thisCityName = theCityName
        thisCountryCode = theCountryShortName
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == .authorizedAlways || status == .authorizedWhenInUse){
            //Send notification to update the weather
            NotificationCenter.default.post(name: Notification.Name(rawValue: Notifications.didAuthorizeLocationServices), object: nil)
        }else {
            ITVWarningForUser.sharedInstance.thisUserWarning = UserWarning.LocationServicesDisabled
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

        print("------> ERROR IntervalTimerCoreLocation locationManager(manager:didFailWithError:) -> \(error)")
        
        stopUpdatingLocationManager()
        
        let theError = error as NSError
        var errorMessage = ""

        switch (theError.code) {
        case 0:
            errorMessage = "Location is currently unknown. Code: \(theError.code). Message: localizedDescription: \(theError.localizedDescription), localizedFailureReason: \(String(describing: theError.localizedFailureReason)), localizedRecoveryOptions: \(String(describing: theError.localizedRecoveryOptions)), localizedRecoverySuggestion: \(String(describing: theError.localizedRecoverySuggestion))."
            
            print("------> ERROR \(errorMessage)")
            ITVWarningForUser.sharedInstance.thisUserWarning = UserWarning.LocationManagerDidFail
            ITVWarningForUser.sharedInstance.thisMessage = errorMessage
        case 1:
            
            errorMessage = "Access to location has been denied by the user. Code: \(theError.code). Message: \(theError)."
            
            print("------> ERROR \(errorMessage)")
            ITVWarningForUser.sharedInstance.thisUserWarning = UserWarning.LocationServicesDisabled
            ITVWarningForUser.sharedInstance.thisMessage = errorMessage

        case 2:
            errorMessage = "Network-related error. Code: \(theError.code). Message: \(theError)."
            
            print("------> ERROR \(errorMessage)")
            ITVWarningForUser.sharedInstance.thisUserWarning = UserWarning.NoInternet
            ITVWarningForUser.sharedInstance.thisMessage = errorMessage

        default:
            
            errorMessage = "Failed location default error. Code: \(theError.code). Message: \(theError)."
            
            print("------> ERROR \(errorMessage)")

            ITVWarningForUser.sharedInstance.thisUserWarning = UserWarning.LocationManagerDidFail
            ITVWarningForUser.sharedInstance.thisMessage = errorMessage

        }
    }
}
