//
//  TimersViewControllerTableView.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-20.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

//MARK: - Table View Management
//TODO: add a share button to share the your favorite timer with friends on social media
//TODO: may add favorite timers and put them at the top of the list
extension TimersViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Data source and delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.TimersCell) as! TimersTableViewCell
        let index = (indexPath as NSIndexPath).row
        
        if let theTimer = ITVUser.sharedInstance.thisTimers?[index] {
            cell.timerLabel?.text = theTimer.thisName
            
            cell.totalTimeLabel.text = theTimer.totalTime()
            
            cell.startTimerImageView.image = UIImage(named: Images.TimersCellStartImage)
            cell.startTimerImageView.layer.borderWidth = 1.0
            cell.startTimerImageView.layer.masksToBounds = false
            cell.startTimerImageView.layer.borderColor = ITVColors.Orange.cgColor
            cell.startTimerImageView.layer.cornerRadius = cell.startTimerImageView.frame.size.height/2

            cell.startTimerButton.tag = index
            cell.startTimerButton.addTarget(self, action: #selector(TimersViewController.startTimer(_:)), for: .touchUpInside)
            
            cell.swipeToDeleteDelegate = self
            cell.timer = theTimer
            
            return cell
        } else {
            return cell
        }
    }
    
    //MARK: - Row rearranging
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let timerToMove = ITVUser.sharedInstance.thisTimers?[sourceIndexPath.row]
        ITVUser.sharedInstance.thisTimers?.remove(at: sourceIndexPath.row)
        ITVUser.sharedInstance.thisTimers?.insert(timerToMove!, at: destinationIndexPath.row)

    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
}
