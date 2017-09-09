//
//  TimerViewController.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-06-30.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

//TODO: create a network bundle
//TODO: create a weather bundle
//TODO: If the timer is running, do not show alerts, just show the warning icon

import UIKit

//TODO: Leave the request location access here.
//Since it is here the user first indicates the need for it by switching the weather on.
//TODO: Show warning that airplane mode is on by simply putting that icon where the weather is (no alert)
class TimerViewController: UIViewController {
    
    //ImageViews
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var cancelImageView: UIImageView!
    @IBOutlet weak var startPauseResumeImageView: UIImageView!
    @IBOutlet weak var warningImageView: UIImageView!
    
    //Buttons
    @IBOutlet weak var startPauseResumeButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var warningButton: UIButton!
    
    //Title labels
    @IBOutlet weak var weatherTemperatureLabel: UILabel!
    @IBOutlet weak var timerNameLabel: UILabel!

    //Hours label
    @IBOutlet weak var timerHoursLabel: UILabel!
    
    //Minutes labels
    @IBOutlet weak var timerMinutesLabel: UILabel!
    @IBOutlet weak var timerMillisecondsForMinutesLabel: UILabel!
    
    //Seconds labels
    @IBOutlet weak var timerSecondsLabel: UILabel!
    @IBOutlet weak var timerMillisecondsForSecondsLabel: UILabel!

    var intervalTimer: ITVTimer?
    var startIntervalTimer: Bool? = false
    
    var totalSeconds = 3602 //seconds
    var ellapsedSeconds = 0.0
    var startPauseResume : (Bool, Bool, Bool) = (false, false, false)
    var hoursMinutesSeconds : (Bool, Bool, Bool) = (false, false, false)
    var startTime = TimeInterval()
    var timer = Timer()
    var visualEffect: UIVisualEffect!
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
}
