//
//  IntervalTimerCityServiceCityRetreival.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-20.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

//MARK: - City retreival management
//http://open.mapquestapi.com/nominatim/v1/reverse.php?key=iaGiN8vTI73I5Kpa0YPrVVblLvjPAfYF&format=json&lat=45.514589&lon=-73.559794&accept-language=en

extension ITVCityService {
    func getCityNameAt(latitude: Double, longitude: Double) throws {
        print("------> IntervalTimerCityService getCityNameAt(latitude:longitude:)")
        guard let theUrl = URL(string: "\(providerUrl)key=\(apiKey)&format=json&lat=\(latitude)&lon=\(longitude)&accept-language=en") else {
            print("------> ERROR IntervalTimerCityService getCityNameAt(latitude:longitude:) -> URL is nil")
            throw ITVError.GetCityId_UrlIsNil(reason: "URL is nil")
        }
        do {
            try getCityNameWith(theUrl)
        } catch let error {
            print("------> ERROR IntervalTimerCityService getCityIdAt() -> \(error)")
            throw error
        }
    }
    
    private func getCityNameWith(_ url: URL) throws {
        print("------> IntervalTimerCityService getCityNameWith(url:)")
        
        guard let theUrl = url as URL? else {
            print("------> ERROR IntervalTimerCityService getCityNameWith(url:) -> URL is nil")
            throw ITVError.GetCityId_UrlIsNil(reason: "URL is nil")
        }
        
        var didGetCity = true
        var error: Error?
        fromNetwork(with: theUrl) { (city, err) in
            
            guard err == nil else {
                error = err
                didGetCity = false
                return
            }

            guard let theCity = city?.thisName!.replacingOccurrences(of: self.cityWord, with: "").trimmingCharacters(in: .whitespacesAndNewlines) else {
                print("------> ERROR IntervalTimerCityService getCityNameWith(url:) -> theCity is nil")
                error = ITVError.GetCityId_NoCityId(reason: "Could not get city name from URL \(theUrl) ")
                didGetCity = false
                return
            }
            didGetCity = true
            DispatchQueue.main.async(execute: {
                print("------> IntervalTimerCityService getCityNameWith(url:), theCity = \(theCity)")
                ITVCoreLocation.sharedInstance.thisCityName = theCity
                print("------> IntervalTimerCityService getCityNameWith(url:) sending notification")
                NotificationCenter.default.post(name: Notification.Name(rawValue: "didGetNewCityName"), object: nil)
            })
        }
        
        if didGetCity == false, error != nil {
            throw error!
        }
    }
    
    private func fromNetwork(with url: URL, completion: @escaping ITVCityServiceHandler ) {
        
        guard let theNetworkJson = ITVDownloadJSON(url: url) else {
            completion(nil, ITVError.JSON_Missing("The JSON is nil."))
            return
        }
        theNetworkJson.downloadJSON({ (jsonDictionary, err)  in
            
            guard err == nil else {
                completion(nil, err)
                return
            }
            
            do {
                let theCity = try ITVCity(json: jsonDictionary!)
                completion(theCity, nil)
            } catch let error {
                
                print("------> ERROR IntervalTimerCityService fromNetwork(url:completion:) -> \(error)")
                
                completion(nil, error)
            }
        })
    }
}
