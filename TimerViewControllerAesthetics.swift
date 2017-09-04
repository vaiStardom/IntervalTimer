//
//  TimerViewControllerAesthetics.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-20.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

//MARK: Aesthetics
extension TimerViewController {
    func aesthetics_showMissingWeatherWarning(){
        //TODO: program the alert to show when this button is pressed
        //        showMissingTemperatureWarningButton.isHidden = false
        //        missingTemperatureImageView.isHidden = false
        
        weatherImageView.isHidden = true
        weatherTemperatureLabel.isHidden = true
    }
    func aesthetics_hideMissingWeatherWarning(){
        //        showMissingTemperatureWarningButton.isHidden = true
        //        missingTemperatureImageView.isHidden = true
        
        weatherImageView.isHidden = false
        weatherTemperatureLabel.isHidden = false
    }
    func aesthetics_timerLabels(){
        if ellapsedSeconds >= 3600.0 {
            aesthetics_hours()
        } else if ellapsedSeconds >= 60.0 {
            aesthetics_minutes()
        } else {
            aesthetics_seconds()
        }
    }
    func aesthetics_initial(){
        activityIndicator.color = IntervalTimerColors.Orange
        cancelButton.isEnabled = false
        
        aesthetics_hideMissingWeatherWarning()
        aesthetics_setFonts()
        aesthetics_timerCancel()
        aesthetics_timerLabels()
        aesthetics_timerLabelsInitialText()
        aesthetics_allowLocationServices()
    }
    func aesthetics_allowLocationServices(){
        
        //                visualEffect = warnView.visualEffectsView.effect
        //                warnView.visualEffectsView.effect = nil
        //                warnView.isHidden = true
        //                warnView.informationView.layer.cornerRadius = 5
        
    }
    func aesthetics_minutes(){
        
        timerHoursLabel.isHidden = true
        
        //Minutes labels
        timerMinutesLabel.isHidden = false
        timerMillisecondsForMinutesLabel.isHidden = false
        
        //Seconds labels
        timerSecondsLabel.isHidden = true
        timerMillisecondsForSecondsLabel.isHidden = true
    }
    
    func aesthetics_seconds(){
        
        timerHoursLabel.isHidden = true
        
        //Minutes labels
        timerMinutesLabel.isHidden = true
        timerMillisecondsForMinutesLabel.isHidden = true
        
        //Seconds labels
        timerSecondsLabel.isHidden = false
        timerMillisecondsForSecondsLabel.isHidden = false
    }
    func aesthetics_hours(){
        
        timerHoursLabel.isHidden = false
        
        //Minutes labels
        timerMinutesLabel.isHidden = true
        timerMillisecondsForMinutesLabel.isHidden = true
        
        //Seconds labels
        timerSecondsLabel.isHidden = true
        timerMillisecondsForSecondsLabel.isHidden = true
    }
    func aesthetics_timerStart(){
        cancelButton.isEnabled = true
        startPauseResumeImageView.image = UIImage(named: "pause")
        cancelImageView.image = UIImage(named: "cancel")
        cancelImageView.isOpaque = false
    }
    func aesthetics_timerPause(){
        cancelButton.isEnabled = true
        startPauseResumeImageView.image = UIImage(named: "resume")
        cancelImageView.image = UIImage(named: "cancel")
        cancelImageView.isOpaque = false
    }
    func aesthetics_timerResume(){
        cancelButton.isEnabled = true
        startPauseResumeImageView.image = UIImage(named: "pause")
        cancelImageView.image = UIImage(named: "cancel")
    }
    func aesthetics_timerCancel(){
        cancelButton.isEnabled = false
        startPauseResumeImageView.image = UIImage(named: "start")
        cancelImageView.image = UIImage(named: "cancel-opaque")
        cancelImageView.isOpaque = true
        aesthetics_timerLabelsInitialText()
    }
    func aesthetics_timerLabelsInitialText(){
        
        timerHoursLabel.text = "00:00:00"
        
        //Minutes labels
        timerMinutesLabel.text = "00:00"
        timerMillisecondsForMinutesLabel.text = ".00"
        
        //Seconds labels
        timerSecondsLabel.text = "00"
        timerMillisecondsForSecondsLabel.text = ".00"
        
    }
    func aesthetics_setFonts(){
        timerNameLabel.font = ViewFont.TimerName
        weatherTemperatureLabel.font = ViewFont.TimerTemperature
        
        timerHoursLabel.font = ViewFont.TimerHours
        
        //Minutes labels
        timerMinutesLabel.font = ViewFont.TimerMinutes
        timerMillisecondsForMinutesLabel.font = ViewFont.TimerMilliseconds
        
        //Seconds labels
        timerSecondsLabel.font = ViewFont.TimerSeconds
        timerMillisecondsForSecondsLabel.font = ViewFont.TimerMilliseconds
    }
    
    func aesthetics_showAllowLocationServicesWarning(){
        
        //let warnView: ITVWarningAllowLocationServicesView = UIView.fromNib()
        //let warnView: ITVWarningConnectToInternet = UIView.fromNib()
        let warnView: ITVWarningDisableAirPlaneMode = UIView.fromNib()
        
        warnView.frame = self.view.bounds
        warnView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        warnView.informationView.center = warnView.center
        warnView.informationView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        warnView.informationView.layer.cornerRadius = 5
        warnView.informationView.alpha = 0.0
        warnView.visualEffectsView.isHidden = false
        warnView.visualEffectsView.effect = nil
        warnView.tag = 1
        warnView.dismissWarningButton.addTarget(self, action: #selector(TimerViewController.dismissAllowLocationServicesWarning), for: .touchUpInside)
        
        self.view.addSubview(warnView)
        
        UIView.animate(withDuration: 0.4) {
            self.navigationController?.isNavigationBarHidden = true
            warnView.visualEffectsView.effect = UIBlurEffect(style: .light)
            warnView.informationView.alpha = 1.0
            warnView.informationView.transform =  CGAffineTransform.identity
        }
    }
    
    func dismissAllowLocationServicesWarning() {
        if let warnView = self.view.viewWithTag(1) {
            UIView.animate(withDuration: 0.3, animations: {
                self.navigationController?.isNavigationBarHidden = false
                warnView.alpha = 0.0
            }) {(success: Bool) in
                warnView.removeFromSuperview()
            }
        }
    }
}
