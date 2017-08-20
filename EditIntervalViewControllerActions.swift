//
//  EditIntervalViewControllerActions.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-20.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

//MARK: - Actions
extension EditIntervalViewController {
    @IBAction func redIndicator(_ sender: Any) {
        manageSelectedColorIndicator(indicatorIndex: 0)
    }
    @IBAction func greenIndicator(_ sender: Any) {
        manageSelectedColorIndicator(indicatorIndex: 1)
    }
    @IBAction func orangeIndicator(_ sender: Any) {
        manageSelectedColorIndicator(indicatorIndex: 2)
    }
    @IBAction func blueIndicator(_ sender: Any) {
        manageSelectedColorIndicator(indicatorIndex: 3)
    }
    @IBAction func yellowIndicator(_ sender: Any) {
        manageSelectedColorIndicator(indicatorIndex: 4)
    }
    @IBAction func purpleIndicator(_ sender: Any) {
        manageSelectedColorIndicator(indicatorIndex: 5)
    }
    func back(){
        _ = navigationController?.popViewController(animated: true)
    }
    func cancel(){
        _ = navigationController?.popViewController(animated: true)
    }
}
