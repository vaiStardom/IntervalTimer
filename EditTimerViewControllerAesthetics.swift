//
//  EditTimerViewControllerAesthetics.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-01.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

extension EditTimerViewController {
    func aesthetics_initial(){
        weatherActivityIndicator.color = ITVColors.Orange
        weatherActivityIndicator.isHidden = true
        showWeatherSwitch.isOn = false
        timerNameTextField.tintColor = ITVColors.Orange
        temperatureSegmentedControl.isHidden = true
        temperatureSegmentedControl.selectedSegmentIndex = 2
        showWeatherDescriptionLabel.isHidden = false
        warningButton.isEnabled = false
        
        aesthetics_ShowTableView()
    }
    func aesthetics_timerNamePlaceHolder(){
        timerNameTextField.attributedPlaceholder = NSAttributedString(string: Litterals.TimerNamePlaceholder, attributes: [NSForegroundColorAttributeName : ITVColors.OrangeAlpha50])
    }
    func aesthetics_ShowTableView(){
        
        if let theTimerIndex = itvTimerIndex {
            if let theTimersIntervals = ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisIntervals {
                if theTimersIntervals.count > 0 {
                    tableView.isHidden = false
                    addIntervalsToTimerLabel.isHidden = true
                } else {
                    tableView.isHidden = true
                    addIntervalsToTimerLabel.isHidden = false
                }
            }
        } else {
            if itvUnsavedTimersIntervals != nil {
                tableView.isHidden = false
                addIntervalsToTimerLabel.isHidden = true
            } else {
                tableView.isHidden = true
                addIntervalsToTimerLabel.isHidden = false
            }        
        }
        
    }

//    func aesthetics_animateTableLoad(){
//        tableView.reloadData()
//        
//        let cells = tableView.visibleCells
//        let tableHeight: CGFloat = tableView.bounds.size.height
//        
//        for i in cells {
//            let cell: UITableViewCell = i as UITableViewCell
//            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
//        }
//        
//        var index = 0
//        for a in cells {
//            let cell : UITableViewCell = a as UITableViewCell
//            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, animations: {
//                cell.transform = CGAffineTransform(translationX: 0,y: 0);
//            }, completion: nil)
//            index += 1
//        }
//    }

    func aesthetics_hideWarning(){
        warningImageView.isHidden = true
        warningButton.isEnabled = false
    }
    

    func aesthetics_dontLoadWeather(){
        showWeatherSwitch.isOn = false
        weatherIconImageView.isHidden = true
        weatherTemperatureLabel.isHidden = true
        temperatureSegmentedControl.isHidden = true
        showWeatherDescriptionLabel.isHidden = false
    }
    func aesthetics_showWeatherDescription(){
        showWeatherDescriptionLabel.alpha = 1.0
        showWeatherDescriptionLabel.isHidden = false
    }
    func aesthetics_startLoadingWeather() {
        activityIndicatorStart()
        aesthetics_hideWarning()
        
        temperatureSegmentedControl.isHidden = false
        weatherIconImageView.isHidden = false
        
        showWeatherSwitch.isOn = true
        weatherTemperatureLabel.isHidden = true
        showWeatherDescriptionLabel.isHidden = true
        
        
    }
    func aesthetics_showMissingWeatherWarning(){
        //TODO: program the alert to show when this button is pressed
        activityIndicatorStop()
        aesthetics_hideWeatherViews()
       
        warningButton.isEnabled = true
        warningImageView.alpha = 0.0
        
        warningButton.isHidden = false
        warningImageView.isHidden = false
        
        warningImageView.alpha = 1.0
    }
    func aesthetics_hideMissingWeatherWarning(){
        aesthetics_showWeatherViews()
    }
    func aesthetics_hideWeatherViews(){

        weatherIconImageView.isHidden = true
        weatherTemperatureLabel.isHidden = true
        temperatureSegmentedControl.isHidden = true
            
        weatherIconImageView.image = nil
        weatherTemperatureLabel.text = nil
    }
    func aesthetics_showWeatherViews(){
        weatherIconImageView.alpha = 0.0
        weatherTemperatureLabel.alpha = 0.0
        temperatureSegmentedControl.alpha = 0.0
        
        weatherIconImageView.isHidden = false
        weatherTemperatureLabel.isHidden = false
        temperatureSegmentedControl.isHidden = false

        weatherIconImageView.alpha = 1.0
        weatherTemperatureLabel.alpha = 1.0
        temperatureSegmentedControl.alpha = 1.0        
    }
}
