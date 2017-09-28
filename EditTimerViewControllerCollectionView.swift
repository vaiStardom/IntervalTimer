//
//  EditTimerViewControllerCollectionView.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-22.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

extension EditTimerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return uniqueTimers.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = indexPath.row
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PresetCell", for: indexPath) as! EditTimerIntervalPresetsCollectionViewCell
        cell.indicatorImageView.backgroundColor = uniqueTimers[index].0.thisIndicator.uiColor()
        cell.indicatorImageView.roundImageView()
        
        if let theSeconds = uniqueTimers[index].0.thisSeconds {
            cell.secondsLabel.text = TIME_OF_HMS(seconds: theSeconds)
        } else {
            cell.secondsLabel.text = "empty"
        }
        
        cell.addIntervalPresetButton.addTarget(self, action: #selector(EditTimerViewController.addThisInterval(_:)), for: .touchUpInside)
        cell.addIntervalPresetButton.tag = index
        
        cell.transform = CGAffineTransform(scaleX: -1, y: 1)
        
        return cell
    }
    
    func reloadQuickAddCollection() {
        let firstQuickAddCellIndexPath = IndexPath(row: 1, section: 0)
        if let firstQuickAddCell = tableView.cellForRow(at: firstQuickAddCellIndexPath) as? EditTimerAddIntervalsTableViewCell {
            firstQuickAddCell.intervalsCollectionView.reloadData()
        }
        
        let secondQuickAddRow = dataSourceCount() + tableViewIntervalIndexOffset
        let secondQuickAddCellIndexPath = IndexPath(row: secondQuickAddRow, section: 0)
        if let secondQuickAddCell = tableView.cellForRow(at: secondQuickAddCellIndexPath) as? EditTimerAddIntervalsTableViewCell {
            secondQuickAddCell.intervalsCollectionView.reloadData()
        }
    }

}

