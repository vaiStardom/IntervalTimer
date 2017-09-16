//
//  TimersViewControllerTableView.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-20.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

//MARK: - Table View Management
extension TimersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itvTimerIndex = indexPath.row
        startSelectedIntervalTimer = false
        performSegue(withIdentifier: "TimersToTimer", sender: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let theCount = ITVUser.sharedInstance.thisTimers?.count {
            return theCount
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimersCell") as! TimersTableViewCell
        let index = (indexPath as NSIndexPath).row
        
        if let theTimer = ITVUser.sharedInstance.thisTimers?[index] {
            cell.timerLabel?.text = theTimer.thisName
            
            cell.totalTimeLabel.text = theTimer.totalTime()
            
            cell.startTimerImageView.image = UIImage(named: "start")
            cell.startTimerImageView.layer.borderWidth = 1.0
            cell.startTimerImageView.layer.masksToBounds = false
            cell.startTimerImageView.layer.borderColor = ITVColors.Orange.cgColor
            cell.startTimerImageView.layer.cornerRadius = cell.startTimerImageView.frame.size.height/2

            print("------> TimerViewController timer = \(theTimer.thisName), showWeather = \(theTimer.thisShowWeather) tempUnit = \(theTimer.thisTemperatureUnit.rawValue)")
            
            cell.startTimerButton.tag = index
            cell.startTimerButton.addTarget(self, action: #selector(TimersViewController.startTimer(_:)), for: .touchUpInside)
            
            return cell
        } else {
            return cell
        }
    }
}
