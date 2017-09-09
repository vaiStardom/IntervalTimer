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
        let leftTitle = leftTitleLabel()
        self.navigationItem.leftBarButtonItems = [leftTitle]
        
        let negativeSpace = negativeSpc()
        let addButton = addBtn()
        self.navigationItem.rightBarButtonItems = [negativeSpace, addButton]
    }
    func leftTitleLabel() -> UIBarButtonItem {
        return ITVUIBarButtonItem().leftTitle()
    }
    func addBtn() -> UIBarButtonItem {
        return ITVUIBarButtonItem().addButton(target: self, selector: #selector(TimersViewController.addTimer))
    }
    func negativeSpc() -> UIBarButtonItem{
        return ITVUIBarButtonItem().negativeSpace()
    }
}
