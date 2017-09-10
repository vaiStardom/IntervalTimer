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
        
        indicators.append((imageView: firstIndicatorImageView, activeFillColor: ITVColors.IntervalRed, inactiveFillColor: ITVColors.Black, borderColor: ITVColors.IntervalRed))
        indicators.append((imageView: secondIndicatorImageView, activeFillColor: ITVColors.IntervalGreen, inactiveFillColor: ITVColors.Black, borderColor: ITVColors.IntervalGreen))
        indicators.append((imageView: thirdIndicatorImageView, activeFillColor: ITVColors.IntervalYellow, inactiveFillColor: ITVColors.Black, borderColor: ITVColors.IntervalYellow))
        indicators.append((imageView: fourthIndicatorImageView, activeFillColor: ITVColors.IntervalBlue, inactiveFillColor: ITVColors.Black, borderColor: ITVColors.IntervalBlue))
        indicators.append((imageView: fifthIndicatorImageView, activeFillColor: ITVColors.IntervalWhite, inactiveFillColor: ITVColors.Black, borderColor: ITVColors.IntervalWhite))
        indicators.append((imageView: sixthIndicatorImageView, activeFillColor: ITVColors.IntervalPink, inactiveFillColor: ITVColors.Black, borderColor: ITVColors.IntervalPink))

        firstIndicatorImageView.roundImageView()
        secondIndicatorImageView.roundImageView()
        thirdIndicatorImageView.roundImageView()
        fourthIndicatorImageView.roundImageView()
        fifthIndicatorImageView.roundImageView()
        sixthIndicatorImageView.roundImageView()
        
        aesthetics_unselectAllIndicators()
    }
    func aesthetics_manageSelectedColorIndicator(indicatorIndex: Int){
        indicators[indicatorIndex].imageView.isSelected = !indicators[indicatorIndex].imageView.isSelected
        selectedIndicator = indicators[indicatorIndex].imageView.isSelected
        aesthetics_unselectAllIndicators()
        indicators[indicatorIndex].imageView.isSelected = selectedIndicator
        if selectedIndicator == true {
            //indicators[indicatorIndex].imageView.image = UIImage(named: indicators[indicatorIndex].activeImageName)
            indicators[indicatorIndex].imageView.backgroundColor = indicators[indicatorIndex].activeFillColor
            indicators[indicatorIndex].imageView.layer.borderColor = indicators[indicatorIndex].borderColor.cgColor
        }
    }
    func aesthetics_unselectAllIndicators(){
        for indicator in indicators {
            indicator.imageView.isSelected = false
            indicator.imageView.backgroundColor = indicator.inactiveFillColor
            indicator.imageView.layer.borderColor = indicator.borderColor.cgColor
        }
    }
}
