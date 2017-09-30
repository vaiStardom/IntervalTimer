//
//  EditTimerViewControllerNavigationBar.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-23.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Navigation Bar Management
extension EditTimerViewController {
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
        if !isEditing {
            let backButton = ITVUIBarButtonItem().backButton(target: self, selector: #selector(EditTimerViewController.cancel))
            self.navigationItem.rightBarButtonItems = [rightNegativeSpace, backButton]
        } else {
            let saveButton = ITVUIBarButtonItem().saveButton(target: self, selector: #selector(EditTimerViewController.save))
            self.navigationItem.rightBarButtonItems = [rightNegativeSpace, saveButton]
        }
    }
}
