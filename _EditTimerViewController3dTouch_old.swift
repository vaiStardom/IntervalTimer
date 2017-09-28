//
//  EditTimerViewController3dTouch.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-18.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

extension EditTimerViewController_old: UIViewControllerPreviewingDelegate {
    
    @available(iOS 9.0, *)
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        self.navigationController!.show((viewControllerToCommit as! UINavigationController).viewControllers[0], sender: self)
        
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = tableView.indexPathForRow(at: tableView.convert(location, from: view)), let tableViewCell = tableView.cellForRow(at: indexPath) else {
            return nil
        }
        
        itvIntervalIndex = indexPath.row
        
        guard let nextVC = storyboard?.instantiateViewController(withIdentifier: "EditIntervalViewController") as? EditIntervalViewController else {
            return nil
        }
                
//        nextVC.itvIntervalIndex = itvIntervalIndex
//        nextVC.itvTimerIndex = itvTimerIndex
        if itvTimerIndex == nil {
            nextVC.itvUnsavedTimersIntervals = itvUnsavedTimersIntervals
        }
//        nextVC.updateIntervalsProtocolDelegate = self
        
        let navigationController = UINavigationController(rootViewController: nextVC)
        return navigationController
    }
}
