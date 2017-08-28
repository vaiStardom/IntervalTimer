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

extension IntervalTimerCityService {
    func getCityNameAt(latitude: Double, longitude: Double) throws {
        print("------> IntervalTimerCityService getCityNameAt(latitude:longitude:)")
        guard let theUrl = URL(string: "\(providerUrl)key=\(apiKey)&format=json&lat=\(latitude)&lon=\(longitude)&accept-language=en") else {
            print("------> ERROR IntervalTimerCityService getCityNameAt(latitude:longitude:) -> URL is nil")
            throw GetCityIdError.urlIsNil(reason: "URL is nil")
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
            throw GetCityIdError.urlIsNil(reason: "URL is nil")
        }
        
        var didGetCity = true

        fromNetwork(with: theUrl) { (intervalTimerCity) in
            guard let theCity = intervalTimerCity?.thisName!.replacingOccurrences(of: self.cityWord, with: "").trimmingCharacters(in: .whitespacesAndNewlines) else {
                print("------> ERROR IntervalTimerCityService getCityNameWith(url:) -> theCity is nil")
                didGetCity = false
                return
            }
            DispatchQueue.main.async(execute: {
                print("------> IntervalTimerCityService getCityNameWith(url:), theCity = \(theCity)")
                IntervalTimerUser.sharedInstance.thisCityName = theCity
                NotificationCenter.default.post(name: Notification.Name(rawValue: "didGetNewCityName"), object: nil)
            })
        }
        
        if didGetCity == false {
            throw GetCityIdError.noCityId(reason: "Could not get city name from URL \(theUrl) ")
        }
    }

    private func fromNetwork(with url: URL, completion: @escaping (IntervalTimerCity?) -> Void ) {
        guard let theNetworkJson = IntervalTimerDownloadJSON(url: url) else {
            completion(nil)
            return
        }
        theNetworkJson.downloadJSON({ (json) in
            do {
                let theCity = try IntervalTimerCity(json: json!)
                guard theCity.thisName != nil else {
                    completion(nil)
                    return
                }
                completion(theCity)
            } catch let error {
                print("------> ERROR IntervalTimerCityService fromNetwork(url:completion:) -> \(error)")
                //TODO: Handle case where network connexions are disables (same way as the disabled locations services)
                //TODO: figure out how to throw from this closure
                showMessage(title: "JSON Error", message: "Failed IntervalTimerCityService -> fromNetwork(). Desc.: \(error)")
                completion(nil)
            }
        })
    }
}
