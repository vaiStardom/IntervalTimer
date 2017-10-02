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
    func didEdit(_ interval: ITVInterval)
}
protocol ITVSwipeToDeleteTimerProtocol{
    func delete(timer: ITVTimer?)
}
protocol ITVSwipeToDeleteIntervalProtocol{
    func delete(index: Int?)
}
