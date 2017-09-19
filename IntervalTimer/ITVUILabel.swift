//
//  ITVUILabel.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-06-25.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class ITVUILabel: UILabel {
    func navBarNewTimerTitle() -> UILabel {
        let label = createLabel(frame: NavigationBarCgRect.NewTimerTitle, textAlignment: NSTextAlignment.center, font: NavigationBarFont.Title, text: Litterals.NewTimer, color: ITVColors.Orange)
        return label
    }
    
    func navBarNewIntervalTitle() -> UILabel {
        
        let label = createLabel(frame: NavigationBarCgRect.NewTimerTitle, textAlignment: NSTextAlignment.center, font: NavigationBarFont.Title, text: Litterals.NewInterval, color: ITVColors.Orange)
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
    
    func swipeDeleteLabel() -> UILabel {
        let label = UILabel(frame: CGRect.null)
        label.textColor = UIColor.white
        label.font = ViewFont.ContentLabel
        label.backgroundColor = UIColor.red
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
