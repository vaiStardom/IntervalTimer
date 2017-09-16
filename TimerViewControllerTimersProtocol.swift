//
//  TimerViewControllerTimersProtocol.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-12.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

extension TimerViewController: ITVTimersProtocol {
    func didUpdateTimers() {
        timerNameLabel.text = ITVUser.sharedInstance.thisTimers?[itvTimerIndex!].thisName
        if (ITVUser.sharedInstance.thisTimers?[itvTimerIndex!].thisShowWeather)! {
            updateWeatherInformation()
        } else {
            aesthetics_hideWeatherView()
        }
    }
}
