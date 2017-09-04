//
//  ITVWarningAllowLocationServicesView.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-03.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class ITVWarningAllowLocationServicesView: UIView {
    @IBOutlet weak var dismissWarningButton: UIButton!
    @IBOutlet weak var openSettingsButton: UIButton!
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var visualEffectsView: UIVisualEffectView!
    
    @IBAction func openSettings(_ sender: Any) {
        UIApplication.shared.open(URL(string:UIApplicationOpenSettingsURLString)!)   
    }    
}
