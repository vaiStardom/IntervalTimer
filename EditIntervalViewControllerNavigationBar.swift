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

        //left
        let cancelButton = ITVUIBarButtonItem().cancelButton(target: self, selector: #selector(EditIntervalViewController.cancel))
        self.navigationItem.leftBarButtonItems = [cancelButton]

        //middle
        let label = ITVUILabel().navBarNewTimerTitle()
        self.navigationItem.titleView = label

        //right
        let rightNegativeSpace = ITVUIBarButtonItem().rightNegativeSpace()
        if !isEditingAnInterval! {
            let backButton = ITVUIBarButtonItem().backButton(target: self, selector: #selector(EditIntervalViewController.cancel))
            self.navigationItem.rightBarButtonItems = [rightNegativeSpace, backButton]
        } else {
            let saveButton = ITVUIBarButtonItem().saveButton(target: self, selector: #selector(EditIntervalViewController.save))
            self.navigationItem.rightBarButtonItems = [rightNegativeSpace, saveButton]
        }        
    }
}
