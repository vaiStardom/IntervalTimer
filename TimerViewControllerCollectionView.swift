//
//  TimerViewControllerCollectionView.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-17.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

extension TimerViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func configureCollectionView(){
        //TODO: relaod collection view coming back from edit timer

        let nibName = UINib(nibName: "TimerIndicatorCollectionViewCell", bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: "IndicatorCell")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return intervalsToRun.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IndicatorCell", for: indexPath) as! TimerIndicatorCollectionViewCell
        
        let index = indexPath.row
        
        cell.indicatorImageView.roundImageView()
        cell.indicatorImageView.backgroundColor = intervalsToRun[index].thisIndicator.uiColor()
        
        return cell
    }

}
