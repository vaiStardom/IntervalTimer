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
        //Aesthetics of the selected cell
        let index = indexPath.row
        if index >= tableViewIntervalIndexOffset && index < ((intervals?.count)! + tableViewIntervalIndexOffset) { //Interval
            let cell = tableView.cellForRow(at: indexPath)
            cell?.contentView.backgroundColor = ITVColors.OrangeAlpha50
        }
        itvIntervalIndex = indexPath.row - tableViewIntervalIndexOffset
        performSegue(withIdentifier: "EditTimerToEditInterval", sender: nil)
    }
}
