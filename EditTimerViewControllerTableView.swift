//
//  EditTimerViewControllerTableView.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-10.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Table View Management
extension EditTimerViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itvInterval = itvTimer?.thisIntervals![indexPath.row]
        performSegue(withIdentifier: "EditTimerToEditInterval", sender: nil)
    }
    
    //TODO: Only do this animation only when app launches, stop doing it at every view appear
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
        if let theCount = itvTimer?.thisIntervals!.count {
            return theCount
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IntervalCell") as! IntervalTableViewCell
        let index = (indexPath as NSIndexPath).row
        let interval = itvTimer?.thisIntervals?[index]
        
        cell.indicatorImageView.backgroundColor = interval?.thisIndicator?.uiColor()
        cell.indicatorImageView.layer.borderColor = interval?.thisIndicator?.uiColor().cgColor
        cell.indicatorImageView.roundImageView()
        cell.intervalNumberLabel.text = "\(index + 1)"
        if let theSeconds = interval?.thisSeconds {
            cell.intervalTimeLabel.text = realTimeOf(seconds: theSeconds)
        } else {
            cell.intervalTimeLabel.text = "0"
        }
        return cell
    }
}
