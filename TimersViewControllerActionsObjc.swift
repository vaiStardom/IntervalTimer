//
//  TimersViewControllerActionsObjc.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-23.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit
//MARK: - Actions Objc
@objc extension TimersViewController{
    func addTimer(){
        itvTimerIndex = nil
        performSegue(withIdentifier: Segues.TimersToEditTimer, sender: nil)
        //performSegue(withIdentifier: "TimersToTimer", sender: nil)
    }
    func startTimer(_ sender: UIButton) {
        itvTimerIndex = sender.tag
        startSelectedIntervalTimer = true
        performSegue(withIdentifier: Segues.TimersToTimer, sender: self)
    }
    //TODO: Change label to save when editing
    func edit(){
        tableView.isEditing = !tableView.isEditing
        configureNavBar()
    }
    func iCloudSync(){
        print("icloud sync...")
    }
}
