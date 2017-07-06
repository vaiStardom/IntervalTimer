//
//  TimerViewController.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-06-30.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    @IBOutlet weak var startPauseResumeButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var timerNameLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerMillisecondsLabel: UILabel!
    
    @IBOutlet weak var weatherTemperatureLabel: UILabel!
    
    var timer = Timer()
    var totalSeconds = 60 //seconds
    var startPauseResume : (Bool, Bool, Bool) = (false, false, false)
    var hoursMinutesSeconds : (Bool, Bool, Bool) = (false, false, false)
}
//MARK: Actions
extension TimerViewController{
    @IBAction func startPauseResumeTimer(_ sender: Any) {
        if startPauseResume == (true, false, false) { //start the timer
            runTimer()
            aesthetics_timerStart()
            startPauseResume = (false, true, false)
        } else if startPauseResume == (false, true, false) { //pause the timer
            aesthetics_timerPause()
            startPauseResume = (false, false, true)
        } else if startPauseResume == (false, false, true) { //resume the timer
            aesthetics_timerResume()
            startPauseResume = (false, true, false)
        }
    }
    @IBAction func cancel(_ sender: UIButton) {
        startPauseResume = (true, false, false)
        aesthetics_timerCancel()
    }
    func back(){
        _ = navigationController?.popViewController(animated: true)
    }
    func edit(){}
}
//MARK: Helpers
extension TimerViewController{
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    func updateTimer(){
        if totalSeconds < 1 {
            timer.invalidate()
            // send alert and start next interval
        } else {
            totalSeconds -= 1
            timerLabel.text = timeString(time: TimeInterval(totalSeconds))
        }
    }
    func timeString(time: TimeInterval?) -> String? {
        
        guard let totalSecondsLeft = time else {
            return nil
        }

        let hours = Int(totalSecondsLeft) / 3600
        let minutes = Int(totalSecondsLeft) / 60 % 60
        let seconds = Int(totalSecondsLeft) % 60

        //timerLabel.font = intervalTimeFont(seconds: totalSecondsLeft)
        
        if hours > 0 {
//            timerLabel.font = intervalTimeFont(seconds: totalSecondsLeft)
            return String(format: "%02i:%02i:%02i", minutes, seconds)
        } else if hours == 0 {
            return String(format: "%02i:%02i", minutes, seconds)
        } else if minutes == 0 {
            return String(format: "%02i", seconds)
        } else {
            return ""
        }
    }
    func intervalTimeFont(seconds: Int) -> UIFont? {
        if seconds >= 3600 {
            hoursMinutesSeconds = (true, false, false)
            return ViewFont.TimerHours
        } else if seconds < 3600 && seconds > 60 {
            hoursMinutesSeconds = (false, true, false)
            return ViewFont.TimerMinutes
        } else {
            hoursMinutesSeconds = (false, false, true)
            return ViewFont.TimerSeconds
        }
    }
}
//MARK: Aesthetics
extension TimerViewController{
    func aesthetics_initial(){
        timerLabel.font = intervalTimeFont(seconds: totalSeconds)
        timerNameLabel.font = ViewFont.TimerName
        weatherTemperatureLabel.font = ViewFont.TimerTemperature
        cancelButton.isEnabled = false
    }
    func aesthetics_timerStart(){
        cancelButton.isEnabled = true
        startPauseResumeButton.setImage(UIImage(named: "pause"), for: .normal)
    }
    func aesthetics_timerPause(){
        cancelButton.isEnabled = true
        startPauseResumeButton.setImage(UIImage(named: "resume"), for: .normal)
    }
    func aesthetics_timerResume(){
        cancelButton.isEnabled = true
        startPauseResumeButton.setImage(UIImage(named: "pause"), for: .normal)
    }
    func aesthetics_timerCancel(){
        cancelButton.isEnabled = false
        startPauseResumeButton.setImage(UIImage(named: "start"), for: .normal)
    }
}
//MARK: Life-cycle
extension TimerViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        startPauseResume = (true, false, false)
        timerNameLabel.text = "Peak 8"
        aesthetics_initial()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
//MARK: - Navigation Bar Management
extension TimerViewController {
    func configureNavBar(){
        self.navigationItem.hidesBackButton = true
        
        let backButton = IntervalTimerUIBarButtonItem().backButton(target: self, selector: #selector(TimerViewController.back))
        self.navigationItem.leftBarButtonItems = [backButton]
        
        let negativeSpace = IntervalTimerUIBarButtonItem().negativeSpace()
        let editButton = IntervalTimerUIBarButtonItem().editButton(target: self, selector: #selector(TimerViewController.edit))
        self.navigationItem.rightBarButtonItems = [negativeSpace, editButton]
    }
}
