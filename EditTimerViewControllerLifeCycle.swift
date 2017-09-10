//
//  EditTimerViewControllerLifeCycle.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-01.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

//MARK: - Life-cycle
extension EditTimerViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        aesthetics_initial()
        
        if selectedTimer != nil {
            timerNameTextField.text = selectedTimer?.thisName
            showWeatherSwitch.isOn = (selectedTimer?.thisShowWeather!)!
            
            //TODO: load all the intervals into the table view
        
        } else {
        
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
