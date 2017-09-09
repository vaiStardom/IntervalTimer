//
//  EditIntervalViewControllerAesthetics.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-30.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

//MARK: - Aesthetics
extension EditIntervalViewController {
    func aesthetics_initial(){
        
        hourTextField2.layer.borderColor = ITVColors.Orange.cgColor
        hourTextField1.layer.borderColor = ITVColors.Orange.cgColor
        minuteTextField2.layer.borderColor = ITVColors.Orange.cgColor
        minuteTextField1.layer.borderColor = ITVColors.Orange.cgColor
        secondTextField2.layer.borderColor = ITVColors.Orange.cgColor
        secondTextField1.layer.borderColor = ITVColors.Orange.cgColor

        hourTextField2.layer.borderWidth = 1.5
        hourTextField1.layer.borderWidth = 1.5
        minuteTextField2.layer.borderWidth = 1.5
        minuteTextField1.layer.borderWidth = 1.5
        secondTextField2.layer.borderWidth = 1.5
        secondTextField1.layer.borderWidth = 1.5

        hourTextField2.layer.cornerRadius = 9
        hourTextField1.layer.cornerRadius = 9
        minuteTextField2.layer.cornerRadius = 9
        minuteTextField1.layer.cornerRadius = 9
        secondTextField2.layer.cornerRadius = 9
        secondTextField1.layer.cornerRadius = 9
        
        hourTextField2.tintColor = ITVColors.Orange
        hourTextField1.tintColor = ITVColors.Orange
        minuteTextField2.tintColor = ITVColors.Orange
        minuteTextField1.tintColor = ITVColors.Orange
        secondTextField2.tintColor = ITVColors.Orange
        secondTextField1.tintColor = ITVColors.Orange
        
        indicators.append((imageView: firstIndicatorImageView, activeFillColor: Indicator.Red, inactiveFillColor: ITVColors.Black, borderColor: Indicator.Red))
        indicators.append((imageView: secondIndicatorImageView, activeFillColor: Indicator.Green, inactiveFillColor: ITVColors.Black, borderColor: Indicator.Green))
        indicators.append((imageView: thirdIndicatorImageView, activeFillColor: Indicator.Yellow, inactiveFillColor: ITVColors.Black, borderColor: Indicator.Yellow))
        indicators.append((imageView: fourthIndicatorImageView, activeFillColor: Indicator.Blue, inactiveFillColor: ITVColors.Black, borderColor: Indicator.Blue))
        indicators.append((imageView: fifthIndicatorImageView, activeFillColor: Indicator.White, inactiveFillColor: ITVColors.Black, borderColor: Indicator.White))
        indicators.append((imageView: sixthIndicatorImageView, activeFillColor: Indicator.Pink, inactiveFillColor: ITVColors.Black, borderColor: Indicator.Pink))

        firstIndicatorImageView.roundImageView()
        secondIndicatorImageView.roundImageView()
        thirdIndicatorImageView.roundImageView()
        fourthIndicatorImageView.roundImageView()
        fifthIndicatorImageView.roundImageView()
        sixthIndicatorImageView.roundImageView()
        
        aesthetics_unselectAllIndicators()
    }
    func aesthetics_editingMode(){
        
        
    }
    
    func aesthetics_manageSelectedColorIndicator(indicatorIndex: Int){
        indicators[indicatorIndex].imageView.isSelected = !indicators[indicatorIndex].imageView.isSelected
        isSelectedIndicator = indicators[indicatorIndex].imageView.isSelected
        aesthetics_unselectAllIndicators()
        indicators[indicatorIndex].imageView.isSelected = isSelectedIndicator
        if isSelectedIndicator == true {
            selectedIndicator = indicators[indicatorIndex].activeFillColor
            indicators[indicatorIndex].imageView.backgroundColor = indicators[indicatorIndex].activeFillColor.uiColor()
            indicators[indicatorIndex].imageView.layer.borderColor = indicators[indicatorIndex].borderColor.uiColor().cgColor
            
        }
    }
    func aesthetics_unselectAllIndicators(){
        for indicator in indicators {
            indicator.imageView.isSelected = false
            indicator.imageView.backgroundColor = indicator.inactiveFillColor
            indicator.imageView.layer.borderColor = indicator.borderColor.uiColor().cgColor
        }
    }
}
