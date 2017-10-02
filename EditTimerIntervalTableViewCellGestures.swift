//
//  EditTimerIntervalTableViewCellGestures.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-10-01.
//  Copyright © 2017 Paul Addy. All rights reserved.
//
import Foundation
import UIKit

extension EditTimerIntervalTableViewCell {

    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGestureRecognizer.translation(in: superview!)
            if fabs(translation.x) > fabs(translation.y) {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
}
