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
        
        
        
        
        
        
        
        //        let getCityId_WorkItem = DispatchWorkItem {
        //            do {
        //                try IntervalTimerCsv.sharedInstance.getCityId(cityName: self.thisCityName!, countryCode: self.thisCountryCode!)
        //                self.thisError = nil
        //            } catch let error {
        //                print("------> ERROR IntervalTimerCoreLocation getCityId() getCityId_WorkItem -> \(error)")
        //                self.thisError = error
        //            }
        //        }
        //
        //        let getNewCityName_WorkItem = DispatchWorkItem {//get city id by cl info failed, get alternative info from mapquest
        //            do {
        //                try IntervalTimerCity.getCityAlternativeInfoByCoordinates()
        //                self.thisError = nil
        //            } catch let error {
        //                print("------> ERROR IntervalTimerCoreLocation getCityId() getNewCityName_WorkItem -> \(error)")
        //                self.thisError = error
        //            }
        //        }
        //
        //        UTILITY_GLOBAL_DISPATCHQUEUE.async(execute: getCityId_WorkItem)
        //
        //        getCityId_WorkItem.notify(queue: DispatchQueue.main) {
        //            if self.thisError != nil {
        //                UTILITY_GLOBAL_DISPATCHQUEUE.async(execute: getNewCityName_WorkItem)
        //            }
        //        }
        //
        //        getNewCityName_WorkItem.notify(queue: DispatchQueue.main) {
        //            print("------> IntervalTimerCoreLocation getCityId() getNewCityName_WorkItem completed error = \(String(describing: self.thisError?))")
        //            if self.thisError != nil {
        //                NotificationCenter.default.addObserver(self, selector: #selector(self.didGetNewCityName(_:)), name:NSNotification.Name(rawValue: "didGetNewCityName"), object: nil)
        //            } else {
        //
        //            }
        //        }
    }
    func getNewCityName(){
        let group = DispatchGroup()
        print("------> 1 - IntervalTimerCoreLocation getNewCityName() entering group")
        NotificationCenter.default.addObserver(self, selector: #selector(self.didGetNewCityName(_:)), name:NSNotification.Name(rawValue: "didGetNewCityName"), object: nil)
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
    func didGetNewCityName(_ notification: Notification){
       
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
                    print("------> 4 - IntervalTimerCoreLocation didGetNewCityName(notification:) error = \(itvCsvErrorHandler)")
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
    
    //    func didGetNewCityName(_ notification: Notification){
    //
    //        let getNewCityNameCityId_WorkItem = DispatchWorkItem {
    //            do {
    //                try ITVCsv.sharedInstance.getCityId(cityName: self.thisCityName!, countryCode: self.thisCountryCode!)
    //                self.thisError = nil
    //            } catch let error {
    //                print("------> ERROR IntervalTimerCoreLocation didGetNewCityName(notification:) getNewCityNameCityId_WorkItem -> \(error)")
    //                self.thisError = error
    //            }
    //        }
    //
    //        UTILITY_GLOBAL_DISPATCHQUEUE.async(execute: getNewCityNameCityId_WorkItem)
    //        getNewCityNameCityId_WorkItem.notify(queue: DispatchQueue.main) {
    //            if self.thisError != nil {
    //                self.thisCityId = -1
    //            }
    //        }
    //    }
    
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
