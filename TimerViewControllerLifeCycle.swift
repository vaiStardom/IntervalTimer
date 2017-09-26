//
//  TimerViewControllerLifeCycle.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-24.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

//MARK: Life-cycle
extension TimerViewController{
    
    override func viewDidAppear(_ animated: Bool) {
        configureCollectionView()
        collectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNotifications() //will register at first weather use
        loadTimer()
        loadWeather()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
