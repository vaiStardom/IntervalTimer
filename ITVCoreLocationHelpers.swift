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
    func nilLocationName(){
        print("------> IntervalTimerCoreLocation nilLocationName()")
        thisCityName = ""
        thisCountryCode = ""
        thisCityId = -1
    }
    func getCityId(){
        guard !thisCityName!.isEmpty, thisCityName != nil else {
            thisCityId = -1
            return
        }
        guard !thisCountryCode!.isEmpty, thisCountryCode != nil else {
            thisCityId = -1
            return
        }
        let getCityId_WorkItem = DispatchWorkItem {
            do {
                try IntervalTimerCsv.sharedInstance.getCityId(cityName: self.thisCityName!, countryCode: self.thisCountryCode!)
                self.thisDidCityIdRetreivalFail = false
            } catch let error {
                print("------> ERROR IntervalTimerCoreLocation getCityId() getCityId_WorkItem -> \(error)")
                self.thisDidCityIdRetreivalFail = true
            }
        }
        
        let getNewCityName_WorkItem = DispatchWorkItem {//get city id by cl info failed, get alternative info from mapquest
            do {
                try IntervalTimerCity.getCityAlternativeInfoByCoordinates()
                self.thisDidCityInfoRetreivalFail = false
            } catch let error {
                print("------> ERROR IntervalTimerCoreLocation getCityId() getNewCityName_WorkItem -> \(error)")
                self.thisDidCityInfoRetreivalFail = true
            }
        }
        
        UTILITY_GLOBAL_DISPATCHQUEUE.async(execute: getCityId_WorkItem)
        
        getCityId_WorkItem.notify(queue: DispatchQueue.main) {
            if self.thisDidCityIdRetreivalFail == true {
                UTILITY_GLOBAL_DISPATCHQUEUE.async(execute: getNewCityName_WorkItem)
            }
        }
        
        getNewCityName_WorkItem.notify(queue: DispatchQueue.main) {
            print("------> IntervalTimerCoreLocation getCityId() getNewCityName_WorkItem completed, didCityInfoRetreivalFail = \(String(describing: self.thisDidCityInfoRetreivalFail))")
            if self.thisDidCityInfoRetreivalFail == false {
                NotificationCenter.default.addObserver(self, selector: #selector(self.didGetNewCityName(_:)), name:NSNotification.Name(rawValue: "didGetNewCityName"), object: nil)
            }
        }
    }
    func didGetNewCityName(_ notification: Notification){
        
        let getNewCityNameCityId_WorkItem = DispatchWorkItem {
            do {
                try IntervalTimerCsv.sharedInstance.getCityId(cityName: self.thisCityName!, countryCode: self.thisCountryCode!)
                self.thisDidCityIdRetreivalFail = false
            } catch let error {
                print("------> ERROR IntervalTimerCoreLocation didGetNewCityName(notification:) getNewCityNameCityId_WorkItem -> \(error)")
                self.thisDidCityIdRetreivalFail = true
            }
        }
        
        UTILITY_GLOBAL_DISPATCHQUEUE.async(execute: getNewCityNameCityId_WorkItem)
        getNewCityNameCityId_WorkItem.notify(queue: DispatchQueue.main) {
            if self.thisDidCityIdRetreivalFail == true {
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
    
    func configureLocationServices(){

        let authStatus = CLLocationManager.authorizationStatus()
        if authStatus == .notDetermined {
            thisLocationManager.delegate = self
            thisLocationManager.requestWhenInUseAuthorization()
        }
        
        if authStatus == .denied || authStatus == .restricted {
            //TODO: add the new alert screen to ask the user to enable location services (and possibly design a new screen that show if location services are at all possible on current device)
        }
    }
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
