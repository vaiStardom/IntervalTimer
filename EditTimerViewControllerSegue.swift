//
//  EditTimerViewControllerSegue.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-26.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

extension EditTimerViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "EditTimerToEditInterval") {
            if let navVC = segue.destination as? UINavigationController {
                if let nextVC = navVC.viewControllers.first as? EditIntervalViewController {
                    if let theSelectedIntervalIndex = itvSelectedIntervalIndex { //user is editing an existing interval
                        if let theIntervalToEdit = intervals?[theSelectedIntervalIndex] {
                            nextVC.itvIntervalToEdit = theIntervalToEdit
                        }
                    } else { //user is adding a new interval
                        nextVC.itvIntervalToEdit = nil
                    }
                    nextVC.editIntervalProtocolDelegate = self
                }
            }
            //            if let nextVC = segue.destination as? EditIntervalViewController {
            //                if let theSelectedIntervalIndex = itvSelectedIntervalIndex { //user is editing an existing interval
            //                    if let theIntervalToEdit = intervals?[theSelectedIntervalIndex] {
            //                        nextVC.itvIntervalToEdit = theIntervalToEdit
            //                    }
            //                } else { //user is adding a new interval
            //                    nextVC.itvIntervalToEdit = nil
            //                }
            //                nextVC.editIntervalProtocolDelegate = self
            //            }
        }
    }
}
