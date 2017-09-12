//
//  EditViewControllerSegue.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-12.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

extension EditTimerViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "EditTimerToEditInterval") {
            if let nextVC = segue.destination as? EditIntervalViewController {
                nextVC.itvIntervalIndex = itvIntervalIndex
                nextVC.itvTimerIndex = itvTimerIndex
                if itvTimerIndex == nil {
                    nextVC.itvUnsavedTimersIntervals = itvUnsavedTimersIntervals
                }
            }
        }
    }
}
