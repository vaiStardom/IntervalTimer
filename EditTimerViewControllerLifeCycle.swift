//
//  EditTimerViewControllerLifeCycle.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-22.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Life-cycle
extension EditTimerViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: view)
        }
        
        configureNavBar()
        configureTableView()
        
        //put in view did layout subviews
        //        //First, is this a selected timer?
        //        if let theTimerIndex = itvTimerIndex, ITVUser.sharedInstance.thisTimers?[theTimerIndex] != nil {
        //            topCell().timerNameTextField.text = ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisName
        //
        //            //Find and show the grouped unique intervals for quick additions
        //            if let theIntervals = ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisIntervals {
        //                intervals = theIntervals
        //                uniqueArrays(intervals: theIntervals)
        //            }
        //
        //            //Second, if this is a selected timer, do we show the weather
        //            if (ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisShowWeather)! {
        //                topCell().showWeatherSwitch.isOn = true
        //                if let theTemperatureUnit = ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisTemperatureUnit {
        //                    topCell().temperatureSegmentedControl.selectedSegmentIndex = theTemperatureUnit.rawValue
        //                }
        //                aesthetics_startLoadingWeather()
        //                showWeather()
        //            } else {
        //                aesthetics_dontLoadWeather()
        //            }
        //        } else {
        //            intervals = []
        //        }
        
        
        
        
        
        //        intervals = mock_intervals
        //        for interval in mock_intervals {
        //
        //            let hasThisIntervalBeenFiltered = uniqueTimers.filter({ $0.0.thisSeconds == interval.thisSeconds && $0.0.thisIndicator == interval.thisIndicator })
        //
        //            if hasThisIntervalBeenFiltered.count == 0 {
        //                let theFilteredArray = mock_intervals.filter({ $0.thisSeconds == interval.thisSeconds && $0.thisIndicator == interval.thisIndicator })
        //                if theFilteredArray.count > 0 {
        //                    uniqueTimers.append((interval, theFilteredArray.count))
        //                    print("Added interval seconds \(interval.thisSeconds) type \(interval.thisIndicator) appearing \(theFilteredArray.count) times")
        //                }
        //            }
        //        }
        
        //        if uniqueTimers.count > 0 {
        //            uniqueTimers = uniqueTimers.sorted(by: {$0.1 < $1.1})
        //        }
    }
    
    override func viewDidLayoutSubviews() {
        
        //First, is this a selected timer?
        if let theTimerIndex = itvTimerIndex, ITVUser.sharedInstance.thisTimers?[theTimerIndex] != nil {
            topCell().timerNameTextField.text = ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisName
            
            //Find and show the grouped unique intervals for quick additions
            if let theIntervals = ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisIntervals {
                intervals = theIntervals
                uniqueArrays(intervals: theIntervals)
            }

            //Second, if this is a selected timer, do we show the weather
            if let theShowWeather = ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisShowWeather {
                topCell().showWeatherSwitch.isOn = theShowWeather
                if theShowWeather {
                    if let theTemperatureUnit = ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisTemperatureUnit {
                        topCell().temperatureSegmentedControl.selectedSegmentIndex = theTemperatureUnit.rawValue
                    }
                    aesthetics_startLoadingWeather()
                    showWeather()
                } else {
                    aesthetics_dontLoadWeather()
                }
            } else {
                topCell().showWeatherSwitch.isOn = false
                aesthetics_dontLoadWeather()
            }
        } else {
            if let theUnsavedIntervals = itvUnsavedTimersIntervals {
                intervals = theUnsavedIntervals
            } else {
                intervals = []
            }
        }
        
        //for each iphone type, calculate if the visible cells
        var heightOfTableView: CGFloat = 0.0
        let cells = self.tableView.visibleCells
        for cell in cells {
            heightOfTableView += cell.frame.height
        }

//        if heightOfTableView > (self.view.frame.height - 74) {
        if heightOfTableView > self.view.frame.height {
            bottomCell().deleteTimerButton.isEnabled = true
            bottomCell().deleteTimerLabel.isHidden = false
            tableView.isScrollEnabled = true
            deleteLabel.isHidden = true
            deleteButton.isHidden = true
            deleteButton.isEnabled = false
        } else {
            bottomCell().deleteTimerButton.isEnabled = false
            bottomCell().deleteTimerLabel.isHidden = true
            bottomCell().selectionStyle = .none
            tableView.isScrollEnabled = false
            deleteLabel.isHidden = false
            deleteButton.isHidden = false
            deleteButton.isEnabled = true

        }
        
        //        bottomCell().isHidden = true
        print("------> EditTimerViewController cell count = \(cells.count), heightOfTableView = \(heightOfTableView)")
        
        //        let lastRowIndex = cells.count - 1
        //        let indexPathForRow = IndexPath(row: lastRowIndex, section: 0)
        //        tableView.deleteRows(at: [indexPathForRow], with: .left)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
