//
//  TimersTableViewCell.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-20.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit
//import QuartzCore

class TimersTableViewCell: UITableViewCell {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var startTimerImageView: UIImageView!
    @IBOutlet weak var startTimerButton: UIButton!
    
    @IBOutlet weak var itvGradientView: ITVGradientView!
    
//    let gradientLayer = CAGradientLayer()


//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        gradientLayer.frame = bounds
//        let color1 = UIColor(white: 1.0, alpha: 0.2).cgColor as CGColor
//        let color2 = UIColor(white: 1.0, alpha: 0.1).cgColor as CGColor
//        let color3 = UIColor.clear.cgColor as CGColor
//        let color4 = UIColor(white: 0.0, alpha: 0.1).cgColor as CGColor
//        
//        gradientLayer.colors = [color1, color2, color3, color4]
//        gradientLayer.locations = [0.0, 0.01, 0.95, 1.0]
//        layer.insertSublayer(gradientLayer, at: 0)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        gradientLayer.frame = bounds
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
