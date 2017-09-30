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
//        _ = navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    func edit(){
        performSegue(withIdentifier: "TimerToEditTimer", sender: nil)
    }
}
