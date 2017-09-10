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
        
        configureNavBar()
        aesthetics_initial()
        
        //First, is this a selected timer?
        if let theItvTimer = itvTimer {
            //yes
            timerNameTextField.text = theItvTimer.thisName
            //Second, if this is a selected timer, do we show the weather
            if theItvTimer.thisShowWeather! {
                aesthetics_startLoadingWeather()
                showWeather()
            } else {
                aesthetics_dontLoadWeather()
            }
        } else {
            timerNameTextField.attributedPlaceholder = NSAttributedString(string: Litterals.TimerNamePlaceholder, attributes: [NSForegroundColorAttributeName : ITVColors.OrangeAlpha50])
        }

//        if itvTimer != nil {
//            timerNameTextField.text = itvTimer?.thisName
//            
//            if (itvTimer?.thisShowWeather!)! {
//                showWeatherSwitch.isOn = true
//                aesthetics_showWeatherViews()
//            } else {
//                showWeatherSwitch.isOn = false
//                aesthetics_hideWeatherViews()
//            }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
