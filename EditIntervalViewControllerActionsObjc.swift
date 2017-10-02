//
//  EditIntervalViewControllerActionsObjc.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-27.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Actions
@objc extension EditIntervalViewController {
    func cancel(){
//        _ = navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    func save(){
        if self.editIntervalProtocolDelegate != nil {
            if totalSeconds() > 0 {
                let theIndicator = indicator
                let theNewInterval = ITVInterval(seconds: totalSeconds(), indicator: theIndicator)
                self.editIntervalProtocolDelegate?.didEdit(theNewInterval)
            } else {
                //TODO: Warn user the he must enter numbers to create a valid interval
            }
        }
//        _ = navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}

