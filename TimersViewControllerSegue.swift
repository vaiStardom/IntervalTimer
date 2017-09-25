//
//  TimersViewControllerSegue.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-30.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

// MARK: Segue management
extension TimersViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "TimersToTimer") {
            if let nextVC = segue.destination as? TimerViewController {
                nextVC.itvTimerIndex = itvTimerIndex
                nextVC.startIntervalTimer = startSelectedIntervalTimer
            }
        }
        if(segue.identifier == "TimersToEditTimer") {
            if let nextVC = segue.destination as? EditTimerViewController {
//                nextVC.itvTimerIndex = itvTimerIndex
//                nextVC.updateTimersProtocolDelegate = self
            }
//            if let nextVC = segue.destination as? EditTimerViewController_old {
//                nextVC.itvTimerIndex = itvTimerIndex
//                nextVC.updateTimersProtocolDelegate = self
//            }
        }

    }
}
