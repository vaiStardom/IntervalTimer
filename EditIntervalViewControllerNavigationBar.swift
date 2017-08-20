//
//  EditIntervalViewControllerNavigationBar.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-20.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

//MARK: - Navigation Bar Management
extension EditIntervalViewController {
    func configureNavBar(){
        self.navigationItem.hidesBackButton = true
        
        let backButton = IntervalTimerUIBarButtonItem().backButton(target: self, selector: #selector(EditIntervalViewController.back))
        self.navigationItem.leftBarButtonItems = [backButton]
        
        let label = IntervalTimerUILabel().navBarNewIntervalTitle()
        self.navigationItem.titleView = label
        
        let negativeSpace = IntervalTimerUIBarButtonItem().negativeSpace()
        let cancelButton = IntervalTimerUIBarButtonItem().cancelButton(target: self, selector: #selector(EditIntervalViewController.cancel))
        self.navigationItem.rightBarButtonItems = [negativeSpace, cancelButton]
    }
}
