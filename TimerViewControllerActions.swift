//
//  TimerViewControllerActions.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-20.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

//MARK: Actions
extension TimerViewController{
    @IBAction func startPauseResumeTimer(_ sender: Any) {
        if startPauseResume == (true, false, false) { //start the timer
            runIntervalTimer()
            aesthetics_timerStart()
            startPauseResume = (false, true, false)
        } else if startPauseResume == (false, true, false) { //pause the timer
            timer.invalidate()
            aesthetics_timerPause()
            startPauseResume = (false, false, true)
        } else if startPauseResume == (false, false, true) { //resume the timer
            runIntervalTimer()
            aesthetics_timerResume()
            startPauseResume = (false, true, false)
        }
    }
    @IBAction func cancel(_ sender: UIButton) {
        startPauseResume = (true, false, false)
        timer.invalidate()
        ellapsedSeconds = Double(totalSeconds)
        aesthetics_timerCancel()
    }
    @IBAction func weatherMissing(_ sender: Any) {
        showMessage(title: "Waether Missing", message: "Are you sure you are connected to the internet?")
    }
    @IBAction func dismissAllowLocationServicesView(_ sender: Any) {
        aesthetics_animateOut_AllowLocationServicesView()
    }
    @IBAction func takeMeToSettings(_ sender: Any) {
        
    }
    func back(){
        _ = navigationController?.popViewController(animated: true)
    }
    func edit(){
        aesthetics_animateIn_AllowLocationServicesView()
    }
}
