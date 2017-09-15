//
//  EditTimerViewControllerLifeCycle.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-01.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Life-cycle
extension EditTimerViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "IntervalTableViewCell", bundle: nil), forCellReuseIdentifier: "IntervalCell")
        
        timerNameTextField.delegate = self
        
        configureNavBar()
        aesthetics_initial()
        
        //First, is this a selected timer?
        if let theTimerIndex = itvTimerIndex, ITVUser.sharedInstance.thisTimers?[theTimerIndex] != nil {
            timerNameTextField.text = ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisName
            //Second, if this is a selected timer, do we show the weather
            if (ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisShowWeather)! {
                if let theTemperatureUnit = ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisTemperatureUnit {
                    temperatureSegmentedControl.selectedSegmentIndex = theTemperatureUnit.rawValue
                }
                aesthetics_startLoadingWeather()
                showWeather()
            } else {
                aesthetics_dontLoadWeather()
            }
        } else {
            aesthetics_timerNamePlaceHolder()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
