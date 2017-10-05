//
//  ITVUITableView.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-10-04.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func scrollToBottom() {
        let rows = self.numberOfRows(inSection: 0)
        let indexPath = IndexPath(row: rows - 1, section: 0)
        self.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    func scrollToTop() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
