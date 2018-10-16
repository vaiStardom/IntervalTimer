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
        
        //MARK: - Top row
        if index == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.EditTimerTopCell) as! EditTimerTopTableViewCell
            
            //Cell configuration
            cell.timerNameTextField.delegate = self
            cell.warningButton.addTarget(self, action: #selector(EditTimerViewController.showWarning), for: .touchUpInside)
            cell.showWeatherSwitch.addTarget(self, action: #selector(EditTimerViewController.showWeatherSwitched(_:)), for: .valueChanged)
            cell.temperatureSegmentedControl.selectedSegmentIndex = 2
            
            //Initial cell aesthetics
            cell.timerNameTextField.attributedPlaceholder = NSAttributedString(string: Litterals.TimerNamePlaceholder, attributes: [NSAttributedString.Key.foregroundColor : ITVColors.OrangeAlpha50])
            
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
            
            
            
        //MARK: - First add interval row
        } else if index == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.AddIntervalCell) as! EditTimerAddIntervalsTableViewCell
            
            //Initial cell aesthetics
            cell.intervalsLabel.isHidden = false
            cell.visualEffectView.layer.masksToBounds = false
            cell.visualEffectView.layer.cornerRadius = cell.visualEffectView.frame.size.height/2
            cell.visualEffectView.clipsToBounds = true
            cell.editButton.isEnabled = true
            
            //if the are intervals, then show the collection view and fill the collection view with a filter of indicators
            if dataSourceCount() > 0 {
                let nibName = UINib(nibName: Nibs.EditTimerIntervalPresetsCollectionViewCell, bundle: nil)
                cell.intervalsCollectionView.register(nibName, forCellWithReuseIdentifier: Identifiers.PresetCell)
                cell.intervalsCollectionView.delegate = self
                cell.intervalsCollectionView.dataSource = self
                cell.intervalsCollectionView.showsHorizontalScrollIndicator = false
                cell.intervalsCollectionView.transform = CGAffineTransform(scaleX: -1, y: 1)
                
                cell.editLabel.isHidden = false
                cell.editButton.removeTarget(nil, action: nil, for: .allEvents)
                cell.editButton.addTarget(self, action: #selector(EditTimerViewController.editIntervals), for: .touchUpInside)

                if isEditing {
                    cell.editLabel.text = Litterals.Save
                } else {
                    cell.editLabel.text = Litterals.Edit
                }
                
                cell.addIntervalsLabel.isHidden = true
                cell.addIntervalButton.isEnabled = true
                cell.addIntervalImageView.isHidden = true
                cell.addPresetIntervalImageView.isHidden = false
                cell.visualEffectView.isHidden = false
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
            
            
        //MARK: - Interval rows
        } else if index >= tableViewIntervalIndexOffset && index < (dataSourceCount() + tableViewIntervalIndexOffset) {
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.IntervalCell) as! EditTimerIntervalTableViewCell
            let intervalIndex = index - tableViewIntervalIndexOffset
            
            if let theInterval = intervals?[intervalIndex] {
                cell.tag = intervalIndex //save the interval index for force touch
                cell.intervalNumberLabel.text = "\(intervalIndex + 1)"
                if let theSeconds = theInterval.thisSeconds {
                    cell.intervalTimeLabel.text = TIME_OF_00(seconds: theSeconds)
                } else {
                    cell.intervalTimeLabel.text = Litterals.Zero
                }
                cell.indicatorImageView.roundImageView()
                cell.indicatorImageView.backgroundColor = theInterval.thisIndicator.uiColor()
                cell.indicatorImageView.layer.borderColor = theInterval.thisIndicator.uiColor().cgColor
                
                cell.swipeToDeleteDelegate = self
                cell.intervalIndex = intervalIndex
            }
            
            return cell
            
            
        //MARK: - Second add interval row
        } else if index == (dataSourceCount() + tableViewIntervalIndexOffset) {
            
            if dataSourceCount() == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.EmptyCell) as! EditTimerEmptyTableViewCell
                
                //Initial cell aesthetics
                cell.selectionStyle = .none
                
                return cell
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.AddIntervalCell) as! EditTimerAddIntervalsTableViewCell
                
                //Initial cell aesthetics
                cell.intervalsLabel.isHidden = true
                cell.visualEffectView.layer.masksToBounds = false
                cell.visualEffectView.layer.cornerRadius = cell.visualEffectView.frame.size.height/2
                cell.visualEffectView.clipsToBounds = true
                cell.editButton.isEnabled = true
                
                //if the are intervals, then show the collection view and fill the collection view with a filter of indicators
                if dataSourceCount() > 0 {
                    let nibName = UINib(nibName: Nibs.EditTimerIntervalPresetsCollectionViewCell, bundle: nil)
                    cell.intervalsCollectionView.register(nibName, forCellWithReuseIdentifier: Identifiers.PresetCell)
                    cell.intervalsCollectionView.delegate = self
                    cell.intervalsCollectionView.dataSource = self
                    cell.intervalsCollectionView.showsHorizontalScrollIndicator = false
                    cell.intervalsCollectionView.transform = CGAffineTransform(scaleX: -1, y: 1)
                    
                    cell.editLabel.isHidden = false
                    cell.editButton.removeTarget(nil, action: nil, for: .allEvents)
                    cell.editButton.addTarget(self, action: #selector(EditTimerViewController.editIntervals), for: .touchUpInside)
                    
                    if isEditing {
                        cell.editLabel.text = Litterals.Save
                    } else {
                        cell.editLabel.text = Litterals.Edit
                    }
                    
                    cell.addIntervalsLabel.isHidden = true
                    cell.addIntervalButton.isEnabled = true
                    cell.addIntervalImageView.isHidden = true
                    cell.addPresetIntervalImageView.isHidden = false
                    cell.visualEffectView.isHidden = false
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
           
            
            
        //MARK: - Delete timer row
        } else if index == (dataSourceCount() + tableViewIntervalIndexOffset + 1) {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.DeleteTimerCell) as! EditTimerDeleteTimerTableViewCell
            
            if dataSourceCount() == 0 {
                cell.deleteTimerButton.addTarget(self, action: #selector(EditTimerViewController.cancel), for: .touchUpInside)
                cell.deleteTimerLabel.text = Litterals.Cancel
                deleteLabel.text = Litterals.Cancel
                deleteButton.addTarget(self, action: #selector(EditTimerViewController.cancel), for: .touchUpInside)
            } else {
                cell.deleteTimerButton.addTarget(self, action: #selector(EditTimerViewController.deleteTimer), for: .touchUpInside)
                cell.deleteTimerLabel.text = Litterals.DeleteTimer
                deleteLabel.text = Litterals.DeleteTimer
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
            
            
        //MARK: - Default row
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.DeleteTimerCell) as! EditTimerDeleteTimerTableViewCell
            cell.deleteTimerButton.isEnabled = false
            cell.deleteTimerLabel.isHidden = true
            
            //Initial cell aesthetics
            cell.selectionStyle = .none
            
            return cell
        }
    }
}
