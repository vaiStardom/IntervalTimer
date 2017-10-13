//
//  EditTimerViewControllerForceTouch.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-23.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

extension EditTimerViewController: UIViewControllerPreviewingDelegate {
    
    @available(iOS 9.0, *)
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        self.navigationController!.show((viewControllerToCommit as! UINavigationController).viewControllers[0], sender: self)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        //make sure the is actually a table cell where the user force touched
        guard let theTableViewIndexPath = tableView.indexPathForRow(at: tableView.convert(location, from: view))
        , let theTableViewCell = tableView.cellForRow(at: theTableViewIndexPath) else {
            return nil
        }
        
        //make sure the user force touched an interval
        if theTableViewIndexPath.row >= tableViewIntervalIndexOffset
            && theTableViewIndexPath.row < (dataSourceCount() + tableViewIntervalIndexOffset) {
        
            //get the interval's index from the tableViewCell's tag
            itvSelectedIntervalIndex = theTableViewCell.tag
            
            guard let theForceTouchedInterval = intervals?[theTableViewCell.tag] else {
                return nil
            }
            
            guard let nextVC = storyboard?.instantiateViewController(withIdentifier: Nibs.EditIntervalViewController) as? EditIntervalViewController else {
                return nil
            }
            
            nextVC.itvIntervalToEdit = theForceTouchedInterval
            nextVC.editIntervalProtocolDelegate = self
            
            let navigationController = UINavigationController(rootViewController: nextVC)
            return navigationController

        } else {
            return nil
        }
    }
}
