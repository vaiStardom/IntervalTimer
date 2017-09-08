//
//  ViewController.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-06-25.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class TimersViewController: UIViewController {

    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var selectedIntervalTimer: ITVTimer?
    var startSelectedIntervalTimer: Bool? = false
    
//    private var selectedTimerIndex: Int?
}
//MARK: - Life-Cycle
extension TimersViewController{
    override func viewWillAppear(_ animated: Bool) {
        animateTable()
        print("UserDefaults Retreived Informations:")
        print("Last weather update = \(String(describing: ITVUser.sharedInstance.thisLastWeatherUpdate))")
        print("Temperature = \(String(describing: ITVUser.sharedInstance.thisCurrentWeather?.thisTemperature!))")
        print("Icon = \(String(describing: ITVUser.sharedInstance.thisCurrentWeather?.thisIcon!))")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TimersTableViewCell", bundle: nil), forCellReuseIdentifier: "TimersCell")
        configureNavBar()
    }
}
