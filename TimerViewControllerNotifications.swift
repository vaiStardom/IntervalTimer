//
//  TimerViewControllerNotifications.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-20.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

//MARK: - Notifications
extension TimerViewController{
    func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.didGetCurrentWeather(_:)), name:NSNotification.Name(rawValue: Notifications.didGetCurrentWeather), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.canAttemptWeatherUpdate(_:)), name:NSNotification.Name(rawValue: Notifications.canAttemptWeatherUpdate), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.errorGettingWeather(_:)), name:NSNotification.Name(rawValue: Notifications.errorGettingWeather), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.segueToEditInterval(_:)), name:NSNotification.Name(rawValue: Notifications.segueToEditInterval), object: nil)
    }
}
