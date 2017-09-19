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

    func swipe(recognizer: UIPanGestureRecognizer){
        
        if recognizer.state == .began {
            originalCenter = center
        }
        
        if recognizer.state  == .changed {
            let translation = recognizer.translation(in: self)
            center = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y)
            
            deleteOnSwipe = frame.origin.x < -frame.size.width / 2.0
            
            let cueAlpha = fabs(frame.origin.x) / (frame.size.width / 2.0)
            deleteLabel.alpha = cueAlpha
        }
        
        if recognizer.state == .ended {
            let originalFrame = CGRect(x: 0, y: frame.origin.y, width: bounds.size.width, height: bounds.size.height)
            
            if deleteOnSwipe {
                if swipeToDeleteDelegate != nil && timer != nil {
                    swipeToDeleteDelegate!.delete(timer: timer!)
                }

            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.frame = originalFrame
                })
            }
        }
    }
    
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
