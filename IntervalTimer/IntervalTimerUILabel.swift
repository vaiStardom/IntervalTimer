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
        
        let label = UILabel(frame: NavigationBarCgRect.NewTimerTitle)
        label.textAlignment = NSTextAlignment.center
        label.font = NavigationBarFont.Title
        label.text = NavigationBarLitterals.NewTimer
        label.textColor = IntervalTimerColors.Orange
        
        return label
    }
    func navBarNewIntervalTitle() -> UILabel {
        
        let label = UILabel(frame: NavigationBarCgRect.NewTimerTitle)
        label.textAlignment = NSTextAlignment.center
        label.font = NavigationBarFont.Title
        label.text = NavigationBarLitterals.NewInterval
        label.textColor = IntervalTimerColors.Orange
        
        return label
    }
}
