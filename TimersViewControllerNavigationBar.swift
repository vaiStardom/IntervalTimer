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
        
        let leftTitleButton = ITVUIBarButtonItem().iCloudSyncButton(target: self, selector: #selector(TimersViewController.iCloudSync))
        self.navigationItem.leftBarButtonItems = [leftTitleButton]
        
        let addButton = ITVUIBarButtonItem().addButton(target: self, selector: #selector(TimersViewController.addTimer))
        if !tableView.isEditing {
            let editButton = ITVUIBarButtonItem().editButton(target: self, selector: #selector(TimersViewController.edit))
            self.navigationItem.rightBarButtonItems = [addButton, editButton]
        } else {
            let saveButton = ITVUIBarButtonItem().timersSaveButton(target: self, selector: #selector(TimersViewController.edit))
            self.navigationItem.rightBarButtonItems = [addButton, saveButton]
        }
    }
}
