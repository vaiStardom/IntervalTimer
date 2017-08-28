//
//  TimerViewController.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-06-30.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

//TODO: create a network bundle
//TODO: create a weather bundle

import UIKit

class TimerViewController: UIViewController {
    
    @IBOutlet var allowLocationServicesView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    //ImageViews
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var cancelImageView: UIImageView!
    @IBOutlet weak var startPauseResumeImageView: UIImageView!
    @IBOutlet weak var dismissAllowLocationServicesViewImageView: UIImageView!
    
    //Buttons
    @IBOutlet weak var startPauseResumeButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var dismissAllowLocationServicesViewButton: UIButton!
    
    //Title labels
    @IBOutlet weak var weatherTemperatureLabel: UILabel!
    @IBOutlet weak var timerNameLabel: UILabel!
    @IBOutlet weak var showMissingTemperatureWarningButton: UIButton!
    @IBOutlet weak var missingTemperatureImageView: UIImageView!

    //Hours label
    @IBOutlet weak var timerHoursLabel: UILabel!
    
    //Minutes labels
    @IBOutlet weak var timerMinutesLabel: UILabel!
    @IBOutlet weak var timerMillisecondsForMinutesLabel: UILabel!
    
    //Seconds labels
    @IBOutlet weak var timerSecondsLabel: UILabel!
    @IBOutlet weak var timerMillisecondsForSecondsLabel: UILabel!

    var totalSeconds = 3602 //seconds
    var ellapsedSeconds = 0.0
    var startPauseResume : (Bool, Bool, Bool) = (false, false, false)
    var hoursMinutesSeconds : (Bool, Bool, Bool) = (false, false, false)
    var startTime = TimeInterval()
    var timer = Timer()
    var visualEffect: UIVisualEffect!
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
}
