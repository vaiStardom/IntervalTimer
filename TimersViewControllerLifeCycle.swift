//
//  TimersViewControllerLifeCycle.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-11.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Life-Cycle
extension TimersViewController{
    override func viewWillAppear(_ animated: Bool) {
        tableView.isEditing = false
        configureNavBar()

        print("UserDefaults Retreived Informations:")
        print("Last weather update = \(String(describing: ITVUser.sharedInstance.thisLastWeatherUpdate))")
        print("Kelvin = \(String(describing: ITVUser.sharedInstance.thisCurrentWeather?.thisKelvin!))")
        print("Icon = \(String(describing: ITVUser.sharedInstance.thisCurrentWeather?.thisIcon!))")
        print("Timers = \(String(describing: ITVUser.sharedInstance.thisTimers?.count))")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: view)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TimersTableViewCell", bundle: nil), forCellReuseIdentifier: "TimersCell")
        configureNavBar()
        aesthetics_animateTableLoad()
    }
}
