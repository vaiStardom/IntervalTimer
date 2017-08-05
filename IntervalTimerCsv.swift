//
//  IntervalTimerCsv.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-31.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

class IntervalTimerCsv {
    
    //MARK: - Singleton
    static let sharedInstance = IntervalTimerCsv()
    
    private var data: [[String:String]] = []
    private var columnTitles: [String] = []
    
    public func getCityIdFromCsv(file: String, cityName: String, countryCode: String) throws -> Int? {
        guard let filePath = Bundle.main.path(forResource: file, ofType: "csv") else {
            throw CsvError.readError("file \(file) not read")
        }
        do {
            let contents = try String(contentsOfFile: filePath, encoding: String.Encoding.macOSRoman)
            return convertCSV(file: contents, cityName: cityName, countryCode: countryCode )
        } catch {
            //TODO: Handle possible csv read error
            print("File read error for file \(file). Error: \(error)")
            return nil
        }
    }
    private func convertCSV(file: String, cityName: String, countryCode: String) -> Int? {
        var cityId: Int? = nil
        let rows = cleanRows(file: file).components(separatedBy: CsvControls.LineSeperator)
        if rows.count > 0 {
            data = []
            columnTitles = getStringFieldsForRow(row: rows.first!, delimiter: CsvControls.ColumnDelimiter)
            
            print("------> convertCSV looking for cityId with cityName = \(String(describing: cityName)) and countrycode = \(String(describing: countryCode.lowercased()))")
            for (index, row) in rows.enumerated() {
                let fields = getStringFieldsForRow(row: row, delimiter: CsvControls.ColumnDelimiter)
                
                if fields.count != columnTitles.count {
                    //City line mal formated, skip this line and continue searching
                    //TODO: find a way to log this error or report it back if this happens in the field
                    continue
                } else {
                    guard let theCityId = Int(fields[0].trimmingCharacters(in: .whitespacesAndNewlines)) else {
                        print("------> convertCSV theCityId = \(fields[0]) could not be converted to Int for row with 'values\(row)' at index '\(index)'")
                        continue
                    }
                    guard let theCity = fields[1].trimmingCharacters(in: .whitespacesAndNewlines) as String? else {
                        print("------> convertCSV theCity = \(fields[1]) could not be converted to String at row \(row), index \(index)")
                        continue
                    }
                    guard let theCountryCode = fields[2].lowercased().trimmingCharacters(in: .whitespacesAndNewlines)  as String? else {
                        print("------> convertCSV theCountryCode = \(fields[2]) could not be converted to String at row \(row), index \(index)")
                        continue
                    }
                    if theCity == cityName && theCountryCode == countryCode.lowercased() {
                        cityId = theCityId
                        print("------> convertCSV found cityId = \(theCityId)")
                        break
                    }
                }
            }
            print("------> convertCSV returning cityId = \(String(describing: cityId))")
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
}
