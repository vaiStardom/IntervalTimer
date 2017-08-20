//
//  EditIntervalViewControllerHelpers.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-20.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

//MARK: - Helpers
extension EditIntervalViewController {
    func manageSelectedColorIndicator(indicatorIndex: Int){
        indicators[indicatorIndex].imageView.isSelected = !indicators[indicatorIndex].imageView.isSelected
        selectedIndicator = indicators[indicatorIndex].imageView.isSelected
        unselectAllIndicators()
        indicators[indicatorIndex].imageView.isSelected = selectedIndicator
        if selectedIndicator == true {
            indicators[indicatorIndex].imageView.image = UIImage(named: indicators[indicatorIndex].activeImageName)
        }
    }
    func unselectAllIndicators(){
        for indicator in indicators {
            indicator.imageView.isSelected = false
            indicator.imageView.image = UIImage(named: indicator.inactiveImageName)
        }
    }
}

