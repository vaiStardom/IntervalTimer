//
//  EditTimerViewController.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-06-25.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class EditTimerViewController: UIViewController {
    
}
//MARK: - Actions
extension EditTimerViewController {
    @IBAction func addInterval(_ sender: Any) {
        performSegue(withIdentifier: "EditTimerToEditInterval", sender: nil)
    }
    func back(){
        _ = navigationController?.popViewController(animated: true)
    }
    func cancel(){
        _ = navigationController?.popViewController(animated: true)
    }
}
//MARK: - Life-cycle
extension EditTimerViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
//MARK: - Navigation Bar Management
extension EditTimerViewController {
    func configureNavBar(){
        self.navigationItem.hidesBackButton = true
        
        let backButton = IntervalTimerUIBarButtonItem().backButton(target: self, selector: #selector(EditTimerViewController.back))
        self.navigationItem.leftBarButtonItems = [backButton]
                
        let label = IntervalTimerUILabel().navBarNewTimerTitle()
        self.navigationItem.titleView = label
        
        let negativeSpace = IntervalTimerUIBarButtonItem().negativeSpace()
        let cancelButton = IntervalTimerUIBarButtonItem().cancelButton(target: self, selector: #selector(EditTimerViewController.cancel))
        self.navigationItem.rightBarButtonItems = [negativeSpace, cancelButton]
    }
}
