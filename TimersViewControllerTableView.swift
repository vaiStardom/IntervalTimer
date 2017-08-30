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
//        let selectedTimerIndex = indexPath.row
        let selectedTimer = timers[indexPath.row]

        performSegue(withIdentifier: "TimersToTimer", sender: nil)
//        switch inthusiaNotifications[selectedNotificationIndex!].thisEventType {
//        case NotificationType.newArtist.rawValue:
//            
//            self.performSegue(withIdentifier: "NotificationToBiography", sender: nil)
//        case NotificationType.newArtistHosting.rawValue:
//            
//            self.performSegue(withIdentifier: "NotificationToBiography", sender: nil)
//        case NotificationType.newBeaconCrossing.rawValue:
//            
//            let masterpieceName = inthusiaNotifications[selectedNotificationIndex!].thisMasterpieceName
//            //selectedMasterpiece = masterpieces.filter{ $0.thisName == masterpieceName }.first
//            masterpiece = masterpieces.filter{ $0.thisName == masterpieceName }.first
//            self.performSegue(withIdentifier: "NotificationToLabel", sender: nil)
//        case NotificationType.newMasterpeicesByArtist.rawValue:
//            
//            self.performSegue(withIdentifier: "NotificationToMasterpieces", sender: nil)
//        case NotificationType.newVenue.rawValue:
//            
//            let venueName = inthusiaNotifications[selectedNotificationIndex!].thisVenueName!
//            (self.tabBarController as! ExplorationTabBarController).venueToSelect = inthusiaVenues.index(where: {$0.thisName == venueName})!
//            self.tabBarController?.selectedIndex = ExplorationViews.venues.rawValue
//            (self.tabBarController as! ExplorationTabBarController).configureTabBarItems(item: ExplorationViews.venues.rawValue)
//        default:
//            self.performSegue(withIdentifier: "NotificationToLabel", sender: nil)
//        }
    }

    func animateTable(){
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        for a in cells {
            let cell : UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, animations: {
                cell.transform = CGAffineTransform(translationX: 0,y: 0);
            }, completion: nil)
            index += 1
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimersCell") as! TimersTableViewCell
        let index = (indexPath as NSIndexPath).row
        
        cell.timerLabel?.text = timers[index].thisName
        cell.startTimerImageView.image = UIImage(named: "start")
        
        cell.startTimerImageView.layer.borderWidth = 1.0
        cell.startTimerImageView.layer.masksToBounds = false
        cell.startTimerImageView.layer.borderColor = IntervalTimerColors.Orange.cgColor
        cell.startTimerImageView.layer.cornerRadius = cell.startTimerImageView.frame.size.height/2

        
        
        return cell
    }
}
