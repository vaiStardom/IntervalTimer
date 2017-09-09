//
//  ITVUIButton.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-05.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class ITVUIButton: UIButton {

    static func createButton(frame: CGRect, target: UIViewController, selector: Selector) -> UIButton {
        
        let button = UIButton(frame: frame)
        button.addTarget(target, action: selector, for: .touchUpInside)
        
        return button
    }

}
