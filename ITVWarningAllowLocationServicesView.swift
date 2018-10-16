//
//  testView.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-06.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class ITVWarningAllowLocationServicesView: UIView {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var openSettingsButton: UIButton!

    @IBAction func openSettings(_ sender: Any) {
        UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
    }
}

