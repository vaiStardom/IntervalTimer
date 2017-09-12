//
//  TimersViewControllerHelpers.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-11.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

extension TimersViewController: ITVTimersProtocol {
    func didUpdateTimers() {
        self.tableView.reloadData()
    }
}
