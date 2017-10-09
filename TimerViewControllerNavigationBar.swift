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
        
        let editButton = ITVUIBarButtonItem().editButton(target: self, selector: #selector(TimerViewController.edit))
        let backButton = ITVUIBarButtonItem().backButton(target: self, selector: #selector(TimerViewController.back))
        self.navigationItem.rightBarButtonItems = [backButton, editButton]
    }
}
