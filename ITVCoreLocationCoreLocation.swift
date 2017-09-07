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
            } else {
                thisLatitude = nil
                thisLongitude = nil
            }
            
            reverseGeocodeLocation(latestLocation)
        } else {
            //TODO: Raise location unavailable from iPhone error screen .
            //thisDidCompleteLocationDetermination = false
        }
    }
    func reverseGeocodeLocation(_ location: CLLocation?){
        guard let theLocation = location else {
            print("------> ERROR IntervalTimerCoreLocation reverseGeocodeLocation(location:) CLLocation = nil")
            nilLocationName()
            return
        }
        
//        let reverseGeocodeLocation_WorkItem = DispatchWorkItem {
//            self.thisGeocoder.reverseGeocodeLocation(theLocation, completionHandler: { (placemarks, error) in
//                print("------> IntervalTimerCoreLocation reverseGeocodeLocation(location:) cheking for errors")
//                if error == nil, let placemark = placemarks, !placemark.isEmpty {
//                    self.thisPlacemark = placemark.last
//                    //Parse location information
//                    print("------> IntervalTimerCoreLocation reverseGeocodeLocation(location:) Parsing location information")
//                    self.parsePlacemark()
//                } else {
//                    //Unable to get the rest of the location data, this should set didcompletelocationdetermination to true
//                    print("------> ERROR IntervalTimerCoreLocation reverseGeocodeLocation(location:) error: \(String(describing: error))")
//                    self.nilLocationName()
//                }
//            })
//        }
        
//        print("------> IntervalTimerCoreLocation reverseGeocodeLocation(location:) reverseGeocodeLocation_WorkItem will execute")
//        UTILITY_GLOBAL_DISPATCHQUEUE.async(execute: reverseGeocodeLocation_WorkItem)

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
            }
        }


        
//        reverseGeocodeLocation_WorkItem.notify(queue: DispatchQueue.main) {
//            print("------> IntervalTimerCoreLocation reverseGeocodeLocation(location:) reverseGeocodeLocation_WorkItem did complete")
//            if self.thisCityName != nil && self.thisCountryCode != nil {
//                print("------> IntervalTimerCoreLocation reverseGeocodeLocation(location:) reverseGeocodeLocation_WorkItem did complete called getCityId()")
//                self.getCityId()
//            }
//        }
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
        
//        getCityId()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //TODO: Handle core location errors
        //TODO: Stop the loading progression, and replace it with the warning icon
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
            errorMessage = "Location is currently unknown. Code: \(theError.code). Message: \(theError)."
            
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

//        switch (theError.code) {
//        case CoreLocationError.LocationUnknown.rawValue: //location is currently unknown
//            errorMessage = "Location is currently unknown. Code: \(theError.code). Message: \(theError)."
//            
//            print("------> ERROR \(errorMessage)")
//            showUserWarning(type: UserWarning.LocationManagerDidFail, with: errorMessage)
//
//        case CoreLocationError.Denied.rawValue:
//            
//            errorMessage = "Access to location has been denied by the user. Code: \(theError.code). Message: \(theError)."
//            
//            print("------> ERROR \(errorMessage)")
//            showUserWarning(type: UserWarning.LocationServicesDisabled)
//            
//        case CoreLocationError.Network.rawValue:
//            errorMessage = "Network-related error. Code: \(theError.code). Message: \(theError)."
//            
//            print("------> ERROR \(errorMessage)")
//            showUserWarning(type: UserWarning.NoInternet)
//            
//        default:
//
//            errorMessage = "Failed location default error. Code: \(theError.code). Message: \(theError)."
//            
//            print("------> ERROR \(errorMessage)")
//            showUserWarning(type: UserWarning.LocationManagerDidFail, with: errorMessage)
//        }
    }
    func requestLocation(){
        thisLocationManager.requestLocation()
    }
    //Called when a timer has finished running
    func stopUpdatingLocationManager(){
        thisLocationManager.stopUpdatingLocation() //will cancel any requested location updates
    }
}
