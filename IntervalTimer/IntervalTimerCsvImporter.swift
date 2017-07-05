//
//  IntervalTimerCsvImporter.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-04.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

var data: [[String:String]] = []
var columnTitles: [String] = []

var CSV_DELIMITER: String = "\t"
let CSV_LINE_SEPERATOR: String = "\n"

func convertCSV(file: String) -> Int? {
    var cityId: Int? = nil
    let rows = cleanRows(file: file).components(separatedBy: CSV_LINE_SEPERATOR)
    if rows.count > 0 {
        data = []
        columnTitles = getStringFieldsForRow(row: rows.first!, delimiter: CSV_DELIMITER)
        
        print("---------> convertCSV looking for cityId with cityName = \(String(describing: IntervalTimerUser.sharedInstance.thisCity!)) and countrycode = \(String(describing: IntervalTimerUser.sharedInstance.thisIsoCountryCode?.lowercased()))")
        for (index, row) in rows.enumerated() {
            let fields = getStringFieldsForRow(row: row, delimiter: CSV_DELIMITER)
            
            if fields.count != columnTitles.count {
                //A field may contain double quotes with comma inside
                //TODO: Handle error csv mal formatted
                print("---------> convertCSV IMPORT ERROR: fields.count= \(fields.count), columnTitles.count= \(columnTitles.count)")
                print("---------> convertCSV ENTRY: \(fields)")
            } else {
                guard let theCityId = Int(fields[0].trimmingCharacters(in: .whitespacesAndNewlines)) else {
                    print("---------> convertCSV theCityId = \(fields[0]) could not be converted to Int for row with 'values\(row)' at index '\(index)'")
                    continue
                }
                guard let theCity = fields[1].trimmingCharacters(in: .whitespacesAndNewlines) as String? else {
                    print("---------> convertCSV theCity = \(fields[1]) could not be converted to String at row \(row), index \(index)")
                    continue
                }
                guard let theCountryCode = fields[2].lowercased().trimmingCharacters(in: .whitespacesAndNewlines)  as String? else {
                    print("---------> convertCSV theCountryCode = \(fields[2]) could not be converted to String at row \(row), index \(index)")
                    continue
                }
                if theCity == IntervalTimerUser.sharedInstance.thisCity! && theCountryCode == IntervalTimerUser.sharedInstance.thisIsoCountryCode?.lowercased() {
                    cityId = theCityId
                    print("---------> convertCSV found cityId = \(theCityId)")
                    break
                }
            }
        }
        return cityId
    } else {
        //TODO: Handle error city not found
        print("No data in file")
        return nil
    }
}
func getStringFieldsForRow(row: String, delimiter: String) -> [String] {
    return row.components(separatedBy: delimiter)
}
func getCityIdFromCsv(file: String, cityName: String, countryCode: String) -> Int? {
    guard let filePath = Bundle.main.path(forResource: file, ofType: "csv") else {
        //TODO: Handle possible csv read error
        print("-------> FILE READ ERROR: file \(file) not read.")
        return nil
    }
    do {
        let contents = try String(contentsOfFile: filePath, encoding: String.Encoding.macOSRoman)
        return convertCSV(file: contents)
    } catch {
        //TODO: Handle possible csv read error
        print("File read error for file \(file). Error: \(error)")
        return nil
    }
}
func cleanRows(file: String) -> String {
    var cleanFile = file
    cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
    cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
    return cleanFile
}