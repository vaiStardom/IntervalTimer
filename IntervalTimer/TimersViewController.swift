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

}
//MARK: - Actions
extension TimersViewController {
    func addTimer(){
        //performSegue(withIdentifier: "TimersToEditTimer", sender: nil)
        performSegue(withIdentifier: "TimersToTimer", sender: nil)
    }
}
//MARK: - Aesthetics
extension TimersViewController {
}
//MARK: - Life-Cycle
extension TimersViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
    }
}
//MARK: - Navigation Bar Management
extension TimersViewController {
    func configureNavBar(){
        let leftTitle = leftTitleLabel()
        self.navigationItem.leftBarButtonItems = [leftTitle]
        
        let negativeSpace = negativeSpc()
        let addButton = addBtn()
        self.navigationItem.rightBarButtonItems = [negativeSpace, addButton]
    }
    func leftTitleLabel() -> UIBarButtonItem {
        return IntervalTimerUIBarButtonItem().leftTitle()
    }
    func addBtn() -> UIBarButtonItem {
        return IntervalTimerUIBarButtonItem().addButton(target: self, selector: #selector(TimersViewController.addTimer))
    }
    func negativeSpc() -> UIBarButtonItem{
        return IntervalTimerUIBarButtonItem().negativeSpace()
    }
}
