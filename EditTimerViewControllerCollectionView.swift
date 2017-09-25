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
            cell.secondsLabel.text = timeOf_hms(seconds: theSeconds)
        } else {
            cell.secondsLabel.text = "empty"
        }
        
        cell.addIntervalPresetButton.addTarget(self, action: #selector(EditTimerViewController.addThisInterval(_:)), for: .touchUpInside)
        cell.addIntervalPresetButton.tag = index
        
        return cell
    }
}

