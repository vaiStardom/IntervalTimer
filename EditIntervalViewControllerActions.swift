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
        aesthetics_manageSelectedColorIndicator(indicatorIndex: 0)
    }
    @IBAction func greenIndicator(_ sender: Any) {
        aesthetics_manageSelectedColorIndicator(indicatorIndex: 1)
    }
    @IBAction func orangeIndicator(_ sender: Any) {
        aesthetics_manageSelectedColorIndicator(indicatorIndex: 2)
    }
    @IBAction func blueIndicator(_ sender: Any) {
        aesthetics_manageSelectedColorIndicator(indicatorIndex: 3)
    }
    @IBAction func yellowIndicator(_ sender: Any) {
        aesthetics_manageSelectedColorIndicator(indicatorIndex: 4)
    }
    @IBAction func purpleIndicator(_ sender: Any) {
        aesthetics_manageSelectedColorIndicator(indicatorIndex: 5)
    }
}
