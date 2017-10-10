//
//  TimerViewControllerAesthetics.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-20.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

//MARK: Aesthetics
//TODO: make the current indicator blink:
//UIView.animateWithDuration(1.0, delay: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
//    indicator.alpha = 0.0
//}, completion: nil)

extension TimerViewController {
    func aesthetics_initializeTimeLabels(){
        let hours = Int(ellapsedSeconds / 3600.0) % 24
        
        //calculate the minutes in ellapsedSeconds.
        let minutes = Int(ellapsedSeconds / 60.0)
        
        //calculate the seconds in ellapsedSeconds.
        let seconds = Int(ellapsedSeconds)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        let strHours = String(format: "%02d", abs(hours))
        let strMinutes = String(format: "%02d", abs(minutes))
        let strSeconds = String(format: "%02d", abs(seconds))
        
        aesthetics_timerLabels()
        
        timerHoursLabel.text = "\(strHours):\(strMinutes):\(strSeconds)"
        
        //Minutes labels
        timerMinutesLabel.text = "\(strMinutes):\(strSeconds)"
        timerMillisecondsForMinutesLabel.text = ".00"
        
        //Seconds labels
        timerSecondsLabel.text = "\(strSeconds)"
        timerMillisecondsForSecondsLabel.text = ".00"
    }
    
    func aesthetics_showMissingWeatherWarning(){
        //TODO: program the alert to show when this button is pressed
        activityIndicatorStop()
        weatherImageView.isHidden = true
        weatherTemperatureLabel.isHidden = true
        
        warningButton.isEnabled = true
        warningImageView.alpha = 0.0
        
        warningButton.isHidden = false
        warningImageView.isHidden = false
        
        UIView.animate(withDuration: 1.5, animations: {
            self.warningImageView.alpha = 1.0
        })
    }
    func aesthetics_hideMissingWeatherWarning(){
        warningButton.isHidden = true
        warningButton.isEnabled = false
        warningImageView.isHidden = true
        weatherImageView.isHidden = false
        weatherTemperatureLabel.isHidden = false
    }
    func aesthetics_hideWeatherView(){
        warningButton.isHidden = true
        warningButton.isEnabled = false
        warningImageView.isHidden = true
        weatherImageView.isHidden = true
        weatherTemperatureLabel.isHidden = true
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
    func aesthetics_ShowIntervalMissingWarning(){
        userWarningButton.isEnabled = true
        userWarningImageView.isHidden = false
        userWarningImageView.layer.borderColor = ITVColors.Orange.cgColor
        userWarningImageView.layer.borderWidth = 1.0
        
        cancelImageView.isHidden = true
        startPauseResumeImageView.isHidden = true
        timerHoursLabel.isHidden = true
        timerMinutesLabel.isHidden = true
        timerSecondsLabel.isHidden = true
        timerMillisecondsForMinutesLabel.isHidden = true
        timerMillisecondsForSecondsLabel.isHidden = true
        
        
        cancelButton.isEnabled = false
        startPauseResumeButton.isEnabled = false
    }
    func aesthetics_HideIntervalMissingWarning(){
        userWarningButton.isEnabled = false
        userWarningImageView.isHidden = true
        
        
        cancelImageView.isHidden = false
        startPauseResumeImageView.isHidden = false
        
        cancelButton.isEnabled = true
        startPauseResumeButton.isEnabled = true
    }
    func aesthetics_initial(){
        activityIndicator.color = ITVColors.Orange
        cancelButton.isEnabled = false
        userWarningImageView.roundImageView()
        
        timerProgressInitialLayer(withColor: ITVColors.Orange.withAlphaComponent(0.15).cgColor)
        
        timerProgressLabel.text = Litterals.ZeroPercent
        intervalProgressLabel.text = Litterals.ZeroPercent
        
        startPauseResumeButton.isEnabled = true
        cancelButton.isEnabled = true
        
        aesthetics_hideMissingWeatherWarning()
        aesthetics_HideIntervalMissingWarning()
        aesthetics_setFonts()
        aesthetics_timerCancel()
        aesthetics_timerLabelsInitialText()
    }
    func aesthetics_manageIntervalProgress(indicator: Indicator?){
        if let theIndicator = indicator, theIndicator.rawValue < 6 { //indicator is valid and is not "none"
            intervalProgressColor = theIndicator.uiColor()
            intervalProgressInitialLayer(withColor: (intervalProgressColor?.withAlphaComponent(0.15).cgColor)!)
        } else {
            intervalProgressColor = ITVColors.Orange
            intervalProgressInitialLayer(withColor: (intervalProgressColor?.withAlphaComponent(0.15).cgColor)!)
        }
    }
    //    func aesthetics_managePulseIndicator(indicator: Indicator?){
    //        if let theIndicator = indicator, theIndicator.rawValue < 6 { //indicator is valid and is not "none"
    //            backgroudPulseImageView.backgroundColor = theIndicator.uiColor()
    //            foregroundPulsImageView.backgroundColor = theIndicator.uiColor()
    //            foregroundPulsImageView.layer.borderColor = theIndicator.uiColor().cgColor
    //        } else {
    //            backgroudPulseImageView.backgroundColor = ITVColors.Orange
    //            foregroundPulsImageView.backgroundColor = ITVColors.Orange
    //            foregroundPulsImageView.layer.borderColor = ITVColors.Orange.cgColor
    //        }
    //    }
    
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
        startPauseResumeImageView.image = UIImage(named: Images.TimerViewControlPause)
        cancelImageView.image = UIImage(named: Images.TimerViewControlCancel)
        cancelImageView.isOpaque = false
    }
    func aesthetics_timerPause(){
        cancelButton.isEnabled = true
        startPauseResumeImageView.image = UIImage(named: Images.TimerViewControlResume)
        cancelImageView.image = UIImage(named: Images.TimerViewControlCancel)
        cancelImageView.isOpaque = false
    }
    func aesthetics_timerResume(){
        cancelButton.isEnabled = true
        startPauseResumeImageView.image = UIImage(named: Images.TimerViewControlPause)
        cancelImageView.image = UIImage(named: Images.TimerViewControlCancel)
    }
    func aesthetics_timerCancel(){
        cancelButton.isEnabled = false
        startPauseResumeImageView.image = UIImage(named: Images.TimerViewControlStart)
        cancelImageView.image = UIImage(named: Images.TimerViewControlCancelOpaque)
        cancelImageView.isOpaque = true
        aesthetics_timerLabelsInitialText()
    }
    
    func aesthetics_timerLabelsInitialText(){
        
        timerHoursLabel.text = Litterals.TimerHoursLabel
        
        //Minutes labels
        timerMinutesLabel.text = Litterals.TimerMinutesLabel
        timerMillisecondsForMinutesLabel.text = Litterals.TimerMillisecondsLabel
        
        //Seconds labels
        timerSecondsLabel.text = Litterals.TimerSecondsLabel
        timerMillisecondsForSecondsLabel.text = Litterals.TimerMillisecondsLabel
        
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
        
        //progress labels
        intervalProgressLabel.font = ViewFont.TimerProgress
        timerProgressLabel.font = ViewFont.TimerProgress
    }
}
