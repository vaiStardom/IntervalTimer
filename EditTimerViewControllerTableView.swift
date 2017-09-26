//
//  EditTimerViewControllerTableView.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-23.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

extension EditTimerViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let theCount = intervals?.count, theCount > 0 {
            return theCount + numberOfTableCellSections
        } else {
            return numberOfTableCellSections
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = (indexPath as NSIndexPath).row
        var dataSourceCount = 0
        
        if let theDataSourceCount = intervals?.count {
            dataSourceCount = theDataSourceCount
        } else{
            dataSourceCount = 0
        }
        
        if index == 0 { //Top row
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditTimerTopCell") as! EditTimerTopTableViewCell

            //Cell configuration
            cell.timerNameTextField.delegate = self
            cell.warningButton.addTarget(self, action: #selector(EditTimerViewController.showWarning), for: .touchUpInside)
            cell.showWeatherSwitch.addTarget(self, action: #selector(EditTimerViewController.switched(_:)), for: .valueChanged)
            cell.temperatureSegmentedControl.selectedSegmentIndex = 2

            //Initial cell aesthetics
            cell.timerNameTextField.attributedPlaceholder = NSAttributedString(string: Litterals.TimerNamePlaceholder, attributes: [NSAttributedStringKey.foregroundColor : ITVColors.OrangeAlpha50])
            cell.showWeatherDescriptionLabel.isHidden = false
            cell.warningButton.isEnabled = false
//            cell.showWeatherSwitch.isOn = false
            cell.temperatureSegmentedControl.isHidden = true
            cell.weatherActivityIndicator.isHidden = true
            cell.timerNameTextField.tintColor = ITVColors.Orange
            cell.weatherActivityIndicator.color = ITVColors.Orange
            
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
            if dataSourceCount > 0 {
                let nibName = UINib(nibName: "EditTimerIntervalPresetsCollectionViewCell", bundle: nil)
                cell.intervalsCollectionView.register(nibName, forCellWithReuseIdentifier: "PresetCell")
                cell.intervalsCollectionView.delegate = self
                cell.intervalsCollectionView.dataSource = self
                cell.intervalsCollectionView.showsHorizontalScrollIndicator = false
                
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
        } else if index >= tableViewIntervalIndexOffset && index < (dataSourceCount + tableViewIntervalIndexOffset) { //Interval rows
            let cell = tableView.dequeueReusableCell(withIdentifier: "IntervalCell") as! EditTimerIntervalTableViewCell
            let intervalIndex = index - tableViewIntervalIndexOffset
            
            if let theInterval = intervals?[intervalIndex] {
                cell.intervalNumberLabel.text = "\(intervalIndex)"
                if let theSeconds = theInterval.thisSeconds {
                    cell.intervalTimeLabel.text = TIME_OF_00(seconds: theSeconds)
                    print("------> EditTimerViewController cellForRowAt timer = \(TIME_OF_00(seconds: theSeconds)), indicator = \(theInterval.thisIndicator.rawValue), color = \(theInterval.thisIndicator.uiColor())")
                    
                } else {
                    cell.intervalTimeLabel.text = "0"
                }
                cell.indicatorImageView.roundImageView()
                cell.indicatorImageView.backgroundColor = theInterval.thisIndicator.uiColor()
                cell.indicatorImageView.layer.borderColor = theInterval.thisIndicator.uiColor().cgColor
            }
            
            return cell
        } else if index == (dataSourceCount + tableViewIntervalIndexOffset) { //Bottom quick interval adds row
            
            if dataSourceCount == 0 {
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
                if dataSourceCount > 0 {
                    let nibName = UINib(nibName: "EditTimerIntervalPresetsCollectionViewCell", bundle: nil)
                    cell.intervalsCollectionView.register(nibName, forCellWithReuseIdentifier: "PresetCell")
                    cell.intervalsCollectionView.delegate = self
                    cell.intervalsCollectionView.dataSource = self
                    cell.intervalsCollectionView.showsHorizontalScrollIndicator = false
                    
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

        } else if index == (dataSourceCount + tableViewIntervalIndexOffset + 1) { //Delete timer row
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DeleteTimerCell") as! EditTimerDeleteTimerTableViewCell
            
            if dataSourceCount == 0 {
                cell.deleteTimerButton.addTarget(self, action: #selector(EditTimerViewController.cancel), for: .touchUpInside)
                cell.deleteTimerLabel.text = "Cancel"
            } else {
                cell.deleteTimerButton.addTarget(self, action: #selector(EditTimerViewController.deleteTimer), for: .touchUpInside)
                cell.deleteTimerLabel.text = "Delete Timer"
            }
            
            return cell
        } else { //Default row
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DeleteTimerCell") as! EditTimerDeleteTimerTableViewCell
            cell.deleteTimerButton.isEnabled = false
            cell.deleteTimerLabel.isHidden = true
            
            cell.imageView?.contentMode = UIViewContentMode.scaleAspectFill

            
            //Initial cell aesthetics
            cell.selectionStyle = .none

            return cell
        }
    }
    func configureTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 504
        
        tableView.register(UINib(nibName: "EditTimerAddIntervalsTableViewCell", bundle: nil), forCellReuseIdentifier: "AddIntervalCell")
        tableView.register(UINib(nibName: "EditTimerDeleteTimerTableViewCell", bundle: nil), forCellReuseIdentifier: "DeleteTimerCell")
        tableView.register(UINib(nibName: "EditTimerEmptyTableViewCell", bundle: nil), forCellReuseIdentifier: "EmptyCell")
        tableView.register(UINib(nibName: "EditTimerIntervalTableViewCell", bundle: nil), forCellReuseIdentifier: "IntervalCell")
        tableView.register(UINib(nibName: "EditTimerTopTableViewCell", bundle: nil), forCellReuseIdentifier: "EditTimerTopCell")
    }    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func topCell() -> EditTimerTopTableViewCell {
        let topCellIndexPath = IndexPath(row: 0, section: 0)
        let topCell = tableView.cellForRow(at: topCellIndexPath) as? EditTimerTopTableViewCell
        return topCell!
    }
    
    func bottomCell() -> EditTimerDeleteTimerTableViewCell {
        let bottomCellIndex = self.tableView.visibleCells.count - 1
        let bottomCellIndexPath = IndexPath(row: bottomCellIndex, section: 0)
        let bottomCell = tableView.cellForRow(at: bottomCellIndexPath) as? EditTimerDeleteTimerTableViewCell
        return bottomCell!
    }
}
