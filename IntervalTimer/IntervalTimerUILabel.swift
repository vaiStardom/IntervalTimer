//
//  IntervalTimerUILabel.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-06-25.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class IntervalTimerUILabel: UILabel {
    func navBarNewTimerTitle() -> UILabel {
        let label = createLabel(frame: NavigationBarCgRect.NewTimerTitle, textAlignment: NSTextAlignment.center, font: NavigationBarFont.Title, text: NavigationBarLitterals.NewTimer, color: IntervalTimerColors.Orange)
        return label
    }
    
    func navBarNewIntervalTitle() -> UILabel {
        
        let label = createLabel(frame: NavigationBarCgRect.NewTimerTitle, textAlignment: NSTextAlignment.center, font: NavigationBarFont.Title, text: NavigationBarLitterals.NewInterval, color: IntervalTimerColors.Orange)
        return label

    }
    func createLabel(frame: CGRect, textAlignment: NSTextAlignment, font: UIFont, text: String, color: UIColor) -> UILabel {
        let label = UILabel(frame: frame)
        label.textAlignment = textAlignment
        label.font = font
        label.text = text
        label.textColor = color
        
        return label
    }
    
    static func createLabel(frame: CGRect, font: UIFont, text: String, color: UIColor) -> UILabel {
        let label = UILabel(frame: frame)
        label.font = font
        label.text = text
        label.textColor = color
        
        return label
    }
}
