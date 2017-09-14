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
        
        indicators.append((imageView: firstIndicatorImageView, activeFillColor: Indicator.Red.uiColor(), inactiveFillColor: ITVColors.Black, borderColor: Indicator.Red.uiColor(), indicator: Indicator.Red))
        indicators.append((imageView: secondIndicatorImageView, activeFillColor: Indicator.Green.uiColor(), inactiveFillColor: ITVColors.Black, borderColor: Indicator.Green.uiColor(), indicator: Indicator.Green))
        indicators.append((imageView: thirdIndicatorImageView, activeFillColor: Indicator.Yellow.uiColor(), inactiveFillColor: ITVColors.Black, borderColor: Indicator.Yellow.uiColor(), indicator: Indicator.Yellow))
        indicators.append((imageView: fourthIndicatorImageView, activeFillColor: Indicator.Blue.uiColor(), inactiveFillColor: ITVColors.Black, borderColor: Indicator.Blue.uiColor(), indicator: Indicator.Blue))
        indicators.append((imageView: fifthIndicatorImageView, activeFillColor: Indicator.White.uiColor(), inactiveFillColor: ITVColors.Black, borderColor: Indicator.White.uiColor(), indicator: Indicator.White))
        indicators.append((imageView: sixthIndicatorImageView, activeFillColor: Indicator.Pink.uiColor(), inactiveFillColor: ITVColors.Black, borderColor: Indicator.Pink.uiColor(), indicator: Indicator.Pink))

        firstIndicatorImageView.roundImageView()
        secondIndicatorImageView.roundImageView()
        thirdIndicatorImageView.roundImageView()
        fourthIndicatorImageView.roundImageView()
        fifthIndicatorImageView.roundImageView()
        sixthIndicatorImageView.roundImageView()
    }
    func aesthetics_manageSelectedColorIndicator(indicatorIndex: Int?){
        
        if let theIndicatorIndex = indicatorIndex {
            indicators[theIndicatorIndex].imageView.isSelected = !indicators[theIndicatorIndex].imageView.isSelected
            selectedIndicator = indicators[theIndicatorIndex].imageView.isSelected
            aesthetics_unselectAllIndicators()
            indicators[theIndicatorIndex].imageView.isSelected = selectedIndicator
            if selectedIndicator == true {
                indicators[theIndicatorIndex].imageView.backgroundColor = indicators[theIndicatorIndex].activeFillColor
                indicators[theIndicatorIndex].imageView.layer.borderColor = indicators[theIndicatorIndex].borderColor.cgColor
                indicator = indicators[theIndicatorIndex].indicator
            } else {
                indicators[theIndicatorIndex].imageView.backgroundColor = indicators[theIndicatorIndex].inactiveFillColor
                indicators[theIndicatorIndex].imageView.layer.borderColor = indicators[theIndicatorIndex].borderColor.cgColor
                indicator = nil
            }
        } else {
            aesthetics_unselectAllIndicators()
        }
        compareFieldsWithSavedInterval()
    }
    func aesthetics_unselectAllIndicators(){
        for indicator in indicators {
            indicator.imageView.isSelected = false
            indicator.imageView.backgroundColor = indicator.inactiveFillColor
            indicator.imageView.layer.borderColor = indicator.borderColor.cgColor
        }
    }
}
