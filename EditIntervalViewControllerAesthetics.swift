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
        
        indicators.append((imageView: firstIndicatorImageView, activeFillColor: IntervalTimerColors.IntervalRed, inactiveFillColor: IntervalTimerColors.Black, borderColor: IntervalTimerColors.IntervalRed))
        indicators.append((imageView: secondIndicatorImageView, activeFillColor: IntervalTimerColors.IntervalGreen, inactiveFillColor: IntervalTimerColors.Black, borderColor: IntervalTimerColors.IntervalGreen))
        indicators.append((imageView: thirdIndicatorImageView, activeFillColor: IntervalTimerColors.IntervalYellow, inactiveFillColor: IntervalTimerColors.Black, borderColor: IntervalTimerColors.IntervalYellow))
        indicators.append((imageView: fourthIndicatorImageView, activeFillColor: IntervalTimerColors.IntervalBlue, inactiveFillColor: IntervalTimerColors.Black, borderColor: IntervalTimerColors.IntervalBlue))
        indicators.append((imageView: fifthIndicatorImageView, activeFillColor: IntervalTimerColors.IntervalWhite, inactiveFillColor: IntervalTimerColors.Black, borderColor: IntervalTimerColors.IntervalWhite))
        indicators.append((imageView: sixthIndicatorImageView, activeFillColor: IntervalTimerColors.IntervalPink, inactiveFillColor: IntervalTimerColors.Black, borderColor: IntervalTimerColors.IntervalPink))

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
