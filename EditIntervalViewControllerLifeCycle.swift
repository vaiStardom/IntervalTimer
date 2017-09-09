//
//  EditIntervalViewControllerLifeCycle.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-30.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

//MARK: Life-cycle
extension EditIntervalViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        
        
        secondTextField1.becomeFirstResponder()
        
        hourTextField2.delegate = self
        hourTextField1.delegate = self
        minuteTextField2.delegate = self
        minuteTextField1.delegate = self
        secondTextField2.delegate = self
        secondTextField1.delegate = self
        
        hourTextField2.text = zeroWidthSpace
        hourTextField1.text = zeroWidthSpace
        minuteTextField2.text = zeroWidthSpace
        minuteTextField1.text = zeroWidthSpace
        secondTextField2.text = zeroWidthSpace
        secondTextField1.text = zeroWidthSpace
        
        textFields.append(hourTextField2)
        textFields.append(hourTextField1)
        textFields.append(minuteTextField2)
        textFields.append(minuteTextField1)
        textFields.append(secondTextField2)
        textFields.append(secondTextField1)
        
        aesthetics_initial()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
