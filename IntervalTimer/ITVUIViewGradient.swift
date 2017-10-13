//
//  ITVUIViewGradient.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-19.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

//TODO: Are you using this?
@IBDesignable class ITVGradientView: UIView {
    @IBInspectable var color1 = UIColor(white: 1.0, alpha: 0.2).cgColor as CGColor
    @IBInspectable var color2 = UIColor(white: 1.0, alpha: 0.1).cgColor as CGColor
    @IBInspectable var color3 = UIColor.clear.cgColor as CGColor
    @IBInspectable var color4 = UIColor(white: 0.0, alpha: 0.1).cgColor as CGColor

    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [color1, color2, color3, color4]
        (layer as! CAGradientLayer).locations = [0.0, 0.01, 0.95, 1.0]
    }
}
