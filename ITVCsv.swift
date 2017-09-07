//
//  ITVCsv.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-31.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

class ITVCsv {
    
    //MARK: - Singleton
    static let sharedInstance = ITVCsv()
    
    //MARK: - Fileprivate properties
    fileprivate var data: [[String:String]] = []
    fileprivate var columnTitles: [String] = []
    
    //MARK: - init()
    private init(){}
    
    private func getCityIdFromCsv(file: String, cityName: String, countryCode: String) throws -> Int? {
        guard let filePath = Bundle.main.path(forResource: file, ofType: "csv") else {
            throw ITVError.CSV_ReadError("file \(file) not read")
            //throw CsvError.readError("file \(file) not read")
        }
        do {
            let contents = try String(contentsOfFile: filePath, encoding: String.Encoding.macOSRoman)
            return convertCSV(file: contents, cityName: cityName, countryCode: countryCode )
        } catch let error {
            //TODO: Handle possible csv read error
            print("------> ERROR IntervalTimerCsv getCityIdFromCsv() -> File read error for file \(file). Error: \(error)")
            return nil
        }
    }
    private func convertCSV(file: String, cityName: String, countryCode: String) -> Int? {
        var cityId: Int? = nil
        let rows = cleanRows(file: file).components(separatedBy: CsvControls.LineSeperator)
        if rows.count > 0 {
            data = []
            columnTitles = getStringFieldsForRow(row: rows.first!, delimiter: CsvControls.ColumnDelimiter)
            
            print("------> IntervalTimerCsv convertCSV looking for cityId with cityName = \(String(describing: cityName)) and countrycode = \(String(describing: countryCode.lowercased()))")
            for (index, row) in rows.enumerated() {
                let fields = getStringFieldsForRow(row: row, delimiter: CsvControls.ColumnDelimiter)
                
                if fields.count != columnTitles.count {
                    //City line mal formated, skip this line and continue searching
                    //TODO: find a way to log this error or report it back if this happens in the field
                    continue
                } else {
                    guard let theCityId = Int(fields[0].trimmingCharacters(in: .whitespacesAndNewlines)) else {
                        print("------> IntervalTimerCsv convertCSV theCityId = \(fields[0]) could not be converted to Int for row with 'values\(row)' at index '\(index)'")
                        continue
                    }
                    guard let theCity = fields[1].trimmingCharacters(in: .whitespacesAndNewlines) as String? else {
                        print("------> IntervalTimerCsv convertCSV theCity = \(fields[1]) could not be converted to String at row \(row), index \(index)")
                        continue
                    }
                    guard let theCountryCode = fields[2].lowercased().trimmingCharacters(in: .whitespacesAndNewlines)  as String? else {
                        print("------> IntervalTimerCsv convertCSV theCountryCode = \(fields[2]) could not be converted to String at row \(row), index \(index)")
                        continue
                    }
                    if theCity == cityName && theCountryCode == countryCode.lowercased() {
                        cityId = theCityId
                        print("------> IntervalTimerCsv convertCSV found cityId = \(theCityId)")
                        break
                    }
                }
            }
            print("------> IntervalTimerCsv convertCSV returning cityId = \(String(describing: cityId))")
            return cityId
        } else {
            //TODO: Handle error city not found
            print("No data in file")
            return nil
        }
    }
    private func getStringFieldsForRow(row: String, delimiter: String) -> [String] {
        return row.components(separatedBy: delimiter)
    }
    private func cleanRows(file: String) -> String {
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile
    }
    
    //MARK: - Typealias
    typealias ITVCsvErrorHandler = ((Error?) -> Void)
    
    func getCityId(cityName: String, countryCode: String, completion: @escaping ITVCsvErrorHandler) {
//    func getCityId(cityName: String, countryCode: String) throws {
    
        var error: Error?
        
        guard let theCityName = cityName as String? else {
            error = ITVError.GetCityId_CityNameIsNil(reason: "City name is nil")
            completion(error)
            return
            //throw ITVError.GetCityId_CityNameIsNil(reason: "City name is nil")
            //throw GetCityIdError.cityNameIsNil(reason: "City name is nil")
        }
        
        guard let theCountryCode = countryCode as String? else {
            error = ITVError.GetCityId_CountryCodeIsNil(reason: "Country code is nil")
            completion(error)
            return
            //throw ITVError.GetCityId_CountryCodeIsNil(reason: "Country code is nil")
            //throw GetCityIdError.countryCodeIsNil(reason: "Country code is nil")
        }
        
        var didGetCityId: Bool?
        
        //Get the city id with placemark locality, then manage via notifications
        do {
            let theCityId = try self.getCityIdFromCsv(file: "cityList.20170703", cityName: theCityName, countryCode: theCountryCode)
            if theCityId != nil {
                DispatchQueue.main.async(execute: {
                    print("------> IntervalTimerCsv getCityId(cityName:countryCode:) setting IntervalTimerCoreLocation.sharedInstance.thisCityId = \(String(describing: theCityId))")
                    ITVCoreLocation.sharedInstance.thisCityId = theCityId
                })
                completion(nil)
            } else {
                didGetCityId = false
            }
        } catch let error {
            print("------> ERROR IntervalTimerCsv getCityId() -> \(error)")
            completion(error)
            didGetCityId = false
        }
        
        //TODO: find another way to throw errors from the dispatch queue, since this line never gets executed because the dispacth is async, so execution just goes over this..
        if let theDidGetCityId = didGetCityId, theDidGetCityId == false {
            error = ITVError.GetCityId_NoCityId(reason: "No city id for city name \(theCityName) and country code \(theCountryCode)")
            completion(error)
            //throw ITVError.GetCityId_NoCityId(reason: "No city id for city name \(theCityName) and country code \(theCountryCode)")
//            throw GetCityIdError.noCityId(reason: "No city id for city name \(theCityName) and country code \(theCountryCode)")
        }
    }
}
