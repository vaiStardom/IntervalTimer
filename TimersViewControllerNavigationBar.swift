//
//  TimersViewControllerNavigationBar.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-20.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

//MARK: - Navigation Bar Management
extension TimersViewController {
    func configureNavBar(){
        
        let rightNegativeSpace = ITVUIBarButtonItem().rightNegativeSpace()
        let leftNegativeSpace = ITVUIBarButtonItem().leftNegativeSpace()
        
        
        let leftTitleButton = ITVUIBarButtonItem().leftTitle()
        self.navigationItem.leftBarButtonItems = [leftNegativeSpace, leftTitleButton]
        
        
        let addButton = ITVUIBarButtonItem().addButton(target: self, selector: #selector(TimersViewController.addTimer))
        
        if !tableView.isEditing {
            let editButton = ITVUIBarButtonItem().timersEditButton(target: self, selector: #selector(TimersViewController.edit))
            self.navigationItem.rightBarButtonItems = [rightNegativeSpace, addButton, editButton]
        } else {
            let editButton = ITVUIBarButtonItem().timersSaveButton(target: self, selector: #selector(TimersViewController.edit))
            self.navigationItem.rightBarButtonItems = [rightNegativeSpace, addButton, editButton]
        }
    }
}
