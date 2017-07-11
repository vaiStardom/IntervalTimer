//
//  IntervalTimerCsvImporter.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-04.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit


//MARK: - Timer Functions
func timeMilliseconds(time: TimeInterval?) -> String? {
    
    guard let totalSecondsLeft = time else {
        return nil
    }
    
    let milliseconds = (Int(totalSecondsLeft) % 60) / 1000
    
    return String(format: "%003i", milliseconds)

}
func time(milliseconds: Int?) -> String? {
    
    guard let theMilliseconds = milliseconds else {
        return nil
    }
    
    let hours = Int(theMilliseconds / 3600000)
    let minutes = Int(theMilliseconds / 3600000) / 60 % 60
    let seconds = Int(theMilliseconds / 3600000) % 60
    
    //return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    return String(format: "%02i", hours, minutes, seconds)
    
}

func stringFromTime(interval: TimeInterval) -> String {
    let ms = Int(interval.truncatingRemainder(dividingBy: 1) * 1000)
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second]
    return formatter.string(from: interval)! + ".\(ms)"
}

extension TimeInterval {
    func timeIntervalAsString(_ format : String = "dd days, hh hours, mm minutes, ss seconds, sss ms") -> String {
        var asInt   = NSInteger(self)
        let ago = (asInt < 0)
        if (ago) {
            asInt = -asInt
        }
        let ms = Int(self.truncatingRemainder(dividingBy: 1) * (ago ? -1000 : 1000))
        let s = asInt % 60
        let m = (asInt / 60) % 60
        let h = ((asInt / 3600))%24
        let d = (asInt / 86400)
        
        var value = format
        value = value.replacingOccurrences(of: "hh", with: String(format: "%0.2d", h))
        value = value.replacingOccurrences(of: "mm",  with: String(format: "%0.2d", m))
        value = value.replacingOccurrences(of: "sss", with: String(format: "%0.3d", ms))
        value = value.replacingOccurrences(of: "ss",  with: String(format: "%0.2d", s))
        value = value.replacingOccurrences(of: "dd",  with: String(format: "%d", d))
        if (ago) {
            value += " ago"
        }
        return value
    }
    
}

func time(time: TimeInterval?) -> String? {

    guard let totalSecondsLeft = time else {
        return nil
    }
    
    let hours = Int(totalSecondsLeft) / 3600
    
    let minutes = Int(totalSecondsLeft) / 60 % 60
    
    let seconds = Int(totalSecondsLeft) % 60
    
    //find out the fraction of milliseconds to be displayed.
    //let fraction = UInt8(totalSecondsLeft * 100)

    //return String(format: "%02i:%02i:%02i:%02i", hours, minutes, seconds, fraction)
    return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
//    if hours > 0 {
//        //            timerLabel.font = intervalTimeFont(seconds: totalSecondsLeft)
//        return String(format: "%02i:%02i:%02i", minutes, seconds)
//    } else if hours == 0 {
//        return String(format: "%02i:%02i", minutes, seconds)
//    } else if minutes == 0 {
//        return String(format: "%02i", seconds)
//    } else {
//        return ""
//    }
}


//MARK: - Messaging Function
func showMessage(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    DispatchQueue.main.async() { () -> Void in
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
}

//MARK: - CSV Functions
//TODO: Make this whole CSV section a class or a struct (try struct!!)

var data: [[String:String]] = []
var columnTitles: [String] = []

func convertCSV(file: String) -> Int? {
    var cityId: Int? = nil
    let rows = cleanRows(file: file).components(separatedBy: CsvControls.LineSeperator)
    if rows.count > 0 {
        data = []
        columnTitles = getStringFieldsForRow(row: rows.first!, delimiter: CsvControls.ColumnDelimiter)
        
        print("---------> convertCSV looking for cityId with cityName = \(String(describing: IntervalTimerUser.sharedInstance.thisCityName!)) and countrycode = \(String(describing: IntervalTimerUser.sharedInstance.thisCountryCode?.lowercased()))")
        for (index, row) in rows.enumerated() {
            let fields = getStringFieldsForRow(row: row, delimiter: CsvControls.ColumnDelimiter)
            
            if fields.count != columnTitles.count {
                //City line mal formated, skip this line and continue searching
                //TODO: find a way to log this error or report it back if this happens in the field
                continue
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
                if theCity == IntervalTimerUser.sharedInstance.thisCityName! && theCountryCode == IntervalTimerUser.sharedInstance.thisCountryCode?.lowercased() {
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
