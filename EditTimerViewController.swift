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
    
    @IBOutlet weak var timerNameLabel: UITextField!
    
    @IBOutlet weak var warningButton: UIButton!
    
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var warningImageView: UIImageView!
    
    @IBOutlet weak var weatherTemperatureLabel: UILabel!
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
}
