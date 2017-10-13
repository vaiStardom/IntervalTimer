//
//  ITVUIViewProgress.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-10-13.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

class ITVUIViewProgress: UIView {
    var progressBar = UIView()
    var frontLabel = UILabel()
    var backLabel = UILabel()
    var progressBarColor = UIColor()
    
    var thisProgressColor: UIColor {
        get { return progressBarColor }
        set {
            progressBarColor = newValue
        }
    }
    
    init(frame: CGRect, progressColor: UIColor) {
        super.init(frame: frame)
        thisProgressColor = progressColor
        setup()
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("------> ERROR ITVUIViewWarningAlert init(coder:) has not been implemented")
    }
    
    func setup(){
        backLabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.width-87, y: 0, width: 87, height: self.bounds.size.height))
        backLabel.font =  UIFont.monospacedDigitSystemFont(ofSize: 35, weight: UIFont.Weight.ultraLight)
        backLabel.textAlignment = .right
        backLabel.backgroundColor = UIColor.clear
        self.addSubview(backLabel)
        
        progressBar = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: self.bounds.size.height))
        progressBar.backgroundColor = progressBarColor
        progressBar.clipsToBounds = true
        self.addSubview(progressBar)
        
        frontLabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.width-87, y: 0, width: 87, height: self.bounds.size.height))
        frontLabel.font =  UIFont.monospacedDigitSystemFont(ofSize: 35, weight: UIFont.Weight.ultraLight)
        frontLabel.textAlignment = .right
        frontLabel.adjustsFontSizeToFitWidth = false
        frontLabel.backgroundColor = UIColor.clear
        frontLabel.autoresizingMask = UIViewAutoresizing(rawValue: 0x0)  // flexible right left and width
        progressBar.addSubview(frontLabel)
        
        lightColor(color: UIColor.white)
        darkColor(color: UIColor.black)
        
        self.translatesAutoresizingMaskIntoConstraints = true
    }
    func setProgress(progress: CGFloat, percent: Int){
        self.progressBar.frame = CGRect(x: 0, y: 0, width: progress * self.bounds.size.width, height: self.bounds.size.height)
        let progressText = "\(percent)%"
        self.frontLabel.text = progressText
        self.backLabel.text = progressText
    }
    
    func lightColor(color: UIColor) {
        self.backLabel.textColor = color
    }
    
    func darkColor(color: UIColor) {
        self.frontLabel.textColor = color
    }
}
