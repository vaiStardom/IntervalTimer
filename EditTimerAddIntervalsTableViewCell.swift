//
//  EditTimerAddIntervalsTableViewCell.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-22.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class EditTimerAddIntervalsTableViewCell: UITableViewCell {

    @IBOutlet weak var addIntervalButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var addIntervalImageView: UIImageView!
    @IBOutlet weak var addPresetIntervalImageView: UIImageView!
    
    @IBOutlet weak var intervalsCollectionView: UICollectionView!
    
    @IBOutlet weak var intervalsLabel: UILabel!
    @IBOutlet weak var addIntervalsLabel: UILabel!
    @IBOutlet weak var editLabel: UILabel!
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
