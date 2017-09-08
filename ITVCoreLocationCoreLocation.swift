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
                
                //TODO: Complete locatin determination and show warning that location information is unavailable
            }
        } else {
            //TODO: Raise location unavailable from iPhone error screen .
            //thisDidCompleteLocationDetermination = false
            //TODO: Complete locatin determination and show warning that location information is unavailable
        }
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
                //TODO: location determination should be completed here
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
            NotificationCenter.default.post(name: Notification.Name(rawValue: "didAuthorizeLocationServices"), object: nil)
        }else {
            //TODO: Maybe design a screen asking the user to please authorize location service for the app
            ITVWarningForUser.sharedInstance.thisUserWarning = UserWarning.LocationServicesDisabled
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //TODO: Handle diabled location services for app error: present a nice alert view to advise the user to enable location services
        //TODO: error code 0 -> reset location settings (i tried juust clearing the ram)
        //TODO: error code 1 -> Code 1 occurs when the user has denied your app access to location services.
        //TODO: if the weather is not updated after 1minute, than put the warning icon to warn user that the network is not working, do the same thing if insufficient data exists to determine a location
        
        print("------> ERROR IntervalTimerCoreLocation locationManager(manager:didFailWithError:) -> \(error)")
        
        //TODO: restart the manager at a later appropriate state (maybe by user tapping on the warning icon of the weather!)
        stopUpdatingLocationManager()
        
        let theError = error as NSError
        var errorMessage = ""

        switch (theError.code) {
        case 0:
//        case CoreLocationError.LocationUnknown.rawValue: //location is currently unknown
            errorMessage = "Location is currently unknown. Code: \(theError.code). Message: localizedDescription: \(theError.localizedDescription), localizedFailureReason: \(theError.localizedFailureReason), localizedRecoveryOptions: \(theError.localizedRecoveryOptions), localizedRecoverySuggestion: \(theError.localizedRecoverySuggestion)."
            
            print("------> ERROR \(errorMessage)")
            showUserWarning(type: UserWarning.LocationManagerDidFail, with: errorMessage)
            
//        case CoreLocationError.Denied.rawValue:
        case 1:
            
            errorMessage = "Access to location has been denied by the user. Code: \(theError.code). Message: \(theError)."
            
            print("------> ERROR \(errorMessage)")
            showUserWarning(type: UserWarning.LocationServicesDisabled)
            
//        case CoreLocationError.Network.rawValue:
        case 2:
            errorMessage = "Network-related error. Code: \(theError.code). Message: \(theError)."
            
            print("------> ERROR \(errorMessage)")
            showUserWarning(type: UserWarning.NoInternet)
            
        default:
            
            errorMessage = "Failed location default error. Code: \(theError.code). Message: \(theError)."
            
            print("------> ERROR \(errorMessage)")
            showUserWarning(type: UserWarning.LocationManagerDidFail, with: errorMessage)
        }
    }
}
