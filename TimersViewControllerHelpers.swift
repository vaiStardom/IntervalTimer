//
//  TimersViewControllerHelpers.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-10-04.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

extension TimersViewController {
    func dataSourceCount() -> Int {
        if let theCount = ITVUser.sharedInstance.thisTimers?.count {
            return theCount
        } else {
            return 0
        }
    }
}
