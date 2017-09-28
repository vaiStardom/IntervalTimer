//
//  ITVProtocols.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-06.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

protocol ITVUserWarningProtocol {
    func show(animated:Bool)
    func dismiss(animated:Bool)
    var backgroundView:UIView {get}
    var dialogView:UIView {get set}
}
protocol ITVUtilitiesProtocol {
}
protocol ITVUpdateTimersProtocol{
    func didUpdateTimers()
}
protocol ITVEditIntervalProtocol{
//    func didUpdateNew(_ intervals:[ITVInterval]?) //if the is a value, then this is an array of intervals for an unsaved timer
//    func didUpdateIntervals(_ updatedIntervals:[ITVInterval]?)
//    func didEditASavedTimersInterval()
    func didEdit(_ interval: ITVInterval)
}
protocol ITVSwipeToDeleteTimerProtocol{
//    func deleteTimer(atIndex: Int?)
    func delete(timer: ITVTimer?)
}
