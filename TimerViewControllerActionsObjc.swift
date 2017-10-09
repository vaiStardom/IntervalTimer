//
//  TimerViewControllerActionsObjc.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-26.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

@objc extension TimerViewController {
    func back(){
        stopTimer()
        if self.updateTimersProtocolDelegate != nil {
            self.updateTimersProtocolDelegate?.didUpdateTimers()
        }
        dismiss(animated: true, completion: nil)
    }
    func edit(){
        stopTimer()
        performSegue(withIdentifier: Segues.TimerToEditTimer, sender: nil)
    }
}
