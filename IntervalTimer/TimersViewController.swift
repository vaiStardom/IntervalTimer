//
//  ViewController.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-06-25.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class TimersViewController: UIViewController {

    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
//    @IBOutlet weak var weatherIconImageView: UIImageView!
//    @IBOutlet weak var temperatureLabel: UILabel!

}
//MARK: - Life-Cycle
extension TimersViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
