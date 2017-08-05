//
//  IntervalTimerCityService.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-31.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation


struct IntervalTimerCityService {
    
    //MARK: - fileprivate properties
    fileprivate let cityWord = " city"
    fileprivate var apiKey: String       //NOMINATIM - MapQuest //iaGiN8vTI73I5Kpa0YPrVVblLvjPAfYF
    fileprivate var providerUrl: String  //NOMINATIM - MapQuest //http://open.mapquestapi.com/nominatim/v1/reverse.php?
    
    //MARK: - public get/set properties
    var thisApiKey: String {
        get { return apiKey }
    }
    var thisProviderUrl: String {
        get { return providerUrl }
    }
    
    //MARK: - Initializers
    init?(apiKey: String, providerUrl: String) {
        guard let theApiKey = apiKey as String? else {
            return nil
        }
        guard let theProviderUrl = providerUrl as String? else {
            return nil
        }
        self.apiKey = theApiKey
        self.providerUrl = theProviderUrl
    }
}
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
            
            //TODO: Make sure the weather is updated from a legitimate cityId
            DispatchQueue.global().async {
                
                IntervalTimerUser.sharedInstance.thisDidAttemptGettingCityId = true
                
                //Get the city id with placemark locality, then manage via notifications
                do {
                    let asyncCityId = try IntervalTimerCsv.sharedInstance.getCityIdFromCsv(file: "cityList.20170703", cityName: theCity, countryCode: theCountryCode)
                    
                    DispatchQueue.main.async(execute: {
                        didGetCity = true
                        print("------> IntervalTimerCityService getCityWith() cityId = \(asyncCityId)")
                        IntervalTimerUser.sharedInstance.thisCityName = theCity
                        IntervalTimerUser.sharedInstance.thisCityId = asyncCityId
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "didGetCityId"), object: nil)
                    })
                    
                    
                    
                } catch {
                    print("------> IntervalTimerCityService getCityIdFromCsv() failed")
                    IntervalTimerUser.sharedInstance.nilLocationName()
                    didGetCity = false
                    return
                }
                
                
                
            }
        }
        return didGetCity
    }
    
    private func fromNetwork(with url: URL, completion: @escaping (IntervalTimerCity?) -> Void ){
        
        guard let theNetworkJson = IntervalTimerNetworkJSON(url: url) else {
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
                print(error)
                completion(nil)
            }
        })
    }
}
