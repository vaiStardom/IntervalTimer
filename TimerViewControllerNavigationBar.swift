//
//  TimerViewControllerNavigationBar.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-20.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

//MARK: - Navigation Bar Management
extension TimerViewController {
    func configureNavBar(){
        self.navigationItem.hidesBackButton = true
        
        let backButton = IntervalTimerUIBarButtonItem().backButton(target: self, selector: #selector(TimerViewController.back))
        self.navigationItem.leftBarButtonItems = [backButton]
        
        let negativeSpace = IntervalTimerUIBarButtonItem().negativeSpace()
        let editButton = IntervalTimerUIBarButtonItem().editButton(target: self, selector: #selector(TimerViewController.edit))
        self.navigationItem.rightBarButtonItems = [negativeSpace, editButton]
    }
}
