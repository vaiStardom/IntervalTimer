//
//  ViewController.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-06-25.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit
import QuartzCore
//TODO: + Accessibility make sure that all and any user viewable litteral is correctly voiced by siri assistant
//TODO: + make sure that all buttons (including nav bar buttons) are of correct size for accessibility options
//TODO: + Internationalize at least for english, french, and bahasa speaking localities
class TimersViewController: UIViewController {

    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var itvTimerIndex: Int?
    var startSelectedIntervalTimer: Bool? = false
    
    let gradientLayer = CAGradientLayer()
}
