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
        configureNavBar()
        aesthetics_initial()
        
        if itvTimer != nil {
            timerNameTextField.text = itvTimer?.thisName
            
            if (itvTimer?.thisShowWeather!)! {
                showWeatherSwitch.isOn = true
                aesthetics_showWeatherViews()
            } else {
                showWeatherSwitch.isOn = false
                aesthetics_hideWeatherViews()
            }
            
            //TODO: make sure that a timer cannot have a nil temeprature unit and a true show weather option
            //TODO: load all the intervals into the table view
        
        } else {
            timerNameTextField.attributedPlaceholder = NSAttributedString(string: Litterals.TimerNamePlaceholder, attributes: [NSForegroundColorAttributeName : ITVColors.OrangeAlpha50])
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
