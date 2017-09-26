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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}