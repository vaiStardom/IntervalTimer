//
//  EditTimerViewController.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-22.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class EditTimerViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var deleteLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
//    @IBOutlet weak var deleteImageView: UIImageView!
    
    var intervals: [ITVInterval]? //will hold a copy of the timer's intervals for the table view's interval cells
    var uniqueTimers: [(ITVInterval, Int)] = []
    
    var itvTimerIndex: Int?
    var itvUnsavedTimersIntervals: [ITVInterval]? //for when the user creates a new timer with new intervals
    var itvIntervalIndex: Int?
    var updateTimersProtocolDelegate: ITVUpdateTimersProtocol?
    
    //tableView control varaibles
    let numberOfTableCellSections = 4 //except the interval sections
    let tableViewIntervalIndexOffset  = 2
    
}
