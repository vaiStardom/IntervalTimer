//
//  EditTimerViewControllerActions.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-24.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

extension EditTimerViewController {
    @IBAction func deleteButton(_ sender: UIButton) {
        cancel()
        //        deleteTimer()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        if index >= tableViewIntervalIndexOffset && index < (dataSourceCount() + tableViewIntervalIndexOffset) { //Interval rows
            let cell = tableView.cellForRow(at: indexPath)
            cell?.contentView.backgroundColor = ITVColors.GrayForTableCellSelection
            itvSelectedIntervalIndex = indexPath.row - tableViewIntervalIndexOffset
            performSegue(withIdentifier: Segues.EditTimerToEditInterval, sender: nil)
        }
    }
}
