//
//  EditTimerViewControllerTableViewHelpers.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-10-04.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

extension EditTimerViewController {
    func configureTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 504
        
        tableView.register(UINib(nibName: Nibs.EditTimerAddIntervalsTableViewCell, bundle: nil), forCellReuseIdentifier: Identifiers.AddIntervalCell)
        tableView.register(UINib(nibName: Nibs.EditTimerDeleteTimerTableViewCell, bundle: nil), forCellReuseIdentifier: Identifiers.DeleteTimerCell)
        tableView.register(UINib(nibName: Nibs.EditTimerEmptyTableViewCell, bundle: nil), forCellReuseIdentifier: Identifiers.EmptyCell)
        tableView.register(UINib(nibName: Nibs.EditTimerIntervalTableViewCell, bundle: nil), forCellReuseIdentifier: Identifiers.IntervalCell)
        tableView.register(UINib(nibName: Nibs.EditTimerTopTableViewCell, bundle: nil), forCellReuseIdentifier: Identifiers.EditTimerTopCell)
    }

    func firstAddIntervalsCell() -> EditTimerAddIntervalsTableViewCell? {
        
        let firstAddIntervalsCellIndex = 1
        let firstAddIntervalsCellIndexPath = IndexPath(row: firstAddIntervalsCellIndex, section: 0)
        
        if let firstAddIntervalsCell = tableView.cellForRow(at: firstAddIntervalsCellIndexPath) as? EditTimerAddIntervalsTableViewCell {
            return firstAddIntervalsCell
        } else {
            return nil
        }
    }

    func secondAddIntervalsCell() -> EditTimerAddIntervalsTableViewCell? {
        
        let secondAddIntervalsCellIndex = dataSourceCount() + tableViewIntervalIndexOffset
        let secondAddIntervalsCellIndexPath = IndexPath(row: secondAddIntervalsCellIndex, section: 0)
        
        if let secondAddIntervalsCell = tableView.cellForRow(at: secondAddIntervalsCellIndexPath) as? EditTimerAddIntervalsTableViewCell {
            return secondAddIntervalsCell
        } else {
            return nil
        }
    }

    func topCell() -> EditTimerTopTableViewCell? {
        let topCellIndexPath = IndexPath(row: 0, section: 0)
        if let topCell = tableView.cellForRow(at: topCellIndexPath) as? EditTimerTopTableViewCell {
            return topCell
        } else {
            return nil
        }
    }
    
    func deleteCell() -> EditTimerDeleteTimerTableViewCell? {
        let deleteCellIndex = dataSourceCount() + tableViewIntervalIndexOffset + 1
        let deleteCellIndexPath = IndexPath(row: deleteCellIndex, section: 0)
        if let deleteCell = tableView.cellForRow(at: deleteCellIndexPath) as? EditTimerDeleteTimerTableViewCell {
            return deleteCell
        } else {
            return nil
        }
    }
}
