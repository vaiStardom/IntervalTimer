//
//  EditTimerViewController.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-06-25.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class EditTimerViewController: UIViewController {
    
    @IBOutlet weak var showWeatherSwitch: UISwitch!
    @IBOutlet weak var timerNameTextField: UITextField!
    @IBOutlet weak var warningButton: UIButton!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var warningImageView: UIImageView!
    @IBOutlet weak var weatherTemperatureLabel: UILabel!
    @IBOutlet weak var showWeatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var weatherActivityIndicator: UIActivityIndicatorView!
    
    
    //let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var itvTimer: ITVTimer?
    var itvInterval: ITVInterval?
}
