//
//  EditTimerViewControllerNotifications.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-08.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

//MARK: - Notifications
extension EditTimerViewController_old {
    func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(EditTimerViewController_old.canAttemptWeatherUpdate(_:)), name:NSNotification.Name(rawValue: "canAttemptWeatherUpdate"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(EditTimerViewController_old.didGetCurrentWeather(_:)), name:NSNotification.Name(rawValue: "didGetCurrentWeather"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(EditTimerViewController_old.didAuthorizeLocationServices(_:)), name:NSNotification.Name(rawValue: "didAuthorizeLocationServices"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(EditTimerViewController_old.errorGettingWeather(_:)), name:NSNotification.Name(rawValue: "errorGettingWeather"), object: nil)
    }
}
