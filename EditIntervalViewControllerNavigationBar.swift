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
        
        if !isEditingAnInterval! {
            let backButton = ITVUIBarButtonItem().backButton(target: self, selector: #selector(EditIntervalViewController.back))
            self.navigationItem.leftBarButtonItems = [backButton]
        } else {
            let saveButton = ITVUIBarButtonItem().backButton(target: self, selector: #selector(EditIntervalViewController.save))
            self.navigationItem.leftBarButtonItems = [saveButton]
        }

        let label = ITVUILabel().navBarNewIntervalTitle()
        self.navigationItem.titleView = label
        
        let negativeSpace = ITVUIBarButtonItem().negativeSpace()
        let cancelButton = ITVUIBarButtonItem().cancelButton(target: self, selector: #selector(EditIntervalViewController.cancel))
        self.navigationItem.rightBarButtonItems = [negativeSpace, cancelButton]
    }
}
