//
//  TimersViewControllerActions.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-10-03.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

extension TimersViewController {
    
    //MARK: - Row selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.contentView.backgroundColor = ITVColors.GrayForTableCellSelection
        
        itvTimerIndex = indexPath.row
        startSelectedIntervalTimer = false
        performSegue(withIdentifier: "TimersToTimer", sender: nil)
    }
}
