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
//TODO: scan all the code to make sure we unwrap optinal vakues at their earliest to delete all unecessary ? and !
//TODO: interesting article about error handling: https://www.cocoawithlove.com/blog/2016/08/21/result-types-part-one.html

import UIKit

//TODO: Leave the request location access here.
class TimerViewController: UIViewController {
    
    //ImageViews
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var cancelImageView: UIImageView!
    @IBOutlet weak var startPauseResumeImageView: UIImageView!
    @IBOutlet weak var warningImageView: UIImageView!
    @IBOutlet weak var userWarningImageView: ITVUIImageViewIndicator!

    //Progress Views
    @IBOutlet weak var intervalProgressView: UIView!
    @IBOutlet weak var timerProgressView: UIView!
    
    //Buttons
    @IBOutlet weak var startPauseResumeButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var warningButton: UIButton!
    @IBOutlet weak var userWarningButton: UIButton!
    
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

    @IBOutlet weak var collectionView: UICollectionView!

    //Progress view layers
    var intervalForegroundProgressView: ITVUIViewProgress!
    var timerForegroundProgressView: ITVUIViewProgress!
    
    var intervalsToRun: [ITVInterval] = []
    
    var itvTimerIndex: Int?
    var itvIntervalIndex: Int?
    var numberOfIntervals = 0
    
    var timerTotalSeconds = 0.0
    var timerTotalEllapsedSeconds = 0.0
    var previousIntervalSeconds: Double = 0.0
    var ellapsedSeconds = 0.0
    var intervalTime = 0.0
    var dblEllapsedTime = 0.0

    var timerProgressViewWidth: CGFloat?
    var intervalProgressViewWidth: CGFloat?

    var timer = Timer()
    var getWeatherDeadlineTimer = Timer()
    var startTime = TimeInterval()
    var updateTimersProtocolDelegate: ITVUpdateTimersProtocol?
    
    var startIntervalTimer: Bool? = false
    var isTimerEdited = false

    var startPauseResume : (Bool, Bool, Bool) = (false, false, false)
    var hoursMinutesSeconds : (Bool, Bool, Bool) = (false, false, false)
    
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    var intervalProgressColor: UIColor?
}
