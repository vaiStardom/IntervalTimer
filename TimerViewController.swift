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
    @IBOutlet weak var intervalProgressLabel: UILabel!
    @IBOutlet weak var timerProgressLabel: UILabel!
    
    //Hours label
    @IBOutlet weak var timerHoursLabel: UILabel!
    
    //Minutes labels
    @IBOutlet weak var timerMinutesLabel: UILabel!
    @IBOutlet weak var timerMillisecondsForMinutesLabel: UILabel!
    
    //Seconds labels
    @IBOutlet weak var timerSecondsLabel: UILabel!
    @IBOutlet weak var timerMillisecondsForSecondsLabel: UILabel!

    @IBOutlet weak var collectionView: UICollectionView!
    
    var intervalsToRun: [ITVInterval] = []
    
    //Progress view layers
    var intervalBorderLayer : CAShapeLayer = CAShapeLayer()
    let intervalProgressLayer : CAShapeLayer = CAShapeLayer()
    
    var timerBorderLayer : CAShapeLayer = CAShapeLayer()
    let timerProgressLayer : CAShapeLayer = CAShapeLayer()
    
    var timerProgressViewWidth: CGFloat?
    var intervalProgressViewWidth: CGFloat?
    
    var itvTimerIndex: Int?
    var itvIntervalIndex: Int?
    var startIntervalTimer: Bool? = false
    var indexOfIntervalToRun = 0
    var totalSeconds = 3602 //temp var, will be replaced by an intervals seconds
    var startTime = TimeInterval()
    var ellapsedSeconds = 0.0
//    var wholeAnimation = 0.0
    var toAnimation = 0.0
    
    var isTimerEdited = false
    var updateTimersProtocolDelegate: ITVUpdateTimersProtocol?
    
    var startPauseResume : (Bool, Bool, Bool) = (false, false, false)
    var hoursMinutesSeconds : (Bool, Bool, Bool) = (false, false, false)
    
    var timer = Timer()
    var visualEffect: UIVisualEffect! //TODO: Do you still need this?
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    var intervalProgressColor: UIColor?
    
}
