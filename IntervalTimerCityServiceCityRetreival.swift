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
    func getCityAt(latitude: Double, longitude: Double) -> Bool? {
        guard let theUrl = URL(string: "\(providerUrl)key=\(apiKey)&format=json&lat=\(latitude)&lon=\(longitude)&accept-language=en") else {
            return nil
        }
        return getCityWith(theUrl)
    }
    
    private func getCityWith(_ url: URL) -> Bool? {
        
        guard let theUrl = url as URL? else {
            return nil
        }
        
        var didGetCity: Bool?
        
        fromNetwork(with: theUrl) { (intervalTimerCity) in
            guard let theCity = intervalTimerCity?.thisName!.replacingOccurrences(of: self.cityWord, with: "").trimmingCharacters(in: .whitespacesAndNewlines) else {
                didGetCity = false
                return
            }
            guard let theCountryCode = IntervalTimerUser.sharedInstance.thisCountryCode else {
                didGetCity = false
                return
            }
            DispatchQueue.global(qos: .background).async {
                IntervalTimerUser.sharedInstance.thisDidAttemptGettingCityId = true
                //Get the city id with placemark locality, then manage via notifications
                do {
                    let asyncCityId = try IntervalTimerCsv.sharedInstance.getCityIdFromCsv(file: "cityList.20170703", cityName: theCity, countryCode: theCountryCode)
                    DispatchQueue.main.async(execute: {
                        didGetCity = true
                        print("------> IntervalTimerCityService getCityWith() cityId = \(String(describing: asyncCityId))")
                        IntervalTimerUser.sharedInstance.thisCityName = theCity
                        IntervalTimerUser.sharedInstance.thisCityId = asyncCityId
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "didGetCityId"), object: nil)
                    })
                } catch let error {
                    showMessage(title: "CSV Error", message: "Failed IntervalTimerCityService -> getCityIdFromCsv(). Desc.: \(error.localizedDescription)")
                    IntervalTimerUser.sharedInstance.nilLocationName()
                    didGetCity = false
                    return
                }
            }
        }
        return didGetCity
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
            } catch let error {
                showMessage(title: "JSON Error", message: "Failed IntervalTimerCityService -> fromNetwork(). Desc.: \(error.localizedDescription)")
                completion(nil)
            }
        })
    }
}
