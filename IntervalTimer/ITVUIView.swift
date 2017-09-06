//
//  ITVUIView.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-03.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class ITVUIView: UIView {
    
}

extension UIView {
    class func fromNib<T : UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func shake() {
        self.transform = CGAffineTransform(translationX: 30, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
