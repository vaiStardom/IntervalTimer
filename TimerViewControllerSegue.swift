//
//  TimerViewControllerSegue.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-10.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

// MARK: Segue management
extension TimerViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == Segues.TimerToEditTimer) {
            if let navVC = segue.destination as? UINavigationController {
                if let nextVC = navVC.viewControllers.first as? EditTimerViewController {
                    nextVC.itvTimerIndex = itvTimerIndex
                    nextVC.updateTimersProtocolDelegate = self
                    nextVC.deleteTimerFromTimerViewProtocol = self
                }
            }
        }
        if(segue.identifier == Segues.TimerToEditInterval) {
            if let navVC = segue.destination as? UINavigationController {
                if let nextVC = navVC.viewControllers.first as? EditIntervalViewController {
                    nextVC.itvIntervalToEdit = nil
                    nextVC.editIntervalProtocolDelegate = self
                }
            }
        }
    }
}
