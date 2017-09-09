//
//  EditTimerViewControllerNavigationBar.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-01.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

//MARK: - Navigation Bar Management
extension EditTimerViewController {
    func configureNavBar(){
        self.navigationItem.hidesBackButton = true
        
        let backButton = ITVUIBarButtonItem().backButton(target: self, selector: #selector(EditTimerViewController.back))
        self.navigationItem.leftBarButtonItems = [backButton]
        
        let label = ITVUILabel().navBarNewTimerTitle()
        self.navigationItem.titleView = label
        
        let negativeSpace = ITVUIBarButtonItem().negativeSpace()
        let cancelButton = ITVUIBarButtonItem().cancelButton(target: self, selector: #selector(EditTimerViewController.cancel))
        self.navigationItem.rightBarButtonItems = [negativeSpace, cancelButton]
    }
}
