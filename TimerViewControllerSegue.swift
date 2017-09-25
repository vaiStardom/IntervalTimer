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
        if(segue.identifier == "TimerToEditTimer") {
            if let nextVC = segue.destination as? EditTimerViewController {
                nextVC.itvTimerIndex = itvTimerIndex
                nextVC.updateTimersProtocolDelegate = self
            }
//            if let nextVC = segue.destination as? EditTimerViewController_old {
//                nextVC.itvTimerIndex = itvTimerIndex
//                nextVC.updateTimersProtocolDelegate = self
//            }
        }
    }
}
