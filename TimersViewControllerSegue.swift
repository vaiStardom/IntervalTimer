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
            if let navVC = segue.destination as? UINavigationController {
                if let nextVC = navVC.viewControllers.first as? TimerViewController {
                    nextVC.itvTimerIndex = itvTimerIndex
                    nextVC.startIntervalTimer = startSelectedIntervalTimer
                }
            }
        }
        if(segue.identifier == "TimersToEditTimer") {
            if let navVC = segue.destination as? UINavigationController {
                if let nextVC = navVC.viewControllers.first as? EditTimerViewController {
                    nextVC.updateTimersProtocolDelegate = self
                }
            }
        }

    }
}
