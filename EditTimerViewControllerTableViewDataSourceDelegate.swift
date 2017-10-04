//
//  EditTimerViewControllerTableViewDataSourceDelegate.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-10-04.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

extension EditTimerViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Datasource and delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let theCount = intervals?.count, theCount > 0 {
            return theCount + numberOfTableCellSections
        } else {
            return numberOfTableCellSections
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = (indexPath as NSIndexPath).row
        
        if index == 0 { //Top row
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditTimerTopCell") as! EditTimerTopTableViewCell
            
            //Cell configuration
            cell.timerNameTextField.delegate = self
            cell.warningButton.addTarget(self, action: #selector(EditTimerViewController.showWarning), for: .touchUpInside)
            cell.showWeatherSwitch.addTarget(self, action: #selector(EditTimerViewController.switched(_:)), for: .valueChanged)
            cell.temperatureSegmentedControl.selectedSegmentIndex = 2
            
            //Initial cell aesthetics
            cell.timerNameTextField.attributedPlaceholder = NSAttributedString(string: Litterals.TimerNamePlaceholder, attributes: [NSAttributedStringKey.foregroundColor : ITVColors.OrangeAlpha50])
            
            //TODO: Understand this weird bug affecting only the segmented control.
            //In the absence of the following if statement, the segmented control appears on screen only when debug view mode, or
            //only when coming back from the edit interval view
            if let theTimerIndex = itvTimerIndex {
                if let theShowWeather = ITVUser.sharedInstance.thisTimers?[theTimerIndex].thisShowWeather, theShowWeather {
                    cell.showWeatherDescriptionLabel.isHidden = true
                    cell.temperatureSegmentedControl.isHidden = false
                } else {
                    cell.showWeatherDescriptionLabel.isHidden = false
                    cell.temperatureSegmentedControl.isHidden = true
                }
            } else {
                cell.showWeatherDescriptionLabel.isHidden = false
                cell.temperatureSegmentedControl.isHidden = true
            }
            cell.warningButton.isEnabled = false
            cell.weatherActivityIndicator.isHidden = true
            cell.timerNameTextField.tintColor = ITVColors.Orange
            cell.weatherActivityIndicator.color = ITVColors.Orange
            
            cell.temperatureSegmentedControl.addTarget(self, action: #selector(EditTimerViewController.selectedTemperatureUnit), for: .valueChanged)
            
            cell.selectionStyle = .none
            
            return cell
        } else if index == 1 { //Top quick interval adds row
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddIntervalCell") as! EditTimerAddIntervalsTableViewCell
            
            //Initial cell aesthetics
            cell.intervalsLabel.isHidden = false
            cell.visualEffectView.layer.masksToBounds = false
            cell.visualEffectView.layer.cornerRadius = cell.visualEffectView.frame.size.height/2
            cell.visualEffectView.clipsToBounds = true
            cell.editButton.isEnabled = true
            
            //if the are intervals, then show the collection view and fill the collection view with a filter of indicators
            if dataSourceCount() > 0 {
                let nibName = UINib(nibName: "EditTimerIntervalPresetsCollectionViewCell", bundle: nil)
                cell.intervalsCollectionView.register(nibName, forCellWithReuseIdentifier: "PresetCell")
                cell.intervalsCollectionView.delegate = self
                cell.intervalsCollectionView.dataSource = self
                cell.intervalsCollectionView.showsHorizontalScrollIndicator = false
                cell.intervalsCollectionView.transform = CGAffineTransform(scaleX: -1, y: 1)
                
                cell.editLabel.isHidden = false
                cell.addIntervalsLabel.isHidden = true
                cell.addIntervalButton.isEnabled = true
                cell.addIntervalImageView.isHidden = true
                cell.addPresetIntervalImageView.isHidden = false
                cell.visualEffectView.isHidden = false
                
                cell.editButton.addTarget(self, action: #selector(EditTimerViewController.editIntervals), for: .touchUpInside)
                cell.addIntervalButton.addTarget(self, action: #selector(EditTimerViewController.addInterval), for: .touchUpInside)
                
            } else {
                cell.editLabel.isHidden = true
                cell.addIntervalsLabel.isHidden = false
                cell.addIntervalImageView.isHidden = false
                cell.addIntervalButton.isEnabled = false
                cell.addPresetIntervalImageView.isHidden = true
                cell.visualEffectView.isHidden = true
                
                cell.editButton.addTarget(self, action: #selector(EditTimerViewController.addInterval), for: .touchUpInside)
            }
            
            cell.selectionStyle = .none
            
            return cell
        } else if index >= tableViewIntervalIndexOffset && index < (dataSourceCount() + tableViewIntervalIndexOffset) { //Interval rows
            let cell = tableView.dequeueReusableCell(withIdentifier: "IntervalCell") as! EditTimerIntervalTableViewCell
            let intervalIndex = index - tableViewIntervalIndexOffset
            
            if let theInterval = intervals?[intervalIndex] {
                cell.tag = intervalIndex //save the interval index for force touch
                cell.intervalNumberLabel.text = "\(intervalIndex + 1)"
                if let theSeconds = theInterval.thisSeconds {
                    cell.intervalTimeLabel.text = TIME_OF_00(seconds: theSeconds)
                    //                    print("------> EditTimerViewController cellForRowAt timer = \(TIME_OF_00(seconds: theSeconds)), indicator = \(theInterval.thisIndicator.rawValue), color = \(theInterval.thisIndicator.uiColor())")
                    
                } else {
                    cell.intervalTimeLabel.text = "0"
                }
                cell.indicatorImageView.roundImageView()
                cell.indicatorImageView.backgroundColor = theInterval.thisIndicator.uiColor()
                cell.indicatorImageView.layer.borderColor = theInterval.thisIndicator.uiColor().cgColor
                
                cell.swipeToDeleteDelegate = self
                cell.intervalIndex = intervalIndex
            }
            
            return cell
        } else if index == (dataSourceCount() + tableViewIntervalIndexOffset) { //Bottom quick interval adds row
            
            if dataSourceCount() == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell") as! EditTimerEmptyTableViewCell
                
                //Initial cell aesthetics
                cell.selectionStyle = .none
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AddIntervalCell") as! EditTimerAddIntervalsTableViewCell
                
                //Initial cell aesthetics
                cell.intervalsLabel.isHidden = true
                cell.visualEffectView.layer.masksToBounds = false
                cell.visualEffectView.layer.cornerRadius = cell.visualEffectView.frame.size.height/2
                cell.visualEffectView.clipsToBounds = true
                cell.editButton.isEnabled = true
                
                //if the are intervals, then show the collection view and fill the collection view with a filter of indicators
                if dataSourceCount() > 0 {
                    let nibName = UINib(nibName: "EditTimerIntervalPresetsCollectionViewCell", bundle: nil)
                    cell.intervalsCollectionView.register(nibName, forCellWithReuseIdentifier: "PresetCell")
                    cell.intervalsCollectionView.delegate = self
                    cell.intervalsCollectionView.dataSource = self
                    cell.intervalsCollectionView.showsHorizontalScrollIndicator = false
                    cell.intervalsCollectionView.transform = CGAffineTransform(scaleX: -1, y: 1)
                    
                    cell.editLabel.isHidden = false
                    cell.addIntervalsLabel.isHidden = true
                    cell.addIntervalImageView.isHidden = true
                    cell.addPresetIntervalImageView.isHidden = false
                    cell.visualEffectView.isHidden = false
                    
                    cell.editButton.addTarget(self, action: #selector(EditTimerViewController.editIntervals), for: .touchUpInside)
                    cell.addIntervalButton.addTarget(self, action: #selector(EditTimerViewController.addInterval), for: .touchUpInside)
                    
                } else {
                    cell.editLabel.isHidden = true
                    cell.addIntervalsLabel.isHidden = false
                    cell.addIntervalImageView.isHidden = false
                    cell.addIntervalButton.isEnabled = false
                    cell.addPresetIntervalImageView.isHidden = true
                    cell.visualEffectView.isHidden = true
                    
                    cell.editButton.addTarget(self, action: #selector(EditTimerViewController.addInterval), for: .touchUpInside)
                }
                
                cell.selectionStyle = .none
                
                return cell
            }
            
        } else if index == (dataSourceCount() + tableViewIntervalIndexOffset + 1) { //Delete timer row
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DeleteTimerCell") as! EditTimerDeleteTimerTableViewCell
            
            if dataSourceCount() == 0 {
                cell.deleteTimerButton.addTarget(self, action: #selector(EditTimerViewController.cancel), for: .touchUpInside)
                cell.deleteTimerLabel.text = "Cancel"
                deleteLabel.text = "Cancel"
                deleteButton.addTarget(self, action: #selector(EditTimerViewController.cancel), for: .touchUpInside)
            } else {
                cell.deleteTimerButton.addTarget(self, action: #selector(EditTimerViewController.deleteTimer), for: .touchUpInside)
                cell.deleteTimerLabel.text = "Delete Timer"
                deleteLabel.text = "Delete Timer"
                deleteButton.addTarget(self, action: #selector(EditTimerViewController.deleteTimer), for: .touchUpInside)
            }
            
            if isTableViewTallerThanDeleteButton() {
                cell.deleteTimerButton.isEnabled = true
                cell.deleteTimerLabel.isHidden = false
                deleteLabel.isHidden = true
                deleteButton.isHidden = true
                deleteButton.isEnabled = false
            } else {
                cell.deleteTimerButton.isEnabled = false
                cell.deleteTimerLabel.isHidden = true
                cell.selectionStyle = .none
                deleteLabel.isHidden = false
                deleteButton.isHidden = false
                deleteButton.isEnabled = true
            }
            
            return cell
        } else { //Default row
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DeleteTimerCell") as! EditTimerDeleteTimerTableViewCell
            cell.deleteTimerButton.isEnabled = false
            cell.deleteTimerLabel.isHidden = true
            
            //Initial cell aesthetics
            cell.selectionStyle = .none
            
            return cell
        }
    }
}
