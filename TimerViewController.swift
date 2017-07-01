//
//  TimerViewController.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-06-30.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startPauseResumeButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var timerNameLabel: UILabel!
    
    var timer = Timer()
    var seconds = 60 //seconds
    
//    var startTapped = false
//    var pauseTapped = false
//    var resumeTapped = false
    
    var startPauseResume : (Bool, Bool, Bool) = (false, false, false)
    
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
        if seconds < 1 {
            timer.invalidate()
            // send alert and start next interval
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        if hours == 0 {
        
        }
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
}
//MARK: Aesthetics
extension TimerViewController{
    func aesthetics_initial(){
        timerLabel.font = TIMER_INTERVAL_TIME_FONT
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
