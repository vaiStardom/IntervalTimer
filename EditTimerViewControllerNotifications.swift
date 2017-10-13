//
//  EditTimerViewControllerNotifications.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-23.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

//MARK: - Notifications
extension EditTimerViewController {
    func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(EditTimerViewController.canAttemptWeatherUpdate(_:)), name:NSNotification.Name(rawValue: Notifications.canAttemptWeatherUpdate), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(EditTimerViewController.didGetCurrentWeather(_:)), name:NSNotification.Name(rawValue: Notifications.didGetCurrentWeather), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(EditTimerViewController.didAuthorizeLocationServices(_:)), name:NSNotification.Name(rawValue: Notifications.didAuthorizeLocationServices), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(EditTimerViewController.errorGettingWeather(_:)), name:NSNotification.Name(rawValue: Notifications.errorGettingWeather), object: nil)
    }
}

