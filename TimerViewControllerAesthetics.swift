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
    func aesthetics_initial(){
        activityIndicator.color = ITVColors.Orange
        cancelButton.isEnabled = false
        backgroudPulseImageView.roundImageView()
        foregroundPulsImageView.roundImageView()
        backgroudPulseImageView.alpha = 0.5
        
        aesthetics_hideMissingWeatherWarning()
        aesthetics_setFonts()
        aesthetics_timerCancel()
        aesthetics_timerLabels()
        aesthetics_timerLabelsInitialText()
    }
    func aesthetics_managePulseIndicator(indicator: Indicator?){
        if let theIndicator = indicator, theIndicator.rawValue < 6 { //indicator is valid and is not "none"
            backgroudPulseImageView.backgroundColor = theIndicator.uiColor()
            foregroundPulsImageView.backgroundColor = theIndicator.uiColor()
            foregroundPulsImageView.layer.borderColor = theIndicator.uiColor().cgColor
        } else {
            backgroudPulseImageView.backgroundColor = ITVColors.Orange
            foregroundPulsImageView.backgroundColor = ITVColors.Orange
            foregroundPulsImageView.layer.borderColor = ITVColors.Orange.cgColor
        }
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
}
