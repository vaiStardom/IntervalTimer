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
        
        let label=UILabel(frame: NAVBAR_NEWTIMERTITLE_CGRECT)
        label.textAlignment=NSTextAlignment.center
        label.font = NAVBAR_TITLE_FONT
        label.text = NAVBAR_NEWTIMERTITLE
        label.textColor = IntervalTimerColors.Orange
        
        return label
    }
    func navBarNewIntervalTitle() -> UILabel {
        
        let label=UILabel(frame: NAVBAR_NEWTIMERTITLE_CGRECT)
        label.textAlignment=NSTextAlignment.center
        label.font = NAVBAR_TITLE_FONT
        label.text = NAVBAR_NEWINTERVALTITLE
        label.textColor = IntervalTimerColors.Orange
        
        return label
    }
}
