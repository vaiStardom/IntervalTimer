//
//  EditTimerIntervalTableViewCell.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-22.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class EditTimerIntervalTableViewCell: UITableViewCell {

    @IBOutlet weak var indicatorImageView: ITVUIImageViewIndicator!
    @IBOutlet weak var intervalNumberLabel: UILabel!
    @IBOutlet weak var intervalTimeLabel: UILabel!

    //swipe to delete vars
    var originalCenter = CGPoint()
    var deleteOnSwipe = false
    var intervalIndex: Int?
    var swipeToDeleteDelegate: ITVSwipeToDeleteIntervalProtocol?
    var deleteLabel: UILabel!
    let kUICuesMargin: CGFloat = 10.0
    var kUICuesWidth: CGFloat = 50.0

    override func awakeFromNib() {
        super.awakeFromNib()

        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(EditTimerIntervalTableViewCell.swipe))
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
