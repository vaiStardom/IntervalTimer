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
        
        if !isEditing {
            let backButton = ITVUIBarButtonItem().backButton(target: self, selector: #selector(EditTimerViewController.back))
            self.navigationItem.leftBarButtonItems = [backButton]
        } else {
            let saveButton = ITVUIBarButtonItem().saveButton(target: self, selector: #selector(EditTimerViewController.save))
            self.navigationItem.leftBarButtonItems = [saveButton]
        }

        let label = ITVUILabel().navBarNewTimerTitle()
        self.navigationItem.titleView = label
        
        let rightNegativeSpace = ITVUIBarButtonItem().rightNegativeSpace()
        let cancelButton = ITVUIBarButtonItem().cancelButton(target: self, selector: #selector(EditTimerViewController.cancel))
        self.navigationItem.rightBarButtonItems = [rightNegativeSpace, cancelButton]
    }
}
