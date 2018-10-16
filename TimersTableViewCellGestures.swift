//
//  TimersTableViewCellGestures.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-19.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

extension TimersTableViewCell {
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGestureRecognizer.translation(in: superview!)
            if abs(translation.x) > abs(translation.y) {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
}
