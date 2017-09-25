//
//  EditTimerTopTableViewCell.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-22.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class EditTimerTopTableViewCell: UITableViewCell {

    @IBOutlet weak var showWeatherSwitch: UISwitch!
    @IBOutlet weak var timerNameTextField: UITextField!
    @IBOutlet weak var warningButton: UIButton!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var warningImageView: UIImageView!
    @IBOutlet weak var weatherTemperatureLabel: UILabel!
    @IBOutlet weak var showWeatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureSegmentedControl: UISegmentedControl!
    @IBOutlet weak var weatherActivityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
