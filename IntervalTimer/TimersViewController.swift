//
//  ViewController.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-06-25.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit
import QuartzCore

class TimersViewController: UIViewController {

    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var itvTimerIndex: Int?
    var startSelectedIntervalTimer: Bool? = false
    
    let gradientLayer = CAGradientLayer()
}
