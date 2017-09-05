//
//  ITVWarningLocationManagerDidFailView.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-05.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class ITVWarningLocationManagerDidFailView: UIView {

    @IBOutlet weak var dismissWarningButton: UIButton!
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var visualEffectsView: UIVisualEffectView!
    
    func setupDefault()
    {
        self.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        self.informationView.center = self.center
        self.informationView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        self.informationView.layer.cornerRadius = 5
        self.informationView.alpha = 0.0
        self.visualEffectsView.isHidden = false
        self.visualEffectsView.effect = nil
        self.tag = 1
    }

}
