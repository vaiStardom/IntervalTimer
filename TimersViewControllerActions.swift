//
//  TimersViewControllerActions.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-29.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

//MARK: - Actions
extension TimersViewController{
    func addTimer(){
        performSegue(withIdentifier: "TimersToEditTimer", sender: nil)
        //performSegue(withIdentifier: "TimersToTimer", sender: nil)
    }
    func startTimer(_ sender: UIButton) {
        itvTimer = timers[sender.tag]
        startSelectedIntervalTimer = true
        performSegue(withIdentifier: "TimersToTimer", sender: self)
    }
}
