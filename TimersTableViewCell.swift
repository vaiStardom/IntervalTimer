//
//  TimersTableViewCell.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-20.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class TimersTableViewCell: UITableViewCell {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var startTimerImageView: UIImageView!
    @IBOutlet weak var startTimerButton: UIButton!
    
    var originalCenter = CGPoint()
    var deleteOnSwipe = false
    var timer: ITVTimer?
    
    var swipeToDeleteDelegate: ITVSwipeToDeleteTimerProtocol?
    
    var deleteLabel: UILabel!
    
    let kUICuesMargin: CGFloat = 10.0
    var kUICuesWidth: CGFloat = 50.0

    override func awakeFromNib() {
        super.awakeFromNib()

        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(TimersTableViewCell.swipe))
        recognizer.delegate = self
        addGestureRecognizer(recognizer)
        
        deleteLabel = ITVUILabel().swipeDeleteLabel()
        deleteLabel.text = Litterals.Delete
        deleteLabel.textAlignment = .left

        addSubview(deleteLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        deleteLabel.frame = CGRect(x: bounds.size.width + kUICuesMargin, y: 0, width: bounds.size.width, height: bounds.size.height)
    }
}
