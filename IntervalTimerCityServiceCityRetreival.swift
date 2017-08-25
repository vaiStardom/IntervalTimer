//
//  IntervalTimerCityServiceCityRetreival.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-20.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

//MARK: - City retreival management
extension IntervalTimerCityService {
    
    //http://open.mapquestapi.com/nominatim/v1/reverse.php?key=iaGiN8vTI73I5Kpa0YPrVVblLvjPAfYF&format=json&lat=45.514589&lon=-73.559794&accept-language=en
    func getCityIdAt(latitude: Double, longitude: Double) throws {
        guard let theUrl = URL(string: "\(providerUrl)key=\(apiKey)&format=json&lat=\(latitude)&lon=\(longitude)&accept-language=en") else {
            throw GetCityIdError.urlIsNil
        }
        do {
            try getCityIdWith(theUrl)
        } catch let error as NSError {
            print("ERROR -> IntervalTimerCityService getCityIdAt() -> \(error.localizedDescription)")
        }
    }
    
    //Here we attempt a second time at getting a city ID using a MapQuest city name
    private func getCityIdWith(_ url: URL) throws {
        
        guard let theUrl = url as URL? else {
            throw GetCityIdError.urlIsNil
        }
        
        var didGetCity = true
        
        fromNetwork(with: theUrl) { (intervalTimerCity) in
            guard let theCity = intervalTimerCity?.thisName!.replacingOccurrences(of: self.cityWord, with: "").trimmingCharacters(in: .whitespacesAndNewlines) else {
                didGetCity = false
                return
            }
            
            IntervalTimerUser.sharedInstance.thisCityName = theCity
            
            guard let theCountryCode = IntervalTimerUser.sharedInstance.thisCountryCode else {
                didGetCity = false
                return
            }
            
            if didGetCity == true {
                //First try to get the city id using core locations city name and country code
                do {
                    try IntervalTimerCsv.sharedInstance.getCityId(cityName: theCity, countryCode: theCountryCode)
                } catch let error as NSError {
                    print("ERROR -> IntervalTimerCityService getCityIdWith() -> \(error.localizedDescription)")
                    didGetCity = false
                }
//                DispatchQueue.global(qos: .background).async {
//                    if let asyncCityId = IntervalTimerCsv.sharedInstance.getCityId(cityName: theCity, countryCode: theCountryCode) {
//                        DispatchQueue.main.async(execute: {
//                            didGetCity = true
//                            print("------> IntervalTimerCityService getCityWith() cityId = \(String(describing: asyncCityId))")
//                            IntervalTimerUser.sharedInstance.thisCityId = asyncCityId
//                            //                        NotificationCenter.default.post(name: Notification.Name(rawValue: "didGetCityId"), object: nil)
//                        })
//                    }
//                }
            }
        }
        if didGetCity == false {
            throw GetCityIdError.noCityId(reason: "Could not get city name from URL \(theUrl) ")
        }
    }
    
    private func fromNetwork(with url: URL, completion: @escaping (IntervalTimerCity?) -> Void ){
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
            } catch let error as NSError {
                //TODO: Handle case where network connexions are disables (same way as the disabled locations services)
                showMessage(title: "JSON Error", message: "Failed IntervalTimerCityService -> fromNetwork(). Desc.: \(error.localizedDescription)")
                completion(nil)
            }
        })
    }
}
