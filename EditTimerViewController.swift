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
    
    var intervals: [ITVInterval]? //will hold a copy of the timer's intervals for the table view's interval cells
    var uniqueTimers: [(ITVInterval, Int)] = []

    var itvTimerIndex: Int?
    var itvUnsavedTimersIntervals: [ITVInterval]? //for when the user creates a new timer with new intervals
    var itvSelectedIntervalIndex: Int?
    
    var didEditAnInterval = false
    var deleteIntervalOnSwipe = false
  
    //Protocols
    var deleteTimerFromTimerViewProtocol: ITVDeleteTimerFromTimerViewProtocol?
    var updateTimersProtocolDelegate: ITVUpdateTimersProtocol?
    
    //To save timer info
    var timerName: String?
    var isShowWeather: Bool?
    var temperatureUnit: TemperatureUnit?

    //TableView controls
    let numberOfTableCellSections = 4 //except the interval sections
    let tableViewIntervalIndexOffset  = 2
    var heightAtIndexPath = NSMutableDictionary()
    
    //VC sections heights and tableView cell heights
    var personalHotspotBarNavBar = 88.0
    var topCellHeight = 171.0
    var addIntervalsCellHeight = 98.0
    
    //Collection view controls
    var isInitialCollectionViewLoad = true
    
}
