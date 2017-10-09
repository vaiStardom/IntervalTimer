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
        if(segue.identifier == Segues.TimersToTimer) {
            if let navVC = segue.destination as? UINavigationController {
                if let nextVC = navVC.viewControllers.first as? TimerViewController {
                    nextVC.itvTimerIndex = itvTimerIndex
                    nextVC.startIntervalTimer = startSelectedIntervalTimer
                    nextVC.updateTimersProtocolDelegate = self
                }
            }
        }
        if(segue.identifier == Segues.TimersToEditTimer) {
            if let navVC = segue.destination as? UINavigationController {
                if let nextVC = navVC.viewControllers.first as? EditTimerViewController {
                    nextVC.itvTimerIndex = itvTimerIndex
                    nextVC.updateTimersProtocolDelegate = self
                }
            }
        }

    }
}
