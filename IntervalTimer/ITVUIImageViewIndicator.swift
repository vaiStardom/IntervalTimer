//
//  IntervalTimerUIImageViewIndicator.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-06-25.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class ITVUIImageViewIndicator: UIImageView {
    var isSelected = false
    
    func roundImageView(){
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.size.height/2
    }
}
