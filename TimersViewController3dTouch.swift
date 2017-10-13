//
//  TimersViewController3dTouch.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-18.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

extension TimersViewController: UIViewControllerPreviewingDelegate {
    
    @available(iOS 9.0, *)
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        self.navigationController!.show((viewControllerToCommit as! UINavigationController).viewControllers[0], sender: self)
        
    }

    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = tableView.indexPathForRow(at: tableView.convert(location, from: view)), let _ = tableView.cellForRow(at: indexPath) else {
            return nil
        }

        itvTimerIndex = indexPath.row
        startSelectedIntervalTimer = false

        guard let nextVC = storyboard?.instantiateViewController(withIdentifier: Identifiers.TimerViewController) as? TimerViewController else {
            return nil
        }
        
        nextVC.itvTimerIndex = itvTimerIndex
        nextVC.startIntervalTimer = startSelectedIntervalTimer

        let navigationController = UINavigationController(rootViewController: nextVC)
        return navigationController
    }
}
