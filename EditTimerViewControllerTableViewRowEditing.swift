//
//  EditTimerViewControllerTableView.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-23.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

extension EditTimerViewController {
    
    //MARK: - Row editing
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        let index = (indexPath as NSIndexPath).row
        if index >= tableViewIntervalIndexOffset && index < (dataSourceCount() + tableViewIntervalIndexOffset) { //Interval rows
            return true
        } else {
            return false
        }
        
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

        let sourceIntervalIndex = sourceIndexPath.row - 2
        let destinationIntervalIndex = destinationIndexPath.row - 2
        
        let intervalToMove = intervals?[sourceIntervalIndex]
        intervals?.remove(at: sourceIntervalIndex)
        intervals?.insert(intervalToMove!, at: destinationIntervalIndex)        
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
}
