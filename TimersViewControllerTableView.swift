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
    
    //MARK: - Row selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itvTimerIndex = indexPath.row
        startSelectedIntervalTimer = false
        performSegue(withIdentifier: "TimersToTimer", sender: nil)
    }

    //MARK: - Data source
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
//            cell.timerLabel?.text = "\(index)-\(theTimer.thisName!)"
            cell.timerLabel?.text = theTimer.thisName
            
            cell.totalTimeLabel.text = theTimer.totalTime()
            
            cell.startTimerImageView.image = UIImage(named: "start")
            cell.startTimerImageView.layer.borderWidth = 1.0
            cell.startTimerImageView.layer.masksToBounds = false
            cell.startTimerImageView.layer.borderColor = ITVColors.Orange.cgColor
            cell.startTimerImageView.layer.cornerRadius = cell.startTimerImageView.frame.size.height/2

            cell.startTimerButton.tag = index
            cell.startTimerButton.addTarget(self, action: #selector(TimersViewController.startTimer(_:)), for: .touchUpInside)
            
            cell.swipeToDeleteDelegate = self
//            cell.timerIndex = index
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
        let itemToMove = ITVUser.sharedInstance.thisTimers?[sourceIndexPath.row]
        ITVUser.sharedInstance.thisTimers?.remove(at: sourceIndexPath.row)
        ITVUser.sharedInstance.thisTimers?.insert(itemToMove!, at: destinationIndexPath.row)

    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

    //TODO: add a share button to share the your favorite timer with friends on social media

//        //TODO: add an "add interval button", interval would be added at bottom of timers intervals list
//        let more = UITableViewRowAction(style: .normal, title: "More") { action, index in
//            //self.isEditing = false
//            print("more button tapped")
//        }
//        more.backgroundColor = UIColor.lightGray
//        
//        
//        //TODO: this can be used to bt the timer at the top of the list or to simply mark it as a fav timer (draw heart)
//        let favorite = UITableViewRowAction(style: .normal, title: "Favorite") { action, index in
//            //self.isEditing = false
//            print("favorite button tapped")
//        }
//        favorite.backgroundColor = UIColor.orange
//        
//        let share = UITableViewRowAction(style: .normal, title: "Share") { action, index in
//            //self.isEditing = false
//            print("share button tapped")
//        }
//        share.backgroundColor = UIColor.blue
//        
//        return [share, favorite, more]
//        
}
